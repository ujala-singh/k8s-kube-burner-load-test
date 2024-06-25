FROM quay.io/cloud-bulldozer/kube-burner:latest

# Copy the provided files into the container
COPY kube-burner/templates/configmap.yaml /etc/kube-burner/templates/configmap.yaml
COPY kube-burner/templates/deployment.yaml /etc/kube-burner/templates/deployment.yaml
COPY kube-burner/templates/service.yaml /etc/kube-burner/templates/service.yaml
COPY kube-burner/templates/secret.yaml /etc/kube-burner/templates/secret.yaml
COPY kube-burner/templates/serviceAccount.yaml /etc/kube-burner/templates/serviceAccount.yaml

# Copy the kube-burner config template
COPY kube-burner/config/api-intensive.yaml /etc/kube-burner/config.yaml

# Script to replace placeholders with environment variables
COPY kube-burner/scripts/entrypoint.sh /etc/kube-burner/entrypoint.sh
RUN chmod +x /etc/kube-burner/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/etc/kube-burner/entrypoint.sh"]
