########################
# Mysql 

resource "aws_db_parameter_group" "myqsl_pg" {
  name   = "${var.env}-mysql-pg"
  family = var.mysql_pg_family

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8"
  }


  parameter {
    name  = "character_set_filesystem"
    value = "utf8"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8"
  }

  parameter {
    name  = "long_query_time"
    value = 2
  }

  parameter {
    name  = "slow_query_log"
    value = 1
  }

  parameter {
    name  = "general_log"
    value = 1
  }

}

# Subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = "${aws_subnet.private_subnets_db.*.id}"
  tags = {
    Name    = "${var.env}-db-subnet-group"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}


# Parameter store for master username and password
resource "aws_ssm_parameter" "mysql_master_user" {
  name        = "/${var.env}/database/mysql/master_user"
  description = "Mysql master user value"
  type        = "SecureString"
  value       = var.mysql_master_user

  tags = {
    Name    = "/${var.env}/database/mysql/master_user"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

resource "aws_ssm_parameter" "mysql_master_password" {
  name        = "/${var.env}/database/mysql/master_password"
  description = "Mysql master password value"
  type        = "SecureString"
  value       = var.mysql_master_password

  tags = {
    Name    = "/${var.env}/database/mysql/master_password"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}


resource "aws_db_instance" "mysql" {
  identifier             = "${var.env}-mysql"
  instance_class         = var.mysql_instance_type
  allocated_storage      = var.mysql_storage
  engine                 = "mysql"
  engine_version         = var.mysql_engine_version
  name                   = var.mysql_db_name   
  username               = aws_ssm_parameter.mysql_master_user.value
  password               = aws_ssm_parameter.mysql_master_password.value
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  parameter_group_name   = aws_db_parameter_group.myqsl_pg.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  iam_database_authentication_enabled = true
  storage_encrypted      = "true"
  
  deletion_protection    = false
  backup_retention_period = 30
  multi_az               = true
  backup_window          = var.backup_window
  
  tags = {
    Name           = "${var.env}-mysql"
    env            = "${var.env}"
    region         = "${var.aws_region}"
  }
}



