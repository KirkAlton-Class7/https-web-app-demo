# Public App Security Group
resource "aws_security_group" "public_app" {
  name        = "public_app_sg"
  description = "Allow all inbound/outbound traffic for HTTP and SSH"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "public-application-sg"
  }
}

# SG Rule: Allow all HTTP Inbound for Public App SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_http_ipv4" {
  security_group_id = aws_security_group.public_app.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# SG Rule: Allow all HTTPS Inbound for Public App SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_https_ipv4" {
  security_group_id = aws_security_group.public_app.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# SG Rule: Allow all HTTP Outbound for Public App SG
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.public_app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# SG Rule: Allow all SSH Inbound for Public App SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_ssh_ipv4" {
  security_group_id = aws_security_group.public_app.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}



# Bastion Host Security Group
resource "aws_security_group" "bastion_host" {
  name        = "bastion_host_sg"
  description = "Allow RDP access from authorized IPs"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "bastion-host-sg"
  }
}


# SG Rule: Allow all HTTP Inbound for Bastion Host SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_http_ipv4_bastion" {
  security_group_id = aws_security_group.bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# SG Rule: Allow all HTTPS Inbound for Bastion Host SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_https_ipv4_bastion" {
  security_group_id = aws_security_group.bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# SG Rule: Allow all HTTP Outbound for Bastion Host SG
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4_bastion" {
  security_group_id = aws_security_group.bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# SG Rule: Allow RDP Inbound from Authorized IPv4 Addresses for Bastion Host SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_rdp_ipv4" {
  security_group_id = aws_security_group.bastion_host.id
  cidr_ipv4         = "73.166.82.125/32"  # Replace with your your authorized IP address
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}




# Private App Security Group
resource "aws_security_group" "private_app" {
 name        = "private_app_sg"
 description = "Only allow inbound traffic from public-application-sg"
 vpc_id      = aws_vpc.main.id

 tags = {
   Name = "private-application-sg"
 }
}

# SG Rule: Allow HTTP Inbound only from Public App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_http_from_public_app_sg" {
  security_group_id = aws_security_group.private_app.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  referenced_security_group_id = aws_security_group.public_app.id
}

# SG Rule: Allow SSH Inbound only from Public App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_ssh_from_public_app_sg" {
  security_group_id = aws_security_group.private_app.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  referenced_security_group_id = aws_security_group.public_app.id
}




# Private Data Security Groups and Rules (Common Database Ports)

# Redis/Memcache SG
resource "aws_security_group" "private_data_redis" {
  name        = "private_data_redis_sg"
  description = "Allow local traffic for private data resources"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-data-redis-sg"
  }
}

# SG Rule: Allow Redis/Memcache Inbound only from Private App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_redis_from_private_app_sg" {
  security_group_id = aws_security_group.private_data_redis.id
  from_port         = 6379
  ip_protocol       = "tcp"
  to_port           = 6379
  referenced_security_group_id = aws_security_group.private_app.id
}

# MySQL SG
resource "aws_security_group" "private_data_mysql" {
  name        = "private_data_mysql_sg"
  description = "Allow local traffic for private data resources"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-data-mysql-sg"
  }
}

# SG Rule: Allow MySQL Inbound only from Private App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_mysql_from_private_app_sg" {
  security_group_id = aws_security_group.private_data_mysql.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
  referenced_security_group_id = aws_security_group.private_app.id
}


# PostgreSQL SG
resource "aws_security_group" "private_data_postgresql" {
  name        = "private_data_postgresql_sg"
  description = "Allow local traffic for private data resources"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-data-postgresql-sg"
  }
}

# SG Rule: Allow PostgreSQL Inbound only from Private App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_postgresql_from_private_app_sg" {
  security_group_id = aws_security_group.private_data_postgresql.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
  referenced_security_group_id = aws_security_group.private_app.id
}


# Oracle SG
resource "aws_security_group" "private_data_oracle" {
  name        = "private_data_oracle_sg"
  description = "Allow local traffic for private data resources"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-data-oracle-sg"
  }
}

# SG Rule: Allow Oracle Inbound only from Private App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_oracle_from_private_app_sg" {
  security_group_id = aws_security_group.private_data_oracle.id
  from_port         = 1521
  ip_protocol       = "tcp"
  to_port           = 1521
  referenced_security_group_id = aws_security_group.private_app.id
}

# MSSQL SG
resource "aws_security_group" "private_data_mssql" {
  name        = "private_data_mssql_sg"
  description = "Allow local traffic for private data resources"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-data-mssql-sg"
  }
}

# SG Rule: Allow MSSQL Server Inbound only from Private App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_mssql_from_private_app_sg" {
  security_group_id = aws_security_group.private_data_mssql.id
  from_port         = 1433
  ip_protocol       = "tcp"
  to_port           = 1433
  referenced_security_group_id = aws_security_group.private_app.id
}


# MongoDB SG
resource "aws_security_group" "private_data_mongodb" {
  name        = "private_data_mongodb_sg"
  description = "Allow local traffic for private data resources"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-data-mongodb-sg"
  }
}

# SG Rule: Allow MongoDB Inbound only from Private App SG
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_mongodb_from_private_app_sg" {
  security_group_id = aws_security_group.private_data_mongodb.id
  from_port         = 27017
  ip_protocol       = "tcp"
  to_port           = 27017
  referenced_security_group_id = aws_security_group.private_app.id
}