aws_region = "us-east-2"
profile = "default"
env = "training"
vpc_cidr_block = "10.20.0.0/16"
availability_zones = ["us-east-2a","us-east-2c"]
availability_zone_short_name = ["a", "c"]
ami_bastion = "ami-0fb653ca2d3203ac1"

public_subnet_cidr_block = [
	"10.20.192.0/23",
	"10.20.194.0/23",
]

private_cidr_block = [
	"10.20.0.0/18",
	"10.20.64.0/18",
]


db_cidr_block = [
	"10.20.208.0/20",
	"10.20.224.0/19",
]


public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqQw+8eITdgxT1G3O36MmS2JhfaRFRva6gYiI0dfwFdmHWbIViBVSj8w5WLL9aQOpHRoa2x3YnaodlpichJAvMP/u5NNRk7NMoiMIprbkKHOzY/O9LUOhQ6osBruzRStp6NYzsyRNnmshzMlPmkA8CJbAzM2QB6k4gbeAGZI/z110rNQf8ZOUpkEzJx0nIjCDcS0pGjJXHRa+I2SljshTePwYmRtP95m66Eosg3gX+gLzvXfSZ1qlokMELUjKEPEOYL80uR3NS+4tmQTMIkWjpA4rEnmY0Wv0WhROb1SYwJi6SWxMGCOX7Mj0TkuTXi4Jlzg/1onWFK5SVQJyf/j3F dev@SVT00014570"

#DB
rds_enhanced_monitoring_interval = 60
mysql_master_user = "admin"
mysql_master_password = "admin12345"
backup_window = "22:59-23:59"



# mysql
mysql_instance_type = "db.t3.medium"
mysql_engine_version = "5.7.34"
mysql_storage = 30
mysql_pg_family = "mysql5.7"
mysql_db_name = "data"

