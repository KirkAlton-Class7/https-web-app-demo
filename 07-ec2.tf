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

# Public App EC2 Clients

# Bastion Host (Windows Server 2025)
resource "aws_instance" "bastion_host" {
    ami           = data.aws_ami.microsoft_windows_server_2025.id
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.public_app_a.id
    vpc_security_group_ids = [aws_security_group.bastion_host.id]
    #key_name = "osaka-key"  # Replace with your key pair name
    associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host-Windows"
  }
}

# Public App EC2 Client (Amazon Linux 2023)
resource "aws_instance" "public_client_a" {
    ami           = data.aws_ami.amazon_linux_2023.id
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.public_app_a.id
    vpc_security_group_ids = [aws_security_group.public_app.id]
    #key_name = "osaka-key"  # Replace with your key pair name
    user_data = file("${path.module}/public_client_a_script.sh") # Custom script path for Public Client A
    associate_public_ip_address = true

  tags = {
    Name = "Public-Client-A"
  }
}


# Private App EC2 Clients

# Private Client A
resource "aws_instance" "private_client_a" {
    ami           = data.aws_ami.amazon_linux_2023.id
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.private_app_a.id
    vpc_security_group_ids = [aws_security_group.private_app.id]
    #key_name = "osaka-key"  # Replace with your key pair name
    user_data = file("${path.module}/private_client_a_script.sh") # Custom script path for Client A

  tags = {
    Name = "Private-Client-A"
  }
}



# Private Client B
resource "aws_instance" "private_client_b" {
    ami           = data.aws_ami.amazon_linux_2023.id
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.private_app_b.id
    vpc_security_group_ids = [aws_security_group.private_app.id]
    #key_name = "osaka-key"  # Replace with your key pair name
    user_data = file("${path.module}/private_client_b_script.sh") # Custom script path for Client B

  tags = {
    Name = "Private-Client-B"
  }
}

# Private Client C
resource "aws_instance" "private_client_c" {
    ami           = data.aws_ami.amazon_linux_2023.id
    instance_type = "t3.micro"
    subnet_id     = aws_subnet.private_app_c.id
    vpc_security_group_ids = [aws_security_group.private_app.id]
    #key_name = "osaka-key"  # Replace with your key pair name
    user_data = file("${path.module}/private_client_c_script.sh") # Custom script path for Client C

  tags = {
    Name = "Private-Client-C"
  }
}