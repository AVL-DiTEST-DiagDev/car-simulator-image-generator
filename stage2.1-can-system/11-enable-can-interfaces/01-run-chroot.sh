#!/bin/bash -e
# Author :  Julia Fuchs   (julia.fuchs@avl.com)
#           Emil Brunner  (emil.brunner@avl.com)
#           Tobias Jaehnel (tjaehnel@gmail.com)

# bring up CAN interfaces automaticly on boot
echo "______________________________________________________________________________"
echo ""
echo "			Config network/interfaces.d for can0 and can1 "
echo ""

sudo bash -c 'cat << EOF > /etc/network/interfaces.d/can0
auto can0
iface can0 inet manual
   pre-up /sbin/ip link set can0 type can bitrate 500000 triple-sampling on
   up /sbin/ifconfig can0 up
   down /sbin/ifconfig can0 down
EOF'

sudo bash -c 'cat << EOF > /etc/network/interfaces.d/can1
auto can1
iface can1 inet manual
    pre-up /sbin/ip link set can1 type can bitrate 500000 triple-sampling on
    up /sbin/ifconfig can1 up
    down /sbin/ifconfig can1 down
EOF'
