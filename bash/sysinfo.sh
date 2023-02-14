#!/bin/bash

# hostname and FQDN
HOSTNAME=$(hostname)
FQDN=$(hostname -f)

# OS info
OS=$(lsb_release -ds | cut -d " " -f 1-3)

# IP address
IP=$(ip route get 1 | awk '{print $7}')

# free disk space
SPACE=$(df -h / | awk 'NR==2{print $4}')

#Output template
TEMPLATE=$(cat << EOF
Report for $HOSTNAME
===============
FQDN: $FQDN
Operating System name and version: $OS
IP Address: $IP 
Root Filesystem Free Space: $SPACE
===============
EOF
)

# Output
echo -e "\n$TEMPLATE"
