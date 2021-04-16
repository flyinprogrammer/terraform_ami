#!/bin/bash
set -euxo pipefail

sleep 10
sudo cloud-init status --wait
