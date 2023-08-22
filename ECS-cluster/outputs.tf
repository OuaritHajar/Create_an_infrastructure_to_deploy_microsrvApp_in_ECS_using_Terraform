output arn {
  value = aws_ecs_cluster.ECS.arn
}

output id {
  value = aws_ecs_cluster.ECS.id
}

output "namespace" {
  value = aws_service_discovery_http_namespace.service_connect.name
}