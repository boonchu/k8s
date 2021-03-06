#!/bin/bash
# Installs flagship

# set -x

sudo -v

# Delete old version
echo Remove old flagship
cd
# brew reinstall gnu-sed --with-default-names
flagship -s
flagship -r
rm -rf /opt/flagship
rm -rf ~/.flagship

# Clone k8s and flagship - k8s because has some k8s cleanup and osh that can
# run on top of flagship
echo Clone repos - passwords may be needed
# git clone https://github.com/RichWellum/k8s.git
git clone https://github.com/v1k0d3n/flagship.git ${HOME}/flagship \
    && sudo mv ${HOME}/flagship /opt/ && cd /opt/flagship

# To be converted to python
# Update and clean ubuntu
echo Upgrade ubuntu
sudo apt update && sudo apt full-upgrade -y && \
    sudo apt autoremove -y && sudo apt autoclean

# Add paths to Flagship binaries
echo Set paths
export PATH="/opt/flagship:$PATH"
export PATH="/opt/flagship/bin:$PATH"

# Install pip
echo Install pip
curl -L https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
sudo python /tmp/get-pip.py

# Add to installs missing in flagshirt
echo Install missing packages
sudo apt install jq -y
pip install python-openstackclient

# Start flagship
echo Start flagship
read -p "Modify flagship.yaml now, press [Enter] key to continue.."
flagship -i

# Start servers add repos
echo Start helm server and add repo
helm serve &
helm repo add local http://localhost:8879/charts

#Basic info about k8s
echo display basic k8s info
# Determine IP and port information from Service:
echo Determine IP and port information from Service:
kubectl get svc -n kube-system
kubectl get svc -n openstack

# See running pods
echo See running pods
  kubectl get pods --all-namespaces

# View all k8’s namespaces:
echo View all k8’s namespaces:
kubectl get namespaces

# View all deployed services:
echo View all deployed services:
kubectl get deployment -n kube-system

# View configuration maps:
echo View configuration maps:
kubectl get configmap -n kube-system

# General Cluster information:
echo General Cluster information:
kubectl cluster-info

# View all jobs:
echo  View all jobs:
kubectl get jobs --all-namespaces

# View all deployments:
echo View all deployments:
kubectl get deployments --all-namespaces

### Helm ###

# View deployed Helm Charts
echo View deployed Helm Charts
helm list
