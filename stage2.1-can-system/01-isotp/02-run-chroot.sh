#!/bin/bash -e
# ------------
# NOTE: The ISO-TP module is part of the linux kernel from 5.10
#       So once Raspberry Pi OS upgrades to that kernel version
#       the build process will change or is not even necessary anymore
#
# compile and install ISO-TP from hartkopp (Volkswagen AG)
# Linux Kernel Module for ISO 15765-2:2016 CAN transport protocol 
# https://github.com/hartkopp/can-isotp
# https://github.com/hartkopp/can-isotp/blob/master/README.isotp
# Author :  Julia Fuchs   (julia.fuchs@avl.com)
#           Emil Brunner  (emil.brunner@avl.com)
#           Tobias Jaehnel (tjaehnel@gmail.com)

echo "______________________________________________________________________________"
echo ""
echo "			Compile and install ISO-TP from hartkopp (Volkswagen AG)  "
echo "			Kernel Module for ISO 15765-2:2016 CAN transport protocol "
echo ""

# Run the build for all available arm7 kernels (i.e. different plattforms)
KERNEL_VERSIONS=$(
    cd /lib/modules
    ls -d *-v7*
)

for kernelVersion in $KERNEL_VERSIONS
do

    KERNEL_ARCHITECTURE="arm7"
    /tmp/create_fake_uname.sh $kernelVersion $KERNEL_ARCHITECTURE


    cd /opt
    rm -rf can-isotp
    git clone https://github.com/hartkopp/can-isotp.git
    cd can-isotp
    sudo make
    sudo make modules_install
    sudo depmod $(uname -r)
    #sudo insmod ./net/can/can-isotp.ko
    #sudo modprobe can-isotp

    # remove uname fake
    /tmp/remove_fake_uname.sh
done