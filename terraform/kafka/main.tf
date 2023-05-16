resource "aws_security_group" "kafka" {
  name        = "kafka-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      =  var.vpc_id

  ingress {
    description      = "ssh access to public"
    from_port        = 9092
    to_port          = 9092
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_msk_cluster" "demo_kafka_cluster" {
  cluster_name = var.kafka_cluster_name
  kafka_version = "2.8.0"
  number_of_broker_nodes = length(var.kafka_broker_node_group_info)
  broker_node_group_info = [
    for idx, group in var.kafka_broker_node_group_info : {
      client_subnets = var.kafka_subnet_ids
      ebs_volume_size = group.ebs_volume_size
      instance_type  = group.instance_type
      security_groups = aws_security_group.kafka
      storage_info = {
        ebs_storage_info = {
          volume_size = group.ebs_volume_size
        }
      }
      id = idx
    }
  ]
  encryption_info = {
    encryption_in_transit = {
      client_broker = var.kafka_encryption_in_transit
    }
    encryption_at_rest = {
      data_volume_kms_key_id = aws_kms_key.example_kafka_cluster_data_volume.id
      storage_encrypted     = var.kafka_encryption_at_rest
    }
  }
}
resource "aws_kms_key" "example_kafka_cluster_data_volume" {
  description             = "Kafka cluster data volume encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}











