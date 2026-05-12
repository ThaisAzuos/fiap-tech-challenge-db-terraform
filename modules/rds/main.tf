resource "aws_db_instance" "main" {
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.db_instance_identifier
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  port                 = var.db_port
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
  parameter_group_name = var.parameter_group_name

  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false

  tags = {
    Name        = "${var.db_instance_identifier}-db"
    Environment = var.environment
  }
}
