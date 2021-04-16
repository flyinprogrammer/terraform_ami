#!/bin/bash
set -euxo pipefail

## update so that the rest of the installs use latest
sudo yum update -y

## install packages with amazon magic
sudo amazon-linux-extras install docker epel corretto8
sudo usermod -a -G docker ec2-user

if command -v ec2-metadata; then
  az=$(ec2-metadata -z | cut -d " " -f 2)
else
  az="us-east-2a"
fi

region=${az::-1}
sudo yum install -y "https://s3.${region}.amazonaws.com/amazon-ssm-${region}/latest/linux_amd64/amazon-ssm-agent.rpm"

## needed because sometimes epel is going to unlock
## more updates
sudo yum update -y

# Upgrade our host
sudo yum upgrade -y

## Extra Packages
sudo yum install -y \
  htop \
  tree
