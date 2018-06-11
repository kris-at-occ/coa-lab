#! /bin/sh

export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

# Prepare the system

cat <<- EOF >> /etc/network/interfaces

auto enp0s8
iface enp0s8 inet dhcp
EOF

ifdown enp0s8
ifup enp0s8

# Get External IP address to be used for Horizon access

externalIp=$(ip addr show enp0s8 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

if [ -z "$externalIp" ]; then
   echo "No External IP!"
   echo "Displaying 'ip a'"
   ip a
   exit 1
fi

# Install Software

DEBIAN_FRONTEND=noninteractive sudo apt-get -y update
DEBIAN_FRONTEND=noninteractive sudo apt-get upgrade -y
sudo apt-get install -y git

git clone https://git.openstack.org/openstack-dev/devstack -b stable/ocata

# Prepare local.conf

cat <<- EOF > devstack/local.conf
[[local|localrc]]
# Set basic passwords
ADMIN_PASSWORD=openstack
DATABASE_PASSWORD=openstack
RABBIT_PASSWORD=openstack
SERVICE_PASSWORD=openstack
HOST_IP=$externalIp
# Enable Heat
enable_plugin heat https://git.openstack.org/openstack/heat stable/ocata
# Enable Swift
enable_service s-proxy s-object s-container s-account
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5
SWIFT_REPLICAS=1
SWIFT_DATA_DIR=\$DEST/data/swift
# Enable Cinder Backup
enable_service c-bak
EOF

# Set proper ownership of devstack directory

chown -R vagrant:vagrant devstack

# Run stash.sh as user vagrant

cd devstack
sudo su -c "./stack.sh" -s /bin/sh vagrant

# Enable Cinder Backup Dashboard in Horizon

sudo sed -i -e 's/'\''enable_backup'\'': False,/'\''enable_backup'\'': True,/g' /opt/stack/horizon/openstack_dashboard/local/local_settings.py
sudo service apache2 reload

echo "Horizon Dashboard available at http://$externalIp/dashboard"
