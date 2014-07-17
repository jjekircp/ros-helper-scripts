#!/bin/sh
# prerequisites: iproute2 grep coreutils


if [ ! "$1" ]; then
    echo "Usage: . rosremote.sh ROS_MASTER_IP"
    return 1
fi

ROS_MASTER_IP="${1}"

if ! grep -E "${ROS_MASTER_IP}\b" /etc/hosts >/dev/null 2>&1; then
    echo "Warning: Could not find \`${ROS_MASTER_IP}' in /etc/hosts."
    echo "If you are unable to reach the ROS master by its hostname, you may encounter communication issues."
    
fi

ROS_MASTER_IF=$(ip route get ${ROS_MASTER_IP} | grep -Eo "dev [^ ]+" | cut -d' ' -f2)
ROS_MASTER_URI="http://${ROS_MASTER_IP}:11311"
ROS_IP=$(ifconfig ${ROS_MASTER_IF} | grep -Eo "inet addr:[^ ]+" | cut -d: -f2)

echo "ROS_MASTER_URI is ${ROS_MASTER_URI}"
echo "ROS_IP is ${ROS_IP}"

export ROS_MASTER_IP ROS_IP
