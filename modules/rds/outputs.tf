output "endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "port" {
  value = aws_db_instance.postgres.port
}

output "database_name" {
  value = aws_db_instance.postgres.db_name
}

output "master_username" {
  value = aws_db_instance.postgres.username
}

output "resource_id" {
  value = aws_db_instance.postgres.resource_id
}

output "arn" {
  value = aws_db_instance.postgres.arn
}

output "address" {
  value = aws_db_instance.postgres.address
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}

