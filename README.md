## Exercise overview
* The intent of this exercise was to create a helm chart to deploy s3WWW and MinIO service and serve the static file located [here](https://giphy.com/gifs/VdiQKDAguhDSi37gn1)
* The helm chart should be written so it can be reused and staged through various environments
* The helm chart should also have either a loadbalancer service or an Ingress service which would allow for the end user to consume the static file

## Folder Structure

```
up42exercise/
│
├── s3www-Dockerfile/
├── s3www-minio/
├── terraform-infra/
├── index.html
```

* s3www-minio folder contains the helm chart configuration (K8s manifest files)
* s3www-Dockerfile folder contains the docker file used to build a custom image for s3WWW
* terraform-infra folder contains the terraform IAC source
* index.html is the file that is served by the s3WWW server


## Prerequisites

1. **Minikube:** Make sure Minikube is installed and running on your local machine.
2. **kubectl:** Ensure that kubectl is configured to connect to your Minikube cluster.
3. **Helm:** Helm should be installed and configured.
4. **Terraform:** Terraform should be installed.


## Step by Step command to reproduce the solution

1. Start minikube and start a minikube [tunnel] {https://minikube.sigs.k8s.io/docs/commands/tunnel/}
   
   ```
   minikube start --driver=docker
   minikube tunnel
   ```

2. Install Prometheus Operator CRDs
   
   To use `ServiceMonitor`, we need to install the Prometheus Operator, which includes the necessary CRDs, run the following command under `s3www-minio` folder
   ```
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   helm install prometheus-operator prometheus-community/kube-prometheus-stack
   ```
   Verify if the CRD is installed by running the following command:
   ```
   kubectl get crds | grep servicemonitor
   ```
   you should see scomething like the following:
   ```
   servicemonitors.monitoring.coreos.com
   ```

3. Run terraform
   
   Under the `terraform-infra/` directory run the following commands to deploy the helm chart to a local minikube instance
   ```
   cd terraform-infra/
   terraform init
   terraform apply
   ```

4. Accessing the Services
   
   By default in this repo, only load balancer service is enabled but the way the static file is accessed can be changed and it could also be accessed via Ingress by adapting the `values.yaml` file
   * **LoadBalancer:** Browsing to the URL: http://0.0.0.0:8080 should display the GIF
   * **Ingress:** If Ingress is enabled, you may need to add the host (www.up42exercise.com) to your /etc/hosts file pointing to Minikube’s IP (`minikube ip`).
