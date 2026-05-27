#!/bin/bash

# ==========================================================
# Kubernetes Cluster Installation Script using kubeadm
# Author: Swapnil Girme
# Purpose: Install Kubernetes components on EC2 instances
# ==========================================================

set -e

echo "==============================================="
echo "STEP 1 - Updating System Packages"
echo "==============================================="

sudo apt update -y
sudo apt upgrade -y

echo "==============================================="
echo "STEP 2 - Disabling Swap"
echo "==============================================="

sudo swapoff -a

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "Swap disabled successfully"

echo "==============================================="
echo "STEP 3 - Loading Kernel Modules"
echo "==============================================="

sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

echo "Kernel modules loaded"

echo "==============================================="
echo "STEP 4 - Configuring Kubernetes Networking"
echo "==============================================="

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

echo "Networking configured successfully"

echo "==============================================="
echo "STEP 5 - Installing containerd"
echo "==============================================="

sudo apt install -y containerd

sudo mkdir -p /etc/containerd

containerd config default | sudo tee /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

echo "containerd installed successfully"

echo "==============================================="
echo "STEP 6 - Installing Required Packages"
echo "==============================================="

sudo apt install -y apt-transport-https ca-certificates curl gpg

echo "Packages installed successfully"

echo "==============================================="
echo "STEP 7 - Adding Kubernetes Repository"
echo "==============================================="

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | \
sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -y

echo "Kubernetes repository added"

echo "==============================================="
echo "STEP 8 - Installing Kubernetes Components"
echo "==============================================="

sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

echo "Kubernetes components installed successfully"

echo "==============================================="
echo "STEP 9 - Enabling kubelet"
echo "==============================================="

sudo systemctl enable kubelet

echo "kubelet enabled"

echo "==============================================="
echo "INSTALLATION COMPLETED SUCCESSFULLY"
echo "==============================================="

echo ""
echo "Installed Components:"
echo "1. containerd"
echo "2. kubeadm"
echo "3. kubelet"
echo "4. kubectl"
echo ""

echo "Next Steps:"
echo "1. Run kubeadm init on master node"
echo "2. Install Calico CNI"
echo "3. Join worker nodes"
echo ""

echo "Verification Commands:"
echo "containerd --version"
echo "kubeadm version"
echo "kubectl version --client"
echo "systemctl status kubelet"

echo ""
echo "Kubernetes node setup completed successfully"
