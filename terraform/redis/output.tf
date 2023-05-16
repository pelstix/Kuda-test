# Output the Redis cluster endpoint
output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis_cluster.configuration_endpoint_address
 }
# # Output the Redis cluster port
# output "redis_port" {
#   value = aws_elasticache_replication_group.redis_cluster.configuration_endpoint_port
# }
# # Output the Redis cluster configuration URL
# output "redis_config_url" {
#   value = aws_elasticache_replication_group.redis_cluster.configuration_endpoint_url
# }
# # Output the Redis subnet group name
# output "redis_subnet_group_name" {
#   value = aws_elasticache_subnet_group.redis_subnet_group.name
# }
# # Output the Redis subnet IDs
# output "redis_subnet_ids" {
#   value = aws_elasticache_subnet_group.redis_subnet_group.subnet_ids
# }
# # Output the Redis security group ID
# output "redis_security_group_id" {
#   value = aws_security_group.redis_sg.id
# }