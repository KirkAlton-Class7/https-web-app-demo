# Launch Template for Private Client Auto Scaling Group
resource "aws_launch_template" "private_client_asg" {
  name = "private-client-asg-lt"
  image_id = data.aws_ami.amazon_linux_2023.id
  # image_id = data.aws_ssm_parameter.al2023.value  # Alternatively, use latest AL2023 AMI via SSM Parameter Store (From Aaron's code. Looks simpler)
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.private_asg.id]
  #key_name = "osaka-key"  # Replace with your key pair name
  user_data = filebase64("${path.module}/private_client_a_script.sh") # Custom script path for Client A (base64 encoding required for launch templates)

  ebs_optimized = true  
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Private-Client-ASG-Instance"
    }
  }
}

# Edit your script so it applies 3 different images to each instance.

# Aaaron's Hints
# Use Flask + cookies. Store unique image URLs in an array. 
# Use an if statement to decide which image to display
# On each request, check the cookie value and use logic like:
# Cookie ID starts with 0–3 → image[1], Cookie ID starts with 4–6 → image[2], Cookie ID starts with 7–9 → image[3]
# Optional: track refresh count in cookies to trigger other surprises after N visits.