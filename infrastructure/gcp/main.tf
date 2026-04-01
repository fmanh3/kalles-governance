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
# Artifact Registry: Docker Image Storage
# --------------------------------------------------------------------------
resource "google_artifact_registry_repository" "kalles_repo" {
  location      = var.region
  repository_id = "kalles-buss"
  description   = "Docker repository for Kalles Buss microservices"
  format        = "DOCKER"
}

# --------------------------------------------------------------------------
# IAM: Service Account for Runtime
# --------------------------------------------------------------------------
resource "google_service_account" "runtime_sa" {
  account_id   = "kalles-runtime-sa"
  display_name = "Kalles Buss Runtime Service Account"
}

# Grant Pub/Sub Publisher/Subscriber permissions to the Service Account
resource "google_project_iam_member" "pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.runtime_sa.email}"
}

resource "google_project_iam_member" "pubsub_subscriber" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.runtime_sa.email}"
}

# Grant Cloud SQL Client permission to the Service Account
resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.runtime_sa.email}"
}

# --------------------------------------------------------------------------
# Cloud Run: Traffic Simulator
# --------------------------------------------------------------------------
resource "google_cloud_run_v2_service" "traffic_simulator" {
  name     = "kalles-traffic"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = google_service_account.runtime_sa.email
    
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-traffic:latest"
      
      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }
      env {
        name  = "NODE_ENV"
        value = "production"
      }
    }
  }
}

# --------------------------------------------------------------------------
# Cloud Run: Finance Service
# --------------------------------------------------------------------------
resource "google_cloud_run_v2_service" "finance_service" {
  name     = "kalles-finance"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = google_service_account.runtime_sa.email
    
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-finance:latest"
      
      ports {
        container_port = 8080
      }

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }
      env {
        name  = "NODE_ENV"
        value = "production"
      }
      env {
        name  = "DB_HOST"
        value = "127.0.0.1" # Cloud Run uses a built-in proxy for localhost
      }
      env {
        name  = "DB_PORT"
        value = "5432"
      }
      env {
        name  = "DB_USER"
        value = module.finance_db.db_user
      }
      env {
        name  = "DB_PASSWORD"
        value = module.finance_db.db_password
      }
      env {
        name  = "DB_NAME"
        value = "kalles-finance"
      }
      
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [module.finance_db.connection_name]
      }
    }
  }
}

# --------------------------------------------------------------------------
# Cloud Run: HR Service
# --------------------------------------------------------------------------
resource "google_cloud_run_v2_service" "hr_service" {
  name     = "kalles-hr"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = google_service_account.runtime_sa.email
    
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-hr:live"
      
      ports {
        container_port = 8080
      }

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }
      env {
        name  = "NODE_ENV"
        value = "production"
      }
      env {
        name  = "DB_HOST"
        value = "127.0.0.1"
      }
      env {
        name  = "DB_PORT"
        value = "5432"
      }
      env {
        name  = "DB_USER"
        value = module.hr_db.db_user
      }
      env {
        name  = "DB_PASSWORD"
        value = module.hr_db.db_password
      }
      env {
        name  = "DB_NAME"
        value = "kalles-hr"
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [module.hr_db.connection_name]
      }
    }
  }
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
