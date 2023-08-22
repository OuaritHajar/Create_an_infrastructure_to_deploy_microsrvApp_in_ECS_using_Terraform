#create task-ECS
resource "aws_ecs_task_definition" "main" {
  family                 = var.family_name  
  network_mode           = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn = aws_iam_role.ecs_task_role.arn
  execution_role_arn      = aws_iam_role.ecs_task_role.arn
  cpu                    = var.cpu
  memory                 = var.memory

  container_definitions = jsonencode(
    [
      {
        name   = var.container_name,  
        image  = var.image_uri,
        cpu    = var.cpu,
        memory = var.memory,
        network_mode = "awsvpc"
        portMappings = [
          {
            name =  var.port_mapping
            containerPort : var.app_port
            protocol : "tcp",
            hostPort : var.app_port,
            appProtocol: "http"
          }
        ]
        essential = true     
        "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": var.logs,
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                }
            }
      }
    ]
  )
}


