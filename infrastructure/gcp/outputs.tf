output "finance_db_connection_name" {
  value       = module.finance_db.connection_name
  description = "The connection name of the Finance Cloud SQL instance"
}

output "finance_db_user" {
  value       = module.finance_db.db_user
  description = "The database user for Finance"
}

output "finance_db_password" {
  value       = module.finance_db.db_password
  description = "The database password for Finance"
  sensitive   = true
}

output "hr_db_connection_name" {
  value       = module.hr_db.connection_name
  description = "The connection name of the HR Cloud SQL instance"
}

output "hr_db_user" {
  value       = module.hr_db.db_user
  description = "The database user for HR"
}

output "hr_db_password" {
  value       = module.hr_db.db_password
  description = "The database password for HR"
  sensitive   = true
}

output "project_id" {
  value       = var.project_id
  description = "The GCP Project ID used for the deployment"
}