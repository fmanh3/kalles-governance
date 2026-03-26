resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# Cloud SQL Instance
resource "google_sql_database_instance" "instance" {
  name             = "${var.db_name}-${random_id.db_name_suffix.hex}"
  project          = var.project_id
  region           = var.region
  database_version = "POSTGRES_15"
  
  settings {
    tier = "db-f1-micro" # Smallest tier for dev
    
    # Enable automatic backups and point-in-time recovery for safety
    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }
  }

  # NOTE: In production, delete_protect should be true.
  deletion_protection = false 
}

# The actual logical database inside the instance
resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}

# Generate a random password for the DB user
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# Create a database user
resource "google_sql_user" "users" {
  name     = "${var.db_name}-user"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
  password = random_password.db_password.result
}

output "connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

output "db_user" {
  value = google_sql_user.users.name
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}