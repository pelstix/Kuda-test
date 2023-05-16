
# # Create the VPC
# resource "aws_vpc" "redis_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "redis-vpc"
#   }
# }
# # Create the subnet
# resource "aws_subnet" "redis_subnet" {
#   cidr_block = "10.0.1.0/24"
#   vpc_id = aws_vpc.redis_vpc.id
#   tags = {
#     Name = "redis-subnet"
#   }
# }
# Create the security group
resource "aws_security_group" "redis_sg" {
  name_prefix = "redis-"
  vpc_id = var.vpc_id
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Create the Redis cluster
resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id = "redis-cluster"
  replication_group_description = "Redis cluster for my app"
  node_type = "cache.t2.micro"
  number_cache_clusters = 1
  subnet_group_name = "redis-subnet-group"
  engine = "redis"
  engine_version = "6.x"
  automatic_failover_enabled = false
  security_group_ids = [aws_security_group.redis_sg.id]
  lifecycle {
    ignore_changes = [security_group_ids]
  }
}
# Create the Redis subnet group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "redis-subnet-group"
  subnet_ids = [var.subnet_ids[0],var.subnet_ids[1]]
}
