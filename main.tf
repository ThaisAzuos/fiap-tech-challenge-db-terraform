resource "aws_security_group" "rds" {
  name        = "oficina-rds-${var.environment}"
  description = "Allow PostgreSQL access from within VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "oficina-rds-sg-${var.environment}"
    Environment = var.environment
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = ["false"]
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "oficina-db-subnet-group-${var.environment}"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name        = "oficina-db-subnet-group-${var.environment}"
    Environment = var.environment
  }
}

module "rds_instance" {
  source = "./modules/rds"

  allocated_storage      = var.db_allocated_storage
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_instance_identifier = var.db_instance_identifier
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_port                = var.db_port
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  parameter_group_name   = var.db_parameter_group_name
  environment            = var.environment
}
