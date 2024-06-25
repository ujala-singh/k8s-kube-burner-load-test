# k8s-kube-burner-load-test
This Repository has the configs for the open source tool kube-burner which is widely used for k8s stress testing.

# kube-burner Setup and Deployment

This repository contains the setup for running `kube-burner` within a Kubernetes cluster. It includes a Dockerfile to build the `kube-burner` image, necessary configuration files, and Kubernetes manifests for deploying the container as a Pod.

## Prerequisites

- Docker
- Kubernetes cluster
- `kubectl` configured to interact with your cluster

## Dockerfile

The Dockerfile builds a custom Docker image for `kube-burner`. Build the Docker image using the following command:
```
docker build -t <docker-image-name> .
```
Replace <docker-image-name> with the desired name for your Docker image.

## Kubernetes Setup
ServiceAccount, ClusterRole, and RoleBinding

Create the following YAML file (rbac.yaml) for the ServiceAccount, ClusterRole, and RoleBinding:

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kube-burner-sa
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: kube-burner-role
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: kube-burner-rolebinding
subjects:
- kind: ServiceAccount
  name: kube-burner-sa
  namespace: default
roleRef:
  kind: ClusterRole
  name: kube-burner-role
  apiGroup: rbac.authorization.k8s.io
```
Apply the RBAC configuration:
```
kubectl apply -f rbac.yaml
```

## Pod Manifest

Create the following Pod manifest to run the Docker image as a Kubernetes Pod:
```
apiVersion: v1
kind: Pod
metadata:
  name: kube-burner-pod
  namespace: default
spec:
  serviceAccountName: kube-burner-sa
  containers:
  - name: kube-burner-container
    image: jolly3/kube-burner:latest
    env:
    - name: JOB_ITERATIONS
      value: "10"
    - name: QPS
      value: "500"
    - name: BURST
      value: "500"
    - name: SECRET_REPLICAS
      value: "600"
    - name: DEPLOYMENT_REPLICAS
      value: "600"
    - name: SERVICEACCOUNT_REPLICAS
      value: "500"
    - name: SERVICE_REPLICAS
      value: "500"
    - name: CONFIGMAP_REPLICAS
      value: "500"
    volumeMounts:
    - name: kube-burner-config
      mountPath: /kube-burner/configs
    - name: kube-burner-templates
      mountPath: /kube-burner/templates
  volumes:
  - name: kube-burner-config
    configMap:
      name: kube-burner-config
  - name: kube-burner-templates
    configMap:
      name: kube-burner-templates
```
Replace <docker-image-name> with the name of your Docker image.

Ensure the following environment variables are set when running the Docker container:

    JOB_ITERATIONS
    QPS
    BURST
    SECRET_REPLICAS
    DEPLOYMENT_REPLICAS
    SERVICEACCOUNT_REPLICAS
    SERVICE_REPLICAS
    CONFIGMAP_REPLICAS

Apply the Pod manifest:
```
kubectl apply -f kube-burner-pod.yaml
```

# Summary

- *Dockerfile*: Builds a Docker image with kube-burner and the necessary configuration files.
- *RBAC*: Sets up a ServiceAccount, ClusterRole, and ClusterRoleBinding with all permissions.
- *ConfigMaps*: Stores configuration and template files for kube-burner.
- *Pod Manifest*: Deploys the Docker image as a Pod in Kubernetes and passes environment variables for customization.

This setup ensures that kube-burner init runs with the provided configuration, and then the process exits.