
# Kubernetes Learning Journey
# Phase 1 - Module 2
# Kubernetes Cluster Installation using kubeadm

---

# Objective

In this module, we installed and configured a real multi-node Kubernetes cluster using kubeadm on AWS EC2 instances.

We learned:
- container runtime installation
- Kubernetes tools installation
- cluster initialization
- worker node joining
- Kubernetes networking

---

# Cluster Architecture

```text
                Kubernetes Cluster
------------------------------------------------
|                                              |
|   Master Node        Worker Node 1          |
|                                              |
|                    Worker Node 2             |
------------------------------------------------
```

---

# Kubernetes Components Used

| Component | Purpose |
|---|---|
| containerd | Container runtime |
| kubeadm | Cluster bootstrap tool |
| kubelet | Node agent |
| kubectl | Kubernetes command line tool |
| Calico | CNI networking plugin |

---

# Step 1 - Login to EC2 Nodes

## Master Node

```bash
ssh -i k8s-key.pem ubuntu@<MASTER-IP>
```

## Worker Node 1

```bash
ssh -i k8s-key.pem ubuntu@<WORKER1-IP>
```

## Worker Node 2

```bash
ssh -i k8s-key.pem ubuntu@<WORKER2-IP>
```

---

# Step 2 - Disable Swap

## Temporary Disable

```bash
sudo swapoff -a
```

## Permanent Disable

```bash
sudo sed -i '/ swap / s/^.*$/#\1/g' /etc/fstab
```

---

# Why Swap is Disabled

Kubernetes requires stable memory management.

Swap can cause:
- kubelet instability
- scheduling problems
- performance issues

---

# Step 3 - Enable Kernel Modules

## Create Configuration File

```bash
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
```

## Load Modules

```bash
sudo modprobe overlay
sudo modprobe br_netfilter
```

---

# Step 4 - Configure Kubernetes Networking

## Configure sysctl Parameters

```bash
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
```

## Apply Changes

```bash
sudo sysctl --system
```

---

# Why Networking Configuration is Required

These settings allow:
- pod-to-pod communication
- packet forwarding
- Kubernetes networking functionality

---

# Step 5 - Install containerd

## Install containerd

```bash
sudo apt update -y
sudo apt install -y containerd
```

## Start Service

```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
```

## Verify

```bash
systemctl status containerd
```

---

# What is containerd?

containerd is a container runtime responsible for:
- pulling images
- starting containers
- stopping containers
- managing container lifecycle

---

# Step 6 - Add Kubernetes Repository

## Install Required Packages

```bash
sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```

---

# Add Kubernetes GPG Key

```bash
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

---

# Add Kubernetes Repository

```bash
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | \
sudo tee /etc/apt/sources.list.d/kubernetes.list
```

---

# Step 7 - Install Kubernetes Tools

```bash
sudo apt update -y

sudo apt install -y kubelet kubeadm kubectl
```

## Hold Package Versions

```bash
sudo apt-mark hold kubelet kubeadm kubectl
```

---

# Kubernetes Tool Explanation

## kubeadm

Purpose:
- bootstrap Kubernetes cluster

---

## kubelet

Purpose:
- node agent
- communicates with API server
- manages pods and containers

---

## kubectl

Purpose:
- command line tool for cluster management

---

# Step 8 - Initialize Master Node

Run only on master node:

```bash
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

---

# Important Output

kubeadm generates:
```text
kubeadm join ...
```

This command is used by worker nodes to join the cluster.

Save this command carefully.

---

# Step 9 - Configure kubectl Access

Run on master node:

```bash
mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

# Verify Cluster

```bash
kubectl get nodes
```

Initially master may show:
```text
NotReady
```

because networking plugin is not installed yet.

---

# Step 10 - Install Calico CNI Plugin

```bash
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/calico.yaml
```

---

# What is a CNI Plugin?

CNI = Container Network Interface

Purpose:
- pod networking
- IP allocation
- routing
- communication between pods

Without CNI:
- pods cannot communicate
- cluster remains unhealthy

---

# Step 11 - Join Worker Nodes

Run join command on worker nodes.

Example:

```bash
sudo kubeadm join <MASTER-IP>:6443 \
--token <TOKEN> \
--discovery-token-ca-cert-hash sha256:<HASH>
```

---

# Step 12 - Verify Final Cluster

```bash
kubectl get nodes
```

Expected Output:

```text
NAME            STATUS   ROLES
k8s-master      Ready    control-plane
k8s-worker1     Ready    <none>
k8s-worker2     Ready    <none>
```

---

# Important Troubleshooting Commands

## View Nodes

```bash
kubectl get nodes
```

---

# View Pods

```bash
kubectl get pods -A
```

---

# Describe Node

```bash
kubectl describe node k8s-worker1
```

---

# View kubelet Logs

```bash
journalctl -u kubelet -f
```

---

# Real DevOps Concepts Learned

- Kubernetes architecture
- Multi-node cluster setup
- Container runtime
- Cluster networking
- kubeadm workflow
- Node registration
- Control plane setup
- CNI networking
- Linux kernel networking

---

# Interview Questions

## 1. What is kubeadm?

kubeadm is a tool used to bootstrap Kubernetes clusters.

---

## 2. What is kubelet?

kubelet is a node agent that manages containers and communicates with the Kubernetes API server.

---

## 3. Why do we need containerd?

containerd is required to run containers inside Kubernetes.

---

## 4. Why is swap disabled?

Swap can affect Kubernetes scheduling and memory stability.

---

## 5. Why do we need a CNI plugin?

CNI plugins provide networking between Kubernetes pods.

---

# Key Takeaways

- Kubernetes clusters require networking setup
- kubeadm simplifies cluster installation
- Worker nodes must join the master node
- containerd is the container runtime
- kubelet manages node operations
- CNI is essential for pod communication

---

# Next Module

# Phase 1 - Module 3

Topics:
- Pods
- Deployments
- ReplicaSets
- Services
- YAML manifests
- Scaling applications
- NGINX deployment
- Kubernetes workloads

---

# Author

Swapnil Girme
DevOps & Kubernetes Learning Journey