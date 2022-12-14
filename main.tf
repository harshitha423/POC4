#Defining the Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_ami" "linux_machine" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name    = "name"
    values  = ["amzn-ami-hvm*"]
  }
  
  filter {
    name    = "root-device-type"
    values  = ["ebs"]
  }
  
  filter {
    name    = "virtualization-type"
    values  = ["hvm"]
  }
}

#Creating web server instance in Web_sub
resource "aws_instance" "web_server_instance" {
  count          = var.flag == "false" ? 1 : 0
  instance_type  = var.instance_type
  ami            = data.aws_ami.linux_machine.id
  tags = {
    Name = "web_server"
  }
}
resource "aws_s3_bucket" "buc" {
  count  = var.flag == "true" ? 1 : 0
  bucket = "bucket90423"
}
