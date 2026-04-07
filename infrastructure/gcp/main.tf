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

module "traffic_db" {
  source = "./modules/database"

  project_id   = var.project_id
  region       = var.region
  db_name      = "kalles-traffic"
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
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-traffic:v2"
      
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
        value = "/cloudsql/${module.traffic_db.connection_name}"
      }
      env {
        name  = "DB_PORT"
        value = "5432"
      }
      env {
        name  = "DB_USER"
        value = module.traffic_db.db_user
      }
      env {
        name  = "DB_PASSWORD"
        value = module.traffic_db.db_password
      }
      env {
        name  = "DB_NAME"
        value = "kalles-traffic"
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [module.traffic_db.connection_name]
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
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-finance:v2"
      
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
        value = "/cloudsql/${module.finance_db.connection_name}"
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
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-hr:v2"
      
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
        value = "/cloudsql/${module.hr_db.connection_name}"
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
# Cloud Run: BFF Gateway (Customer Success)
# --------------------------------------------------------------------------
resource "google_cloud_run_v2_service" "bff_gateway" {
  name     = "kalles-bff"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = google_service_account.runtime_sa.email
    
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-bff:latest"
      
      ports {
        container_port = 8080
      }

      env {
        name  = "FINANCE_SERVICE_URL"
        value = google_cloud_run_v2_service.finance_service.uri
      }
      env {
        name  = "HR_SERVICE_URL"
        value = google_cloud_run_v2_service.hr_service.uri
      }
      env {
        name  = "TRAFFIC_SERVICE_URL"
        value = google_cloud_run_v2_service.traffic_simulator.uri
      }
    }
  }
}

# --------------------------------------------------------------------------
# Cloud Run: CEO & Driver Portal (Frontend)
# --------------------------------------------------------------------------
resource "google_cloud_run_v2_service" "portal_frontend" {
  name     = "kalles-portal"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/kalles-buss/kalles-portal:latest"
      
      ports {
        container_port = 8080
      }
    }
  }
}

# --------------------------------------------------------------------------
# Public Access (Lab Environment Only)
# --------------------------------------------------------------------------
resource "google_cloud_run_v2_service_iam_member" "portal_public" {
  location = google_cloud_run_v2_service.portal_frontend.location
  name     = google_cloud_run_v2_service.portal_frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "bff_public" {
  location = google_cloud_run_v2_service.bff_gateway.location
  name     = google_cloud_run_v2_service.bff_gateway.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "finance_public" {
  location = google_cloud_run_v2_service.finance_service.location
  name     = google_cloud_run_v2_service.finance_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "hr_public" {
  location = google_cloud_run_v2_service.hr_service.location
  name     = google_cloud_run_v2_service.hr_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "traffic_public" {
  location = google_cloud_run_v2_service.traffic_simulator.location
  name     = google_cloud_run_v2_service.traffic_simulator.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
