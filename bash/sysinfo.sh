#!/bin/bash
echo "My first Script"
echo "FQDN : $(hostname)"
echo "Host Information:"
hostnamectl
echo "IP Addresses: $(hostname -I)"
echo "Root Filesystem Status:"
df -h /
