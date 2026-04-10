terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = { source = "hashicorp/google"; version = "~> 5.0" }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# --- DATABASER ---
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

module "depot_db" { 
  source = "./modules/database"
  project_id = var.project_id
  region = var.region
  db_name = "kalles-energy-depot"
}

# --- VARIABLER ---
variable "project_id" { default = "joakim-hansson-lab" }
variable "region" { default = "europe-west1" }

# --- OUTPUTS ---
output "finance_db_host" { value = module.finance_db.db_host }
output "hr_db_host" { value = module.hr_db.db_host }
output "traffic_db_host" { value = module.traffic_db.db_host }
output "depot_db_host" { value = module.depot_db.db_host }
