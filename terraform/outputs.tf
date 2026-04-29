output "endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
  sensitive   = false
}

output "port" {
  description = "RDS port"
  value       = module.rds.port
}

output "database_name" {
  description = "Database name"
  value       = module.rds.database_name
}

output "master_username" {
  description = "Master username"
  value       = module.rds.master_username
}

output "resource_id" {
  description = "RDS resource ID"
  value       = module.rds.resource_id
}

output "arn" {
  description = "RDS instance ARN"
  value       = module.rds.arn
}

