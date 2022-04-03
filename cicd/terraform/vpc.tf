# VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true 

    tags = {
      Name = "${var.env}-vpc"
    }
}
#
## Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

}


# NATGW's EIP
resource "aws_eip" "nat_eip" {
  count = "${length("${var.availability_zones}")}"
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = "${var.env}-nat-eip-${element(var.availability_zone_short_name, count.index)}"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

# NAT Gateway

resource "aws_nat_gateway" "nat_gateways" {
  count         = "${length("${var.availability_zones}")}"
  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnets.*.id, count.index)}"

  tags = {
    Name    = "${var.env}-natgw-${element(var.availability_zone_short_name, count.index)}"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

# Public subnets
resource "aws_subnet" "public_subnets" {
  count   = "${length("${var.availability_zones}")}"
  vpc_id  = "${aws_vpc.vpc.id}"
  cidr_block	= element(concat(var.public_subnet_cidr_block, [""]), count.index)
 # cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.env}-public-subnet-${element(var.availability_zone_short_name, count.index)}"
    env     = "${var.env}"
    region  = "${var.aws_region}"
    "kubernetes.io/cluster/${var.env}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

# Private subnet

resource "aws_subnet" "private_subnets_app" {
  count   = "${length("${var.availability_zones}")}"
  vpc_id  = "${aws_vpc.vpc.id}"

  cidr_block              = element(concat(var.private_cidr_block, [""]), count.index)
  availability_zone       = "${element(var.availability_zones, count.index)}"

  tags = {
    Name    = "${var.env}-private-subnet-1-${element(var.availability_zone_short_name, count.index)}"
    env     = "${var.env}"
    region  = "${var.aws_region}"
    
  }
}


resource "aws_subnet" "private_subnets_db" {
  count   = "${length("${var.availability_zones}")}"
  vpc_id  = "${aws_vpc.vpc.id}"

  cidr_block              = element(concat(var.db_cidr_block, [""]), count.index)
  availability_zone       = "${element(var.availability_zones, count.index)}"

  tags = {
    Name    = "${var.env}-db-private-subnet-${element(var.availability_zone_short_name, count.index)}"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}


# Public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
    }
 
  tags = {
    Name    = "${var.env}-public-rt"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

resource "aws_route_table_association" "public" {
  count           = "${length("${var.availability_zones}")}"
  subnet_id       = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id  = "${aws_route_table.public.id}"
}

# Private route table
resource "aws_route_table" "private" {
  count   = "${length("${var.availability_zones}")}"
  vpc_id  = "${aws_vpc.vpc.id}"

  route {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = "${element(aws_nat_gateway.nat_gateways.*.id, count.index)}"
    }
  tags = {
    Name    = "${var.env}-private-rt-${element(var.availability_zone_short_name, count.index)}"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

resource "aws_route_table_association" "private_1_app" {
  count = "${length("${var.availability_zones}")}"
  subnet_id      = "${element(aws_subnet.private_subnets_app.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}


resource "aws_route_table_association" "private_db" {
  count = "${length("${var.availability_zones}")}"
  subnet_id      = "${element(aws_subnet.private_subnets_db.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

# Keypair
resource "aws_key_pair" "keypairs" {
  key_name   = "${var.env}-keypairs"
  public_key = var.public_key
}