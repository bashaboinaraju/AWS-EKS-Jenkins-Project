####################################################
# DB SUBNET GROUP
####################################################

resource "aws_db_subnet_group" "this" {

  name = "mysql-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "mysql-subnet-group"
    }
  )
}

####################################################
# PARAMETER GROUP
####################################################

resource "aws_db_parameter_group" "this" {

  name   = "mysql-8-parameter-group"

  family = "mysql8.0"

  parameter {

    name  = "character_set_server"

    value = "utf8mb4"

  }

  parameter {

    name  = "character_set_client"

    value = "utf8mb4"

  }

  tags = merge(
    var.common_tags,
    {
      Name = "mysql-parameter-group"
    }
  )

}

####################################################
# MYSQL RDS
####################################################

resource "aws_db_instance" "this" {

  identifier = "shopping-mysql"

  engine = "mysql"

  engine_version = "8.0"

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp3"

  storage_encrypted = var.storage_encrypted

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  parameter_group_name = aws_db_parameter_group.this.name

  vpc_security_group_ids = [

    var.rds_security_group_id

  ]

  publicly_accessible = false

  multi_az = var.multi_az

  backup_retention_period = var.backup_retention_period

  deletion_protection = false

  skip_final_snapshot = true

  monitoring_interval = var.monitoring_interval

  enabled_cloudwatch_logs_exports = [

    "error",

    "general",

    "slowquery"

  ]

  auto_minor_version_upgrade = true

  apply_immediately = true

  tags = merge(
    var.common_tags,
    {
      Name = "shopping-mysql"
    }
  )

}