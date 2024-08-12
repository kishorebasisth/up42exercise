provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

resource "helm_release" "s3www_minio" {
  name      = "s3www-minio"
  chart     = "../s3www-minio/"
  namespace = "up42"

  set {
    name  = "minio.accessKey"
    value = var.minio_access_key
  }

  set {
    name  = "minio.secretKey"
    value = var.minio_secret_key
  }

  set {
    name  = "minio.bucketName"
    value = var.minio_bucket_name
  }

  set {
    name  = "loadBalancer.enabled"
    value = var.load_balancer_enabled
  }

  set {
    name  = "ingress.enabled"
    value = var.ingress_enabled
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.ingress_host
  }

  set {
    name  = "prometheus.enabled"
    value = var.prometheus_enabled
  }

  depends_on = [kubernetes_namespace.s3www_namespace]
}

resource "kubernetes_namespace" "s3www_namespace" {
  metadata {
    name = "up42"
  }
}

