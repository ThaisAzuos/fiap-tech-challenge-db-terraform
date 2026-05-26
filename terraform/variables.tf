variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "cluster_identifier" {
  description = "RDS cluster identifier"
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15.4"
}

variable "master_username" {
  description = "Master username for database"
  type        = string
  default     = "postgres"
}

variable "database_name" {
  description = "Initial database name"
  type        = string
  default     = "oficina_db"
}

variable "instance_class" {
  description = "Instance class (db.t3.micro, db.t3.small, etc)"
  type        = string
  default     = "db.t4g.micro" # Alterado de db.t3.micro para db.t4g.micro
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Enable encryption at rest"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Enable Multi-AZ"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Publicly accessible"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch logs to export"
  type        = list(string)
  default     = ["postgresql"]
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "DB subnet group name"
  type        = string
  default     = null
}
