#!/bin/bash

which lxd > /dev/null
if [ $? -ne 0 ]; then
    # if we don't have lxd, install it
    echo "lxd is not installed, installing now"
    sudo snap install lxd
    if [ $? -ne 0 ]; then
        echo "lxd installation failed, it is required for this script. Exiting"
        exit 1
    fi
fi

#lxd software is installed, let's make sure it is running
sudo lxd init --auto

# do we have lxdbr0 interface?
ip link show lxdbr0 > /dev/null

# if we have lxdbr0 proceed to next step
if [ $? -ne 0 ]; then
    echo "lxdbr0 interface is not present, creating it now"
    sudo lxd init --auto
    if [ $? -ne 0 ]; then
        echo "lxdbr0 interface creation failed, it is required for this script. Exiting"
        exit 1
    fi
fi

lxc list | grep -w COMP2101-S22

if [ $? -eq 0 ]; then
    echo "Container exists, starting now."
    lxc start COMP2101-S22
    if [ $? -ne 0 ]; then
        lxc launch ubuntu:20.04 COMP2101-S22
    fi
fi

# wait for the container to start just to make sure it is ready
echo "Waiting for container to start"
sleep 5

# list all available containers
lxc list

# this is to get the IP address of COMP2101-S22 and store it in a variable
compIP=$(lxc list | grep COMP2101-S22 | awk '{print$6}')
echo "The IP address of the container is $compIP"

cat /etc/hosts | grep -q COMP2101-S22

if [ $? -eq 0 ]; then
    echo "COMP2101-S22 is  already in your /etc/hosts"
else
    echo "COMP2101-S22 is not in /etc/hosts, adding it now"
    echo "$compIP COMP2101-S22" | sudo tee -a /etc/hosts
fi

lxc exec COMP2101-S22 -- apt update -qq

lxc exec COMP2101-S22 -- apt install apache2 -qqy

lxc exec COMP2101-S22 -- systemctl start apache2

curl http://COMP2101-S22

# if you can access COMP2101-S22 echo success message
if [ $? -eq 0 ]; then
    echo "Congratulations! You can access COMP2101-S22. :)"
    exit 0
else
    echo "Sorry, you cannot access COMP2101-S22 from this container :("
    exit 1
fi
