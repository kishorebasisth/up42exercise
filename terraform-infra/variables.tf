variable "minio_access_key" {
  type        = string
  description = "MinIO access key"
  default     = "minioadmin"
}

variable "minio_secret_key" {
  type        = string
  description = "MinIO secret key"
  default     = "minioadmin"
}

variable "minio_bucket_name" {
  type        = string
  description = "Name of the MinIO bucket"
  default     = "s3www-bucket"
}

variable "load_balancer_enabled" {
  type        = bool
  description = "Enable/disable LoadBalancer for s3www"
  default     = true
}

variable "ingress_enabled" {
  type        = bool
  description = "Enable/disable Ingress for s3www"
  default     = false
}

variable "ingress_host" {
  type        = string
  description = "Host for the Ingress resource"
  default     = "www.up42exercise.com"
}

variable "prometheus_enabled" {
  type        = bool
  description = "Enable/disable Prometheus monitoring"
  default     = true
}
