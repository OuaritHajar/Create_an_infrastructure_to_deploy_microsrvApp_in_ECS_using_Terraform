variable "family_name" {
  type        = string
  description = "The name of the application and the family"
}
variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "container_name" {
  type        = string
  description = "The name of the application and the container"
}
variable "image_uri" {
  type = string 
  description = "Container image to be used for application in task definition file"
}
variable "app_port" {
  type = number
  description = "Application port"
}
variable "logs" {
  type = string 
  description = "cloudwatch logs"
}
variable "cluster_id" {
  type = string 
  description = "Cluster ID"
}
variable "app_count" {
  type = string 
  description = "The number of instances of the task definition to place and keep running."
}
variable "namespace" {
  type = string 
  description = "the namespace used in service connect"
}
variable "port_mapping" {
  type = string 
  description = "the name of the port in task definition"
}
variable "service_connect_port" {
  type = number
  description = "service connect port"
}
variable "dns_name" {
  type = string 
  description = "domain name that will for service to service communication"
}
variable "vpc_id" {
  type = string 
  description = "The id for the VPC where the ECS container instance should be deployed"
}
variable "public_subnet_ids" {
  type = list(string) 
  description = "the public_subnet_ids "
}
variable "private_subnet_ids" {
  type = list(string) 
  description = "the private_subnet_ids "
}
variable "tg_name" {
  type = string
  description = "target group"
}
variable security_group_ecs_tasks_name{
  type = string 
}