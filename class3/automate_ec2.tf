# Cloud Provider
variable "region"{}
provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "selected" {
  default="true"
}

/*resource "aws_subnet_ids" "example" {
  vpc_id            = "${data.aws_vpc.vpc_security_group_ids}"
}*/

# Security Group Config For AWS EC2 Instance
resource "aws_security_group" "firewall" {
  name        = "firewall"
  description = "Allow Port 22 and Port 80 access to the outside World."

  # Inbound Rules
  ingress {
    description = "Allow acesss to port 22"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow acess for apache sever for port 80"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

# AWs Instance
resource "aws_instance" "aws_ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.firewall.id}"]
  #subnet_id=element(tolist(["${aws_subnet_ids.example.vpc_ids}"]),1)
  key_name=var.key_name
  tags = {
    Environment = var.environment
  }
}