# Data Sources for EC2 AMIs

# Microsoft Windows Server 2025 AMI Data Source
data "aws_ami" "microsoft_windows_server_2025" {
    most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2025-English-Full-Base-2025*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

    owners = ["801119661308"] # Microsoft Corporation
}

# Amazon Linux 2023 AMI Data Source
data "aws_ami" "amazon_linux_2023" {
    most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

    owners = ["137112412989"] # Amazon
}


# Alternate Method for image_id
# image_id = data.aws_ssm_parameter.al2023.value    # Use latest AL2023 AMI via SSM Parameter Store