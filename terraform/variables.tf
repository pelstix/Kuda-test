variable "location" {
    default = "eu-west-2"
}

variable "os_name" {
    default = "ami-028a5cd4ffd2ee495"
}

variable "key" {
    default = "film"
}

variable "instance-type" {
    default = "t2.micro"
}

variable "vpc-cidr" {
    default = "10.10.0.0/16"  
}

variable "subnet1-cidr" {
    default = "10.10.1.0/24"
  
}

variable "subnet2-cidr" {
    default = "10.10.2.0/24"
  
}

variable "subent_az" {
    default =  "eu-west-2a"  
}

variable "subent2_az" {
    default =  "eu-west-2b"  
}