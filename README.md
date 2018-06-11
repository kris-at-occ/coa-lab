# coa-lab
Install COA Exam Lab using Devstack

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

Name: devstack
Region: most suitable
Machine type: 2 vCPUs 7.5 GB memory (n1-standard-2) or 2 vCPUs 13 GB memory (n1-highmem-2)
Boot disk: Ubuntu 16.04, 30GB disk (Standard or SSD)
Firewall: Allow HTTP and HTTPS traffic
SSH Key (if you like)
Open SSH console and clone this repo:

git clone https://github.com/kris-at-occ/devstack-gcp

Run script to install Devstack COA Lab:

sh devstack-gcp/devstack-coa.sh

Run script to install Devstack with Pike:

sh devstack-gcp/devstack-pike.sh

Run script to install Devstack with latest master:

sh devstack-gcp/devstack-latest.sh

The script displays Horizon Dashboard URL in the very last line of the output.

Enjoy!
