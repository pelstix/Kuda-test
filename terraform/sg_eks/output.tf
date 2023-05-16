output "security_group_public" {
   value = "${aws_security_group.worker_node_sg.id}"
}
output "security_group_public_rds" {
   value = "${aws_security_group.rds.id}"
}

