#vpc
variable vpc_cidr_block {
  type        = string
  description = "CIDR block for vpc"
}

variable Private_subnete_cidr_block {
  type        = list(string)
  description = "CIDR block for private subnets"
}

variable Public_subnete_cidr_block {
  type        = list(string)
  description = "CIDR block for public subnets"
}

variable number_of_public_subnets{
  type = number 
  description = "The number of public subnets"
}

variable number_of_private_subnets{
  type = number 
  description = "The number of private subnets"
}

variable availability_zones{
  type = list(string) 
}
#ECS_Cluster
variable "namespace" {
  type = string
  description = "namespace used by service connect"
}

#api_Fargate
variable "api_container_name" {
  type        = string
  description = "The name of the application and the container"
}
variable "api_image_uri" {
  type = string 
  description = "Container image to be used for application in task definition file"
}
variable "app_port_api" {
  type = number
  description = "Application port"
}
variable "app_count" {
  type = string 
  description = "The number of instances of the task definition to place and keep running."
}
variable "api_port_mapping" {
  type = string 
  description = "the name of the port in task definition"
}


#frontend_fargate
variable "client_container_name" {
  type        = string
  description = "The name of the application and the container"
}
variable "client_image_uri" {
  type = string 
  description = "Container image to be used for application in task definition file"
}
variable "app_port_client" {
  type = number
  description = "Application port"
}
variable "client_port_mapping" {
  type = string 
  description = "the name of the port in task definition"
}

#Database_fargate
variable "db_container_name" {
  type        = string
  description = "The name of the application and the container"
}
variable "db_image_uri" {
  type = string 
  description = "Container image to be used for application in task definition file"
}
variable "app_port_db" {
  type = number
  description = "Application port"
}
variable "db_port_mapping" {
  type = string 
  description = "the name of the port in task definition"
}

