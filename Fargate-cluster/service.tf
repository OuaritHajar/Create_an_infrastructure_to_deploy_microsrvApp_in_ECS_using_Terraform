resource "aws_ecs_service" "main" {
  name            = "${var.family_name}-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.main.family
  launch_type     = "FARGATE"
  desired_count   = var.app_count

  network_configuration { 
    subnets = var.private_subnet_ids
    security_groups =["${aws_security_group.ecs_grp.id}"] 
  }
   load_balancer {
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
    container_name   = var.family_name
    container_port   = var.app_port
  }

  service_connect_configuration {
    enabled = true
    namespace = var.namespace
    service {
       port_name =  var.port_mapping
      client_alias {
        port     = var.service_connect_port
        dns_name = var.dns_name
      }
    }
  }

  depends_on = [
    aws_ecs_task_definition.main,
  ]
}
 

#create grp-ECS
resource "aws_security_group" "ecs_grp" {
  name        = "${var.security_group_ecs_tasks_name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["10.0.0.0/16"]
  }
   egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create Load balancer-nlb
resource "aws_lb" "nlb" {
  name               = "nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids 
  enable_deletion_protection = false
  
}

resource "aws_lb_target_group" "nlb_target_group" {
  depends_on  = [
    aws_lb.nlb
  ]
  name     = "${var.tg_name}"
  port     = var.app_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip" 
 
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.app_port
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
    type             = "forward"
  }
}


<<<<<<< HEAD
=======

>>>>>>> cddbdbc5d432a2e30ed1f6fef84716b5d1296f51
