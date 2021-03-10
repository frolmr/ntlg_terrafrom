provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  web_instance_type_map = {
    default = "t3.micro"
  }
}

locals {
  web_instance_count_map = {
    default = 1
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web_instance_type_map[terraform.workspace]
  count         = local.web_instance_count_map[terraform.workspace]

  tags = {
    Name = "HelloNetology"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

terraform {
  required_version = "~> 0.14"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "frol"

    workspaces {
      name = "ntlg_terraform"
    }
  }
}
