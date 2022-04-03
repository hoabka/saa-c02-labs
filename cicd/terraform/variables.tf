variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}
variable "profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}
variable "env" {
  description = "AWS environment (prd, stg, dev, ...)"
  type        = string
}
variable "vpc_cidr_block" {
  description = "CIDR of VPC"
  type        = string
}

variable "ami_bastion" {
  description = "ami of bastion"
  type        = string
  default     = "ami-09ebacdc178ae23b7"
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "public_subnet_cidr_block" {
  type    = list(string)
}

variable "private_cidr_block" {
  type    = list(string)
}

variable "db_cidr_block" {
  type    = list(string)
}

variable "availability_zones" {
  description = "A comma-delimited list of availability zones for the VPC."
}
variable "availability_zone_short_name" {
  default = ["a", "b", "c"]
}

variable "public_key" {}

# rds

variable "rds_enhanced_monitoring_interval" {}
variable "backup_window" {}



# mysql
variable "mysql_instance_type" {}
variable "mysql_engine_version" {}
variable "mysql_storage" {}
variable "mysql_pg_family" {}
variable "mysql_db_name" {}
variable "mysql_master_user" {}
variable "mysql_master_password" {}



