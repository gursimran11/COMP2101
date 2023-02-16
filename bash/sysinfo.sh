#!/bin/bash
echo "My second script"
#sim1 is a variable for hostname
sim1=$(hostname)
#dat2 is a variable for fully qualified domain name(FQDN)
sim2=$(hostname)
sim3=$(hostnamectl | grep Operating)
#sim4  is a variable which will provide the IP address of the host name and not the 127 one
sim4=$(hostname -I)
#sim5 is a variable which will give us the system information
sim5=$(df -h / | tail -1 | awk '{print $4}')
cat <<EOF
Report for:$sim1
===============
FQDN:$sim2
Operating System name and version:$sim3
IP Address:$sim4
Root Filesystem Free Space:$sim5
===============
EOF
