#!/bin/bash
echo "My second script"
#dat1 is a variable which will give the hostname
sim1=$(hostname)
#dat2 is a variable which will give the fully qualified domain name(FQDN)
sim2=$(hostname)
#dat 3 will give the whole information regarding the system and grep will trim it operating system information
sim3=$(hostnamectl | grep Operating)
#dat4  is a variable which will provide the IP address of the host name
sim4=$(hostname -I)
#dat5 is a variable which will give us the system indormation in which awk is used to give only the fourth line and then tail is used because we only want the last line
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
