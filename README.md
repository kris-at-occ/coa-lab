# coa-lab
Install COA Exam Lab using Devstack

Here is the collection of Scripts and Files to install all-in-one OpenStack Lab for COA Exam preparation & learning.
You can install your coa-lab in VirtualBox with Vagrant or in Google Compute Engine (part of Google Cloud Platform).

You will install Devstack Ocata Release (closest we can still get to Newton, using official repos), with following Projects:

- Keystone
- Glance
- Nova
- Cinder
- Neutron
- Swift
- Heat
- Horizon

The Horizon Dashboard URL is display at the end of the script output.
To use OpenStack Client do:

`cd coa-lab`
`source devstack/openrc admin admin`
`openstack user list`
or
`source devstack/openrc demo demo`
`openstack image list`

<b>Install Devstack in VirtualBox/Vagrant</b>

Install VirtualBox from https://www.virtualbox.org/
Install Vagrant from https://www.vagrantup.com/

Clone this repo:

`git clone https://github.com/kris-at-occ/coa-lab`

Virtual Machine can use bridged network adapter (NIC #2) or host-only network, based on your preference. Check Vagrantfile for configuration.

Go to coa-lab directory and run Vagrant:

`cd coa-lab`
`vagrant up`

Horizon Dashboard URL is printed in last line of output.

To access Console and use OpenStack client, go to `coa-lab` directory and:

`vagrant ssh coa-lab`

<b>Install Devstack in GCP Virtual Machine</b>

In GCP Console go to VPC Network -> Firewall rules

Create Firewall Rule
Name: allownovnc
Ingress
Allow
Targets: All Instances
Source IP ranges: 0.0.0.0/0
Protocols and Ports: tcp/6080
In Compute Engine Create a new VM

Name: `coa-lab`
Region: most suitable
Machine type: 2 vCPUs 7.5 GB memory (n1-standard-2) or 2 vCPUs 13 GB memory (n1-highmem-2)
Boot disk: Ubuntu 16.04, 30GB disk (Standard or SSD)
Firewall: Allow HTTP and HTTPS traffic
SSH Key (if you like)
Open SSH console and clone this repo:

`git clone https://github.com/kris-at-occ/coa-lab`

Run script to install Devstack COA Lab:

`cd coa-lab`
`sh coa-gcp.sh`

The script displays Horizon Dashboard URL in the very last line of the output.
To access Console and use OpenStack Client, open `coa-lab` SSH window in GCP Console.

Enjoy!
