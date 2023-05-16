variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "demodb"
}
variable "identifier" {
  description = "The name of the database to create"
  type        = string
  default     = "demo-microsoftsql"
}
variable "db_username" {
  description = "The username for the database"
  type        = string
  default     = "demouser"
}
variable "db_password" {
  description = "The password for the database"
  type        = string
  default     = "demopassword"
}
variable "db_instance_class" {
  description = "The instance class to use for the RDS instance"
  type        = string
  default     = "db.t3.small"
}
variable "db_engine" {
  description = "The database engine to use for the RDS instance"
  type        = string
  default     = "sqlserver-ex"
}
variable "db_allocated_storage" {
  description = "The amount of storage to allocate for the RDS instance"
  type        = number
  default     = 20
}

# variable "db_subnet_group_name" {
#   description = "The name of the DB subnet group to use"
#   type        = list(string)
# }














