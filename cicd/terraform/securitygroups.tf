
# RDS SG 
resource "aws_security_group" "rds" {
  name        = "${var.env}-sg-rds"
  description = "SG of rds for sso connect to"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name    = "${var.env}-sg-rds"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

resource "aws_security_group_rule" "rds_inbound" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  description              = "Allow inbound"
  source_security_group_id = "${aws_security_group.bastion.id}"
  security_group_id        = "${aws_security_group.rds.id}"
}


# Bastion SG
resource "aws_security_group" "bastion" {
  name        = "${var.env}-sg-bastion"
  description = "SG of bastion"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = {
    Name    = "${var.env}-sg-bastion"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}


resource "aws_security_group_rule" "bastion_outbound_all_within_vpc" {
  type                     = "egress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  description              = "Allow all traffic within VPC"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
  security_group_id        = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "bastion_outbound_443_anywhere" {
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  description              = "Allow outbound 443 anywhere"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "bastion_outbound_80_anywhere" {
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  description              = "Allow outbound 80 anywhere"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.bastion.id}"
}

