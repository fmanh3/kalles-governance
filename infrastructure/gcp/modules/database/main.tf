resource "google_sql_database_instance" "instance" {
  name             = var.db_name
  region           = var.region
  database_version = "POSTGRES_15"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = false
}

resource "google_sql_user" "user" {
  name     = "${var.db_name}-user"
  instance = google_sql_database_instance.instance.name
  password = "password-to-be-changed"
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
}
