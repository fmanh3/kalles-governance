variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "kalles-buss-dev"
}

variable "region" {
  description = "The GCP region to deploy resources to"
  type        = string
  default     = "europe-west1" # Belgium, Google's primary sustainability-focused region
}
