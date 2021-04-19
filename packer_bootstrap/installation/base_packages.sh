#!/bin/bash
set -euxo pipefail

sudo package-cleanup --assumeyes --oldkernels --count=1

## install packages with amazon magic
sudo amazon-linux-extras install docker corretto8
sudo usermod -a -G docker ec2-user

if command -v ec2-metadata; then
  az=$(ec2-metadata -z | cut -d " " -f 2)
else
  az="us-east-2a"
fi

region=${az::-1}
sudo yum install -y "https://s3.${region}.amazonaws.com/amazon-ssm-${region}/latest/linux_amd64/amazon-ssm-agent.rpm"

## Extra Packages
sudo yum install -y \
  htop \
  tree
