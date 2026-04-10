terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = { 
      source = "hashicorp/google"
      version = "~> 5.0" 
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "finance_db" { 
  source = "./modules/database"
  project_id = var.project_id
  region = var.region
  db_name = "kalles-finance"
}

module "hr_db" { 
  source = "./modules/database"
  project_id = var.project_id
  region = var.region
  db_name = "kalles-hr"
}

module "traffic_db" { 
  source = "./modules/database"
  project_id = var.project_id
  region = var.region
  db_name = "kalles-traffic"
}

variable "project_id" { default = "joakim-hansson-lab" }
variable "region" { default = "europe-west1" }

output "hr_db_password" {
  value = module.hr_db.db_password
  sensitive = true
}
