#!/bin/bash
set -euxo pipefail

sudo tee /etc/yum.repos.d/wireguard.repo > /dev/null <<EOF
[copr:copr.fedorainfracloud.org:jdoss:wireguard]
name=Copr repo for wireguard owned by jdoss
baseurl=https://download.copr.fedorainfracloud.org/results/jdoss/wireguard/epel-7-\$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/jdoss/wireguard/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

sudo yum install -y wireguard-dkms wireguard-tools
sudo tee /etc/modules-load.d/wireguard.conf > /dev/null <<EOF
wireguard
EOF
