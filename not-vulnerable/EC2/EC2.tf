# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# 1. create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name=var.name
  }
}

# 2. Create a subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name=var.name
  }
}

# 3. Create internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name=var.name
  }
}

# 4. Create route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name=var.name
  }
}

# 5. Associate route table to subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# 6. Create security group
resource "aws_security_group" "main" {
  name        = "Security-Group"
  description = "Allow SSH, HTTPS and HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    
    ## Security Fix ##
    cidr_blocks = ["80.80.80.80/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name=var.name
  }
}

# 7. Create network interface
resource "aws_network_interface" "main" {
  subnet_id       = aws_subnet.main.id
  private_ips     = ["10.0.0.101"]
  security_groups = [aws_security_group.main.id]

  tags = {
    Name=var.name
  }
}

# 8. Assign elastic IP to network interface
resource "aws_eip" "main" {
  vpc                       = true
  network_interface         = aws_network_interface.main.id
  associate_with_private_ip = "10.0.0.101"
  depends_on = [aws_internet_gateway.main, aws_instance.main]

  tags = {
    Name=var.name
  }
}

# 9. Create EC2 instance
 resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = "t2.micro"
  #subnet_id = aws_subnet.main.id
  availability_zone = "us-east-1a"
  key_name = "us-east-1-win"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.main.id
  }

  ## Security Fix ##
  metadata_options {
    http_tokens="required"
    http_endpoint="enabled"
  }

  ## Security Fix ##
  root_block_device {
    encrypted = true
    kms_key_id = "arn:aws:kms:us-east-1:975300453774:key/cc657d9e-c5a9-4d10-9c13-f39580730713"
    volume_size = 8
    tags = {
    Name=var.name
    }
  }

  tags = {
    Name=var.name
  }
}