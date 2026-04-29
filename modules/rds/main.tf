resource "aws_db_instance" "postgres" {
  identifier              = "${var.cluster_identifier}-${var.environment}"
  engine                  = "postgres"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.storage_encrypted ? aws_kms_key.rds.arn : null

  db_name                 = var.database_name
  username                = var.master_username
  password                = random_password.master_password.result
  port                    = 5432

  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible

  # Backups
  backup_retention_period = var.backup_retention_days
  backup_window           = var.backup_window
  copy_tags_to_snapshot   = true
  skip_final_snapshot     = var.skip_final_snapshot
  final_snapshot_identifier = "${var.cluster_identifier}-${var.environment}-final-snapshot"

  # Maintenance
  maintenance_window      = var.maintenance_window
  auto_minor_version_upgrade = true

  # Logs
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled = true

  # Network
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids

  # Security
  deletion_protection     = var.deletion_protection

  depends_on = [aws_kms_key.rds]

  tags = {
    Name = "${var.cluster_identifier}-${var.environment}"
  }
}

# KMS Key for encryption
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "rds-key-${var.environment}"
  }
}

resource "aws_kms_alias" "rds" {
  name          = "alias/rds-${var.environment}"
  target_key_id = aws_kms_key.rds.key_id
}

# Generate random password
resource "random_password" "master_password" {
  length  = 32
  special = true
}

# Store password in Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name_prefix             = "rds/${var.cluster_identifier}/${var.environment}/"
  description             = "RDS master password for ${var.cluster_identifier}"
  recovery_window_in_days = 7

  tags = {
    Name = "rds-master-password-${var.environment}"
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.master_username
    password = random_password.master_password.result
    engine   = "postgres"
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
    dbname   = var.database_name
  })
}

# Parameter Group
resource "aws_db_parameter_group" "postgres" {
  family = "postgres${split(".", var.engine_version)[0]}"
  name   = "${var.cluster_identifier}-${var.environment}"

  # Performance
  parameter {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }

  tags = {
    Name = "postgres-params-${var.environment}"
  }
}

# Update DB instance to use parameter group
resource "aws_db_instance" "postgres" {
  parameter_group_name = aws_db_parameter_group.postgres.name
  depends_on           = [aws_db_parameter_group.postgres]
}

