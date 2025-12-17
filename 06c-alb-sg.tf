# Public Application Load Balancer Security Group
resource "aws_security_group" "public_alb" {
  name        = "public_alb_sg"
  description = "Allow all inbound/outbound traffic for HTTP and HTTPS"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "public-application-lb-sg"
  }
}

# SG Rule: Allow all HTTP Inbound for Public ALB SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_http_ipv4_public_alb" {
  security_group_id = aws_security_group.public_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

# SG Rule: Allow all HTTPS Inbound for Public ALB SG
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_https_ipv4_public_alb" {
  security_group_id = aws_security_group.public_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

# SG Rule: Allow all Outbound IPv4 for Public ALB SG
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4_public_alb" {
  security_group_id = aws_security_group.public_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}