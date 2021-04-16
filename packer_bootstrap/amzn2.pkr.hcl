source "amazon-ebs" "amd64" {
  ami_name            = "base-amd64-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  region              = "us-east-2"
  spot_price          = "0.02"
  spot_instance_types = ["t3a.micro", "t3a.small", "t3a.medium"]

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
    }
    owners      = ["137112412989"]
    most_recent = true
  }

  launch_block_device_mappings {
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "gp3"
    throughput            = 125
    iops                  = 3000
    delete_on_termination = true
  }

  communicator                = "ssh"
  associate_public_ip_address = true
  ssh_interface               = "public_ip"
  ssh_username                = "ec2-user"
}

source "vagrant" "local" {
  source_path  = "bento/amazonlinux-2"
  communicator = "ssh"
  box_name     = "hpydev/base"
}

build {
  sources = [
    "source.amazon-ebs.amd64",
    "source.vagrant.local"
  ]

  provisioner "file" {
    source      = "bootstrap"
    destination = "/tmp/bootstrap"
  }

  provisioner "shell" {
    scripts = [
      "installation/move_bootstrap.sh",
      "installation/wait_on_boot.sh"
    ]
  }

  provisioner "shell" {
    scripts = [
      "installation/base_packages.sh",
    ]
  }
}
