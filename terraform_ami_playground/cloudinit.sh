#!/bin/bash

function start_and_enable() {
  SERVICE_NAME=${1:requries service name}
  sudo systemctl start "$SERVICE_NAME"
  if [ "$(sudo systemctl is-enabled "$SERVICE_NAME")" == "disabled" ]; then
    sudo systemctl enable "$SERVICE_NAME"
  fi
}

start_and_enable amazon-ssm-agent
start_and_enable nginx
