#!/bin/bash -e

echo "______________________________________________________________________________"
echo ""
echo "			Compile and install J1939 Module from the Kernel Sources  "
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

    echo "-- get kernel source --"
    rm -rf /opt/linux*
    rpi-source --nomake --default-config --dest /opt --processor 2
    cd /opt/linux

    echo "-- Enable J1939 module build --"
    echo 'CONFIG_CAN_J1939=m' >> .config

    echo "-- Build J1939 kernel module --"
    make modules_prepare
    make M=scripts/mod

    echo "-- Install J1939 kernel module --"
    make M=net/can/j1939 modules modules_install
    depmod $(uname -r)

    # remove uname fake
    /tmp/remove_fake_uname.sh

done
