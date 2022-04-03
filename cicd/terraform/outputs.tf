
output "availability_zones" {
  value = "${var.availability_zones}"
}

output "public_subnets" {
  value = "${aws_subnet.public_subnets.*.id}"  
}

output "private_subnets_app" {
  value = "${aws_subnet.private_subnets_app.*.id}"
}

output "private_subnets_db" {
  value = "${aws_subnet.private_subnets_db.*.id}"
}


output "sg_bastion" {
  value = "${aws_security_group.bastion.id}"
}

output "keypairs" {
  value = "${aws_key_pair.keypairs.key_name}"
}


