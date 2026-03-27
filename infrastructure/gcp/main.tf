terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }

  # NOTE: Backend state should be stored in a GCS bucket with versioning 
  # enabled to comply with NIS2 audit & recovery requirements.
  # For local dev bootstrap, we leave it local until the bucket is created.
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# --------------------------------------------------------------------------
# GCP Pub/Sub: System-wide Event Bus
# --------------------------------------------------------------------------
module "event_bus" {
  source = "./modules/pubsub"
  
  project_id = var.project_id
}

# --------------------------------------------------------------------------
# Cloud SQL: Databases per Domain
# --------------------------------------------------------------------------
module "finance_db" {
  source = "./modules/database"

  project_id   = var.project_id
  region       = var.region
  db_name      = "kalles-finance"
}

module "hr_db" {
  source = "./modules/database"

  project_id   = var.project_id
  region       = var.region
  db_name      = "kalles-hr"
}
