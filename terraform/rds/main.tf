resource "aws_db_instance" "demo_rds_instance" {
  allocated_storage    = var.db_allocated_storage
  engine               = var.db_engine
  identifier = var.identifier
  storage_type = "gp2"
  engine_version       = "14.00.3281.6.v1"
  publicly_accessible    = false
  multi_az               = false
  instance_class       = var.db_instance_class
  name                 = null
  username             = var.db_username
  password             = var.db_password
  tags = {
    Name = "demo-rds-instance"
  }
}
output "rds_instance_endpoint" {
  value = aws_db_instance.demo_rds_instance.endpoint
}