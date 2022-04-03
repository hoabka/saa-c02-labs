# Bastion instance profile
resource "aws_iam_instance_profile" "bastion" {
  name = "${var.env}-bastion-profile"
  role = aws_iam_role.bastion.name
}

resource "aws_iam_role" "bastion" {
  name        = "${var.env}-bastion-role"
  description = "Allows EC2 instances to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "bastion-s3-full" {
  role       = "${aws_iam_role.bastion.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "bastion-ec2-full" {
  role       = "${aws_iam_role.bastion.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


# Bastion instance
resource "aws_instance" "bastion" {
  ami                       = var.ami_bastion
  instance_type             = "t2.medium"
  key_name                  = aws_key_pair.keypairs.key_name
  iam_instance_profile      = aws_iam_instance_profile.bastion.name
  subnet_id                 = "${element(aws_subnet.public_subnets.*.id, 0)}"
  vpc_security_group_ids    = ["${aws_security_group.bastion.id}"]

  tags = {
    Name               = "${var.env}-bastion"
    env                = "${var.env}"
    region             = "${var.aws_region}"
  }
}

resource "aws_eip" "bastion" {
  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name    = "${var.env}-bastion-eip"
    env     = "${var.env}"
    region  = "${var.aws_region}"
  }
}

resource "aws_eip_association" "bastion_eip" {
  instance_id   = "${aws_instance.bastion.id}"
  allocation_id = "${aws_eip.bastion.id}"
}
