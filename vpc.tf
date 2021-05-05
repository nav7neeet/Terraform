# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# 1. create a VPC
resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name="my-vpc"
  }
}

