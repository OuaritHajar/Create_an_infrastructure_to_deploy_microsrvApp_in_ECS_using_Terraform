output nlb_arn {
  value       = aws_lb.nlb.arn
  description = "ARN for the internal NLB"
}

output ecs_sg {
  value       = aws_security_group.ecs_grp.id
  description = "ARN for the internal NLB"
}
