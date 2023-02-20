#!/bin/bash

# Step 1: Install lxd if necessary, do not install lxc-utils
if ! command -v lxd &> /dev/null
then
    sudo apt-get update
    sudo snap install lxd
fi

# Step 2: Run lxd init --auto if no lxdbr0 interface exists
if ! ip a | grep -q lxdbr0
then
    sudo lxd init --auto
fi

# Step 3: Launch a container running Ubuntu 20.04 server named COMP2101-S22 if necessary
if ! lxc list | grep -q COMP2101-S22
then
    lxc launch ubuntu:20.04 COMP2101-S22
fi

# Step 4: Add or update the entry in /etc/hosts for hostname COMP2101-S22 with the container’s current IP address if necessary
if ! grep -q "COMP2101-S22" /etc/hosts
then
    container_ip=$(lxc list | awk '/COMP2101-S22/{print $6}')
    echo "$container_ip COMP2101-S22" | sudo tee -a /etc/hosts
fi

# Step 5: Install Apache2 in the container if necessary
if ! lxc exec COMP2101-S22 -- dpkg -s apache2 &> /dev/null
then
    lxc exec COMP2101-S22 -- apt-get update
    lxc exec COMP2101-S22 -- apt-get install -y apache2
fi

# Step 6: Retrieve the default web page from the container’s web service with curl http://COMP2101-S22 and notify the user of success or failure
response=$(curl -s -o /dev/null -w "%{http_code}" http://COMP2101-S22)
if [ $response -eq 200 ]
then
    echo "Success: Web server is up and running."
else
    echo "Failure: Could not retrieve web page."
fi
