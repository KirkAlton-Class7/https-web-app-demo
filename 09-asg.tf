
# Auto Scaling Group for Private Client Mixed Instances
resource "aws_autoscaling_group" "private_client_mixed_asg" {
  vpc_zone_identifier = [aws_subnet.private_app_a.id, aws_subnet.private_app_b.id, aws_subnet.private_app_c.id]
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2
  target_group_arns = [aws_lb_target_group.private_mixed_asg_tg.arn] # Target group to attach the ASG to. A list of ARNS is expected for an ASG, so use brackets and add an "s" make "target_group_arn" plural.


  #launch_template {
    #id      = aws_launch_template.private_client_a_asg.id
    #version = "$Latest"
  #}

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.private_client_a_asg.id
        version = "$Latest"
      }
    
      
      override {
      instance_type     = "t3.nano" # Instance type is always required for any override.
      launch_template_specification {
        launch_template_id = aws_launch_template.private_client_a_asg.id # Override to use Launch Template for Private Client A
        version = "$Latest"
      }      
      }
      
      override {
      instance_type     = "t2.micro" # Instance type is always required for any override.
      launch_template_specification {
        launch_template_id = aws_launch_template.private_client_b_asg.id # Override to use Launch Template for Private Client B
        version = "$Latest"
      }      
      }

      override {
      instance_type     = "t2.nano" # Instance type is always required for any override.
      launch_template_specification {
        launch_template_id = aws_launch_template.private_client_c_asg.id # Override to use Launch Template for Private Client C
      }      
      }
    }
#   instances_distribution {
#     on_demand_allocation_strategy = "prioritized"
# }

# Experimenting with different ways to try and force all 3 AMIs to launch on the ASG. None of it is currently working.
  }
}