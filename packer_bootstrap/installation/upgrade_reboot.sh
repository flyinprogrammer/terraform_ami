#!/bin/bash
set -euxo pipefail

## update so that the rest of the installs use latest
sudo yum update -y

## install packages with amazon magic
sudo amazon-linux-extras install epel kernel-ng

## needed because sometimes epel is going to unlock
## more updates
sudo yum update -y

# Upgrade our host
sudo yum upgrade -y

sudo reboot
