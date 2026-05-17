module "rds_instance" {
  source = "./modules/rds"

  allocated_storage        = var.db_allocated_storage
  engine_version           = var.db_engine_version
  instance_class           = var.db_instance_class
  db_instance_identifier   = var.db_instance_identifier
  db_name                  = var.db_name
  db_username              = var.db_username
  db_password              = var.db_password
  db_port                  = var.db_port
  vpc_security_group_ids   = var.vpc_security_group_ids
  db_subnet_group_name     = var.db_subnet_group_name
  parameter_group_name     = var.db_parameter_group_name
  environment              = var.environment
}
