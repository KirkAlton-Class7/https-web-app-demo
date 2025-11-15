# Application Load Balancer (ALB) Configurations

# Public Application Load Balancer 01
resource "aws_lb" "public_app_lb_01" {
  name               = "public-app-lb-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb.id]
  subnets            = [aws_subnet.public_app_a.id, aws_subnet.public_app_b.id, aws_subnet.public_app_c.id]

  enable_deletion_protection = false

  # Add Access Logs Later
  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "public-app-lb-01"
  #   enabled = true
  # }

  tags = {
    Environment = "production"
  }
}


# Public Application Load Balancer 01 - Listener (Forwards to ASG)

resource "aws_lb_listener" "public_app_lb_01" {
  load_balancer_arn = aws_lb.public_app_lb_01.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08" # Name of SSL Policy for the listener. Required if protocol is HTTPS or TLS. Default is listed here.
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4" # Optional. ARN of the default SSL server certificate. Exactly one certificate is required if protocol is HTTPS.

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_asg_tg.arn
  }
}