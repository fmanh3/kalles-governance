output "db_host" {
  value = google_sql_database_instance.instance.connection_name
}

output "db_user" {
  value = google_sql_user.user.name
}

output "db_password" {
  value = google_sql_user.user.password
  sensitive = true
}
