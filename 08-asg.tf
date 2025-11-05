# # resource "aws_placement_group" "public_cluster" {
# #   name     = "public-cluster-pg"
# #   strategy = "cluster"
# # }

# resource "aws_autoscaling_group" "public_app_asg" {
#   name                      = "foobar3-terraform-test"
#   max_size                  = 5
#   min_size                  = 2
#   health_check_grace_period = 300
#   health_check_type         = "EC2"
#   desired_capacity          = 4
#   force_delete              = true
#   #launch_configuration      = aws_launch_configuration.foobar.name
#   vpc_zone_identifier       = [aws_subnet.public_app_a.id, aws_subnet.public_app_b.id, aws_subnet.public_app_c.id]


#   instance_maintenance_policy {
#     min_healthy_percentage = 90
#     max_healthy_percentage = 120
#   }

#   initial_lifecycle_hook {
#     name                 = "foobar"
#     default_result       = "CONTINUE"
#     heartbeat_timeout    = 2000
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = jsonencode({
#       foo = "bar"
#     })

#     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
#     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#   }

#   tag {
#     key                 = "foo"
#     value               = "bar"
#     propagate_at_launch = true
#   }

#   timeouts {
#     delete = "15m"
#   }

#   tag {
#     key                 = "lorem"
#     value               = "ipsum"
#     propagate_at_launch = false
#   }
# }