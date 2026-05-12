output "db_instance_address" {
  description = "The address of the RDS instance."
  value       = aws_db_instance.main.address
}

output "db_instance_port" {
  description = "The port of the RDS instance."
  value       = aws_db_instance.main.port
}

output "db_instance_name" {
  description = "The database name."
  value       = aws_db_instance.main.db_name
}

output "db_instance_username" {
  description = "The master username for the database."
  value       = aws_db_instance.main.username
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.main.arn
}
