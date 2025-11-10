# Outputs display important information after terraform apply

# Did this intuitively and it got messy. I'll fix later using multiple key-value pairs for each output block

output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.main.id
}
# output "availability_zones" {
#   description = "Availability zones used"
#   value       = tolist(data.aws_availability_zones.available.names)
# }

# Bastion Host Output
output "Bastion_Host_Name" {
  description = "Bastion Host Name"
  value = aws_instance.bastion_host.tags["Name"]
  }
output "Bastion_Host_Subnet" {
  description = "Bastion Host Subnet"
  value = aws_instance.bastion_host.subnet_id

  }

output "Bastion_Host_Public_IP" {
  description = "Bastion Host Public IP"
  value = aws_instance.bastion_host.public_ip
  }

output "Bastion_Host_Private_IP" {
  description = "Bastion Host Private IP"
  value = aws_instance.bastion_host.private_ip
  }
output "Bastion_Host_URL" {
  description = "Bastion Host URL"
  value = "http://${aws_instance.bastion_host.public_dns}/"
  # Inserted DNS string into link string. Not sure how or when to use "module.resource" yet.
  }





# Public Client A Output
output "Public_Client_A_Name" {
  description = "Public Client A Name"
  value = aws_instance.public_client_a.tags["Name"]
  }
output "Public_Client_A_Subnet" {
  description = "Public Client A Subnet"
  value = aws_instance.public_client_a.subnet_id
  }

output "Public_Client_A_Public_IP" {
  description = "Public Client A Publiv IP"
  value = aws_instance.public_client_a.public_ip
  }

output "Public_Client_A_Private_IP" {
  description = "Public Client A Private IP"
  value = aws_instance.public_client_a.private_ip
  }
output "Public_Client_A_URL" {
  description = "Public Client A URL"
  value = "http://${aws_instance.public_client_a.public_dns}/"
  }




# Private Client A Output
output "Private_Client_A_Name" {
  description = "Pricate Client A Name"
  value = aws_instance.private_client_a.tags["Name"]
  }
output "Private_Client_A_Subnet" {
  description = "Private Client A Subnet"
  value = aws_instance.private_client_a.subnet_id
  }
output "Private_Client_A_Private_IP" {
  description = "Private Client A Private IP"
  value = aws_instance.private_client_a.private_ip
  }


# Private Client B Output
output "Private_Client_B_Name" {
  description = "Pricate Client B Name"
  value = aws_instance.private_client_b.tags["Name"]
  }
output "Private_Client_B_Subnet" {
  description = "Private Client B Subnet"
  value = aws_instance.private_client_b.subnet_id
  }
output "Private_Client_B_Private_IP" {
  description = "Private Client B Private IP"
  value = aws_instance.private_client_b.private_ip
  }




# Private Client C Output
output "Private_Client_C_Name" {
  description = "Pricate Client C Name"
  value = aws_instance.private_client_c.tags["Name"]
  }
output "Private_Client_C_Subnet" {
  description = "Private Client A Subnet"
  value = aws_instance.private_client_c.subnet_id
  }
output "Private_Client_C_Private_IP" {
  description = "Private Client C Private IP"
  value = aws_instance.private_client_c.private_ip
  }






# # Private Client Mixed ASG Output

#NAME
#aws_autoscaling_group" "private_client_mixed_asg"

#ARNS
#[aws_autoscaling_group.private_client_mixed_asg.arn]

#SUBNETS
#[aws_subnet.private_app_a.id, aws_subnet.private_app_b.id, aws_subnet.private_app_c.id]
