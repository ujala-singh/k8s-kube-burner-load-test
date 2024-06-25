#!/bin/bash

# Replace placeholders in kube-burner config
sed -i "s/JOB_ITERATIONS/$JOB_ITERATIONS/g" /etc/kube-burner/config.yaml
sed -i "s/QPS/$QPS/g" /etc/kube-burner/config.yaml
sed -i "s/BURST/$BURST/g" /etc/kube-burner/config.yaml
sed -i "s/SECRET_REPLICAS/$SECRET_REPLICAS/g" /etc/kube-burner/config.yaml
sed -i "s/DEPLOYMENT_REPLICAS/$DEPLOYMENT_REPLICAS/g" /etc/kube-burner/config.yaml
sed -i "s/SERVICEACCOUNT_REPLICAS/$SERVICEACCOUNT_REPLICAS/g" /etc/kube-burner/config.yaml
sed -i "s/SERVICE_REPLICAS/$SERVICE_REPLICAS/g" /etc/kube-burner/config.yaml
sed -i "s/CONFIGMAP_REPLICAS/$CONFIGMAP_REPLICAS/g" /etc/kube-burner/config.yaml

# Run kube-burner with the provided config
kube-burner init --config /etc/kube-burner/config.yaml
