# Public App Subnet Configuration

resource "aws_subnet" "public_app_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "ap-northeast-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-app-subnet-a"
  }
}

resource "aws_subnet" "public_app_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "ap-northeast-3b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-app-subnet-b"
  }
}

resource "aws_subnet" "public_app_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "ap-northeast-3c"

  map_public_ip_on_launch = true

  tags = {
    Name = "public-app-subnet-c"
  }
}

# Private App Subnet Configuration

resource "aws_subnet" "private_app_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.11.0/24"
  availability_zone = "ap-northeast-3a"

  tags = {
    Name = "private-app-subnet-a"
  }
}

resource "aws_subnet" "private_app_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.22.0/24"
  availability_zone = "ap-northeast-3b"


  tags = {
    Name = "private-app-subnet-b"
  }
}

resource "aws_subnet" "private_app_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.33.0/24"
  availability_zone = "ap-northeast-3c"


  tags = {
    Name = "private-subnet-c"
  }
}

# Private Data Subnet Configuration

resource "aws_subnet" "private_data_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.44.0/24"
  availability_zone = "ap-northeast-3a"


  tags = {
    Name = "private-data-subnet-a"
  }
}

resource "aws_subnet" "private_data_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.55.0/24"
  availability_zone = "ap-northeast-3b"

  tags = {
    Name = "private-data-subnet-b"
  }
}

resource "aws_subnet" "private_data_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.66.0/24"
  availability_zone = "ap-northeast-3c"
  tags = {
    Name = "private-data-subnet-c"
  }
}