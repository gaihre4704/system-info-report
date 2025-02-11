#!/bin/bash

# Gather system information
USERNAME=$(whoami)
DATE_TIME=$(date)
HOSTNAME=$(hostname)
OS=$(source /etc/os-release && echo "$PRETTY_NAME")
UPTIME=$(uptime -p)

# Gather hardware information
CPU=$(lscpu | grep "Model name" | cut -d ':' -f2 | xargs)
RAM=$(free -h | awk '/^Mem:/ {print $2}')
DISK_INFO=$(lsblk -o MODEL,SIZE | grep -v "MODEL")
VIDEO_CARD=$(lshw -C display 2>/dev/null | grep "product" | cut -d ':' -f2 | xargs)

# Gather network information
FQDN=$(hostname --fqdn)
HOST_IP=$(ip route get 1 | awk '{print $7; exit}')
GATEWAY_IP=$(ip route | grep default | awk '{print $3}')
DNS_SERVER=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | head -n 1)

# Gather system status information
USERS_LOGGED_IN=$(who | awk '{print $1}' | sort | uniq | paste -sd ", ")
DISK_SPACE=$(df -h --output=source,avail | grep '^/' | awk '{print $1 ": " $2}' | paste -sd ", ")
PROCESS_COUNT=$(ps aux | wc -l)
LOAD_AVERAGES=$(uptime | awk -F 'load average:' '{print $2}' | xargs)
LISTENING_PORTS=$(ss -tuln | awk '{print $5}' | grep -Eo '[0-9]+$' | sort -n | uniq | paste -sd ", ")
UFW_STATUS=$(sudo ufw status | grep "Status" | awk '{print $2}')
echo "--------------------"
echo "CPU: $CPU"
echo "RAM: $RAM"
echo "Disks: $DISKS"
echo "Video: $VIDEO"
echo ""
echo "Network Information"
echo "-------------------"
echo "FQDN: $FQDN"
echo "Host Address: $IP_ADDRESS"
echo "Gateway IP: $GATEWAY"
echo "DNS Server: $DNS_SERVER"
echo ""
echo "System Status"
echo "-------------"
echo "Users Logged In: $USERS"
echo "Disk Space: $DISK_SPACE"
echo "Process Count: $PROCESS_COUNT"
echo "Load Averages: $LOAD_AVERAGES"
echo "Listening Network Ports: $LISTENING_PORTS"
echo "UFW Status: $UFW_STATUS"
echo ""





