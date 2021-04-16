#!/bin/bash
set -euxo pipefail

sudo mv /tmp/bootstrap /bootstrap
if [ -f "/bootstrap/*.sh" ]; then
  sudo chmod +x /bootstrap/*.sh
fi

if [ -d "/bootstrap/services/" ]; then
  sudo cp /bootstrap/services/*.service /etc/systemd/system/
fi
