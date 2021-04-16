data "aws_ami" "default_amd64" {
  most_recent = true
  name_regex  = "^base-amd64-*"
  owners      = ["self"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "terraform_remote_state" "ssm" {
  backend = "s3"
  config = {
    acl    = "bucket-owner-full-control"
    bucket = "hpydev-devops"
    key    = "terraform_remote_state/terraform_ssm.tfstate.json"
    region = "us-east-2"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}
