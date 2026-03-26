variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "db_name" {
  type        = string
  description = "Name of the database/instance"
}

variable "network_name" {
  type        = string
  description = "VPC network name for private IP"
}