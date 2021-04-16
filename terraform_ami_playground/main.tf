resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = "ami-base"
  public_key = tls_private_key.default.public_key_openssh
}

data "local_file" "script" {
  filename = "cloudinit.sh"
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.local_file.script.content
  }
}

resource "aws_launch_template" "default" {
  name                                 = "ami-tester"
  image_id                             = data.aws_ami.default_amd64.id
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = [data.aws_security_group.default.id]
  user_data                            = data.template_cloudinit_config.config.rendered
  key_name                             = aws_key_pair.default.key_name
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = "gp3"
      volume_size = 8
      iops        = 3000
      throughput  = 125
    }
  }
  iam_instance_profile {
    name = "AWSDefaultEC2Role"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
  }
}

resource "aws_spot_fleet_request" "default" {
  iam_fleet_role                      = "arn:aws:iam::666236088316:role/aws-ec2-spot-fleet-tagging-role"
  target_capacity                     = 1
  spot_price                          = "0.02"
  instance_interruption_behaviour     = "terminate"
  terminate_instances_with_expiration = true
  launch_template_config {
    launch_template_specification {
      id      = aws_launch_template.default.id
      version = aws_launch_template.default.latest_version
    }
    overrides {
      instance_type = "t3a.micro"
    }
    overrides {
      instance_type = "t3a.small"
    }
    overrides {
      instance_type = "t3a.medium"
    }
  }
}
