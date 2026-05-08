variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
}

variable "db_allocated_storage" {
  description = "The amount of allocated storage for the DB instance."
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "The engine version to use for the DB instance."
  type        = string
  default     = "15.2"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t4g.micro"
}

variable "db_instance_identifier" {
  description = "The name of the DB instance."
  type        = string
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
}

variable "db_username" {
  description = "Username for the master DB user."
  type        = string
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

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the DB instance."
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group to associate with the DB instance."
  type        = string
}

variable "db_parameter_group_name" {
  description = "Name of the DB parameter group to associate with the DB instance."
  type        = string
  default     = "default.postgres15"
}
