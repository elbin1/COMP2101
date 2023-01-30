#!/bin/bash 
echo "System Information" 
echo "FODN:"
hostname -f 
echo "Host Information." 
cat /etc/*-release 
echo "IP Addresses:" 
hostname -I
echo "Root Filesystem Status:"
df /
