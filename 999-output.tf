# Outputs display important information after terraform apply

# Did this intuitively and it got messy. Fix later using multiple key-value pairs for each output block

# Output Block Reference
# https://developer.hashicorp.com/terraform/language/block/output

# Output Data from Terraform
# https://developer.hashicorp.com/terraform/tutorials/configuration-language/outputs


# VPC Output
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of project VPC"
}

# Bastion Host Output
output "bastion_host_info" {
  # Separate maps for each value made the code messy, so I used a tuple here to consolidate everything.
  value =[
    {
      name = aws_instance.bastion_host.tags["Name"]
      subnet_id = aws_instance.bastion_host.subnet_id
      public_ip = aws_instance.bastion_host.public_ip
      private_ip =aws_instance.bastion_host.private_ip
      url = "http://${aws_instance.bastion_host.public_dns}/"
      # Inserted DNS string into link string. Not sure how or when to use "module.resource" yet.
    }
  ]

  description = "Bastion Host: Name, Subnet, Pub-IP, Priv-IP, URL"  
}


# Public Client A Output
output "public_client_a_info" {
  value = [
    {
      name = aws_instance.public_client_a.tags["Name"]
      subnet_id = aws_instance.public_client_a.subnet_id
      public_ip = aws_instance.public_client_a.public_ip
      private_ip = aws_instance.public_client_a.private_ip
      url = "http://${aws_instance.public_client_a.public_dns}/"
    }
  ]
  
  description = "Public Client A: Name, Subnet, Pub-IP, Priv-IP, URL"  
}


# Private Client A Output
output "private_client_a_info" {
  value = [
    {
      name = aws_instance.private_client_a.tags["Name"]
      subnet_id = aws_instance.private_client_a.subnet_id
      private_ip = aws_instance.private_client_a.private_ip
    }
  ]
  
  description = "Private Client A: Name, Subnet, Priv-IP"  
}

# Private Client B Output
output "private_client_b_info" {
  value = [
    {
      name = aws_instance.private_client_b.tags["Name"]
      subnet_id = aws_instance.private_client_b.subnet_id
      private_ip = aws_instance.private_client_b.private_ip
    }
  ]
  
  description = "Private Client B: Name, Subnet, Priv-IP"  
}

# Private Client C Output
output "private_client_c_info" {
  value = [
    {
      name = aws_instance.private_client_c.tags["Name"]
      subnet_id = aws_instance.private_client_c.subnet_id
      private_ip = aws_instance.private_client_c.private_ip
    }
  ]
  
  description = "Private Client C: Name, Subnet, Priv-IP"  
}

