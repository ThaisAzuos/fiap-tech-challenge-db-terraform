variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
  default     = "prod"
}

variable "db_allocated_storage" {
  description = "The amount of allocated storage for the DB instance."
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "The engine version to use for the DB instance."
  type        = string
  default     = "16"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_instance_identifier" {
  description = "The name of the DB instance."
  type        = string
  default     = "oficina-db-prod"
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
  default     = "oficina"
}

variable "db_username" {
  description = "Username for the master DB user."
  type        = string
  default     = "oficina_admin"
}

variable "db_password" {
  description = "Password for the master DB user."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "The port on which the DB accepts connections."
  type        = number
  default     = 5432
}

variable "vpc_id" {
  description = "The VPC ID where RDS will be deployed (from k8s-terraform output)."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the DB subnet group (from k8s-terraform output)."
  type        = list(string)
}

variable "db_parameter_group_name" {
  description = "Name of the DB parameter group to associate with the DB instance."
  type        = string
  default     = "default.postgres16"
}
