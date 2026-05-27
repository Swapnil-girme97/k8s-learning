# Kubernetes Learning Journey
# Phase 1 - Module 3
# Pods, Deployments, ReplicaSets & Services

---

# Objective

In this module, we learned the core Kubernetes workload components used in real production environments.

Topics covered:
- Pods
- Deployments
- ReplicaSets
- Services
- YAML manifests
- Scaling
- Rolling updates
- Self-healing

---

# Kubernetes Workload Flow

```text
Docker Image
      ↓
Container
      ↓
Pod
      ↓
ReplicaSet
      ↓
Deployment
      ↓
Service
```

---

# Cluster Verification

## Check Cluster Nodes

```bash
kubectl get nodes
```

Expected:
```text
All nodes should show Ready
```

---

# Pods

## What is a Pod?

A Pod is:
```text
Smallest deployable unit in Kubernetes
```

A pod contains:
- one or more containers
- shared networking
- shared storage

---

# Create Pod Using Command

```bash
kubectl run nginx-pod --image=nginx
```

---

# Verify Pod

```bash
kubectl get pods
```

---

# Pod YAML Manifest

## Create File

```text
pod.yaml
```

## YAML Configuration

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx-pod

spec:
  containers:
  - name: nginx-container
    image: nginx

    ports:
    - containerPort: 80
```

---

# Create Pod Using YAML

```bash
kubectl apply -f pod.yaml
```

---

# Why YAML is Important

Real companies use:
- YAML
- GitHub
- CI/CD pipelines
- GitOps

This is called:
```text
Infrastructure as Code (IaC)
```

---

# Pod Troubleshooting Commands

## Describe Pod

```bash
kubectl describe pod nginx-pod
```

Purpose:
- check events
- check errors
- view pod details

---

# View Logs

```bash
kubectl logs nginx-pod
```

---

# Login Inside Pod

```bash
kubectl exec -it nginx-pod -- /bin/bash
```

---

# Delete Pod

```bash
kubectl delete pod nginx-pod
```

---

# Problem with Standalone Pods

If standalone pod crashes:
```text
Pod will NOT restart automatically
```

This causes downtime.

Solution:
```text
Deployments + ReplicaSets
```

---

# Deployments

## Create Deployment Using Command

```bash
kubectl create deployment nginx-deployment --image=nginx
```

---

# Verify Deployment

```bash
kubectl get deployments
```

---

# Verify ReplicaSet

```bash
kubectl get rs
```

---

# Verify Pods

```bash
kubectl get pods
```

---

# What is a Deployment?

Deployment manages:
- Pods
- ReplicaSets
- Scaling
- Rolling updates
- Rollbacks

Deployments are heavily used in production environments.

---

# What is ReplicaSet?

ReplicaSet ensures:
```text
Desired number of pod replicas are always running
```

Example:
```text
Desired replicas = 3
One pod crashes
ReplicaSet creates new pod automatically
```

This is called:
```text
Self-healing
```

---

# Deployment YAML

## Create File

```text
deployment.yaml
```

## YAML Configuration

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
      - name: nginx-container
        image: nginx

        ports:
        - containerPort: 80
```

---

# Apply Deployment YAML

```bash
kubectl apply -f deployment.yaml
```

---

# Verify All Resources

```bash
kubectl get all
```

---

# Scaling Applications

## Scale Deployment

```bash
kubectl scale deployment nginx-deployment --replicas=5
```

---

# Verify Pods

```bash
kubectl get pods
```

Expected:
```text
5 pods should be running
```

---

# Self-Healing Demo

## Delete One Pod

```bash
kubectl delete pod <POD_NAME>
```

Observation:
```text
New pod gets created automatically
```

ReplicaSet maintains desired state.

---

# Rolling Updates

## Update Container Image

```bash
kubectl set image deployment/nginx-deployment nginx-container=nginx:latest
```

---

# Check Rollout Status

```bash
kubectl rollout status deployment/nginx-deployment
```

---

# Rollback Deployment

```bash
kubectl rollout undo deployment/nginx-deployment
```

---

# Services

Pods are temporary.

Services provide:
- stable networking
- stable IP
- load balancing
- stable access

---

# Create NodePort Service

```bash
kubectl expose deployment nginx-deployment --type=NodePort --port=80
```

---

# Verify Service

```bash
kubectl get svc
```

Example:
```text
80:30007/TCP
```

---

# Access Application

```text
http://<EC2-PUBLIC-IP>:30007
```

Expected Output:
```text
Welcome to nginx
```

---

# Kubernetes Service Types

| Service Type | Purpose |
|---|---|
| ClusterIP | Internal communication |
| NodePort | External browser access |
| LoadBalancer | Cloud load balancer |

---

# Important Troubleshooting Commands

## View All Resources

```bash
kubectl get all
```

---

# Watch Pods Live

```bash
kubectl get pods -w
```

---

# Describe Deployment

```bash
kubectl describe deployment nginx-deployment
```

---

# Describe Service

```bash
kubectl describe svc nginx-deployment
```

---

# Real Production Concepts Learned

- Self-healing
- High availability
- Rolling updates
- Scaling
- Service discovery
- Infrastructure as Code
- Load balancing

---

# Real Company Best Practices

Companies usually use:
- Deployments
- Helm charts
- GitOps
- CI/CD pipelines

Companies DO NOT create standalone pods manually in production.

---

# Interview Questions

## 1. What is a Pod?

Pod is the smallest deployable unit in Kubernetes.

---

## 2. Difference Between Pod and Deployment?

Pod:
- single container workload

Deployment:
- manages pods
- supports scaling
- supports rolling updates
- supports self-healing

---

## 3. What is ReplicaSet?

ReplicaSet ensures desired number of pods are always running.

---

## 4. Why do we need Services?

Services provide stable networking access to pods.

---

## 5. Difference Between ClusterIP and NodePort?

ClusterIP:
- internal communication only

NodePort:
- external browser access

---

# Key Takeaways

- Pods are temporary
- Deployments manage pods
- ReplicaSets provide self-healing
- Services expose applications
- YAML is critical in Kubernetes
- Scaling is easy in Kubernetes
- Rolling updates reduce downtime

---

# Next Module

# Phase 1 - Module 4

Topics:
- Namespaces
- Labels
- Selectors
- ConfigMaps
- Secrets
- Environment variables
- Multi-environment deployments

---

# Author

Swapnil Girme
DevOps & Kubernetes Learning Journey