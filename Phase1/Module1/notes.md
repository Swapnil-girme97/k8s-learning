
# Kubernetes Learning Journey
# Phase 1 - Module 1
# AWS EC2 Infrastructure Setup for Kubernetes Cluster

---

# Objective

In this module, we created the base infrastructure required for setting up a Kubernetes cluster using AWS EC2 instances.

This setup provides a real-world production-style environment for learning Kubernetes and DevOps practices.

---

# Architecture Overview

text
                Kubernetes Cluster
------------------------------------------------
|                                              |
|   Master Node        Worker Node 1          |
|                                              |
|                    Worker Node 2             |
------------------------------------------------


---

# Why We Are Using EC2 Instead of Local Laptop

My laptop has:
- 4GB RAM
- Limited resources

Running Kubernetes locally on low RAM systems causes:
- Slow performance
- Cluster crashes
- High CPU usage
- Poor learning experience

Using AWS EC2 provides:
- Better performance
- Real cloud experience
- Production-style setup
- Hands-on DevOps learning

---

# AWS Region Selection

Selected Region:
text
ap-south-1 (Mumbai)


Reason:
- Lower latency for India region
- Better connectivity
- Faster access

---

# EC2 Nodes Configuration

| Node Name | Purpose |
|---|---|
| k8s-master | Kubernetes Control Plane |
| k8s-worker1 | Worker Node |
| k8s-worker2 | Worker Node |

---

# Recommended EC2 Specifications

## Instance Type
text
t3.medium


## Minimum Supported
text
t2.medium


## Operating System
text
Ubuntu Server 24.04 LTS


## Storage
text
20 GB gp3


---

# Security Group Configuration

Security Group Name:
text
k8s-cluster-sg


## Inbound Rules

| Type | Port | Purpose |
|---|---|---|
| SSH | 22 | Remote login |
| Custom TCP | 6443 | Kubernetes API Server |
| Custom TCP | 30000-32767 | NodePort Services |
| All Traffic | All | Node-to-Node Communication |

---

# Important Kubernetes Port

## Port 6443

Used by:
- Kubernetes API Server

Purpose:
- Communication between kubectl and cluster
- Node registration
- Cluster management

---

# NodePort Range

text
30000-32767


Purpose:
- External access to Kubernetes applications

Example:
text
Access application from browser using:
<EC2-PUBLIC-IP>:NodePort


---

# SSH Connection Setup

## Change PEM File Permission

bash
chmod 400 k8s-key.pem


---

# Connect to Master Node

bash
ssh -i k8s-key.pem ubuntu@<MASTER_PUBLIC_IP>


---

# Hostname Configuration

## Master Node

bash
sudo hostnamectl set-hostname k8s-master


## Worker Node 1

bash
sudo hostnamectl set-hostname k8s-worker1


## Worker Node 2

bash
sudo hostnamectl set-hostname k8s-worker2


---

# System Update Commands

Run on all nodes:

bash
sudo apt update -y
sudo apt upgrade -y


---

# Kubernetes Cluster Components

## Master Node Responsibilities

The master node manages:
- API Server
- Scheduler
- Controller Manager
- etcd

Purpose:
- Cluster management
- Scheduling workloads
- Maintaining desired state

---

# Worker Node Responsibilities

Worker nodes run:
- Pods
- Containers
- Application workloads

Worker nodes communicate with:
- Master node
- kubelet
- container runtime

---

# Real-World DevOps Concepts Learned

- AWS EC2 setup
- Infrastructure provisioning
- Cloud networking
- Security groups
- SSH access
- Node architecture
- Cluster planning
- High-level Kubernetes architecture

---

# Interview Questions

## 1. Why do we need worker nodes in Kubernetes?

Worker nodes run application workloads and containers.

---

## 2. Why is port 6443 important?

Port 6443 is used by the Kubernetes API Server for cluster communication.

---

## 3. Why are security groups important?

Security groups control inbound and outbound traffic for EC2 instances.

---

## 4. Why are we using Ubuntu?

Ubuntu provides:
- Stability
- Easy package management
- Strong Kubernetes community support

---

## 5. Why not use t2.micro?

t2.micro has insufficient RAM and CPU resources for Kubernetes components.

---

# Key Takeaways

- Kubernetes clusters require multiple nodes
- Cloud infrastructure is important for DevOps learning
- Proper networking and security setup is critical
- EC2 provides real-world Kubernetes experience
- Infrastructure setup is the first step before Kubernetes installation

---

# Next Module

Phase 1 - Module 2

Topics:
- containerd installation
- kubeadm installation
- kubelet setup
- kubectl installation
- Kubernetes cluster initialization
- Worker node joining

---

# Author

Swapnil Girme
DevOps & Kubernetes Learning Journey