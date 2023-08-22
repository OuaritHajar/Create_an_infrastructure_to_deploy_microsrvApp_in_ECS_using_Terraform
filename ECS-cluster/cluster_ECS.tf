resource "aws_ecs_cluster" "ECS" {
 name = var.name

 tags = {
   Name = "ECS"
 }
}

resource "aws_service_discovery_http_namespace" "service_connect" {
  name        = var.namespace
  description = "cloudMmap namespace used in ecs service connect"
}