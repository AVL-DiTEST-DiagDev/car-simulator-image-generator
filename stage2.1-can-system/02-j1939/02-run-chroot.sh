#!/bin/bash -e

echo "______________________________________________________________________________"
echo ""
echo "			Compile and install J1939 Module from the Kernel Sources  "
echo ""

echo "-- get kernel source --"
cd /root
echo "-- update rpi-source --"
# Manually upgading rpi-source as at the time of writing the packaged version did not support --download-only
# Avoiding the upgrader integrated in rpi-source as it make Github API calls which are limited to 60/hour by Github
wget https://raw.githubusercontent.com/RPi-Distro/rpi-source/master/rpi-source -O $(type -p rpi-source)
echo "-- download kernel source --"
rpi-source --skip-update --download-only --dest /root --processor 0

# Run the build for all available arm7 and arm7l kernels

PROCESSORS_VERSION=(v7 v7l)
PROCESSORS_RPISOURCE_PARAMETER=(2 3)
PROCESSORS_ARCH=(arm7 arm7l)

for procIndex in "${!PROCESSORS_VERSION[@]}"
do
    processorVersion=${PROCESSORS_VERSION[procIndex]}
    processorParameter=${PROCESSORS_RPISOURCE_PARAMETER[procIndex]}
    processorArch=${PROCESSORS_ARCH[procIndex]}

    KERNEL_VERSIONS=$(
        cd /lib/modules
        ls -d *-${processorVersion}+
    )

    for kernelVersion in $KERNEL_VERSIONS
    do
        echo "--- Build J1939 Module for kernel version $kernelVersion ---"
        /tmp/create_fake_uname.sh $kernelVersion $processorArch

        echo "uname -r"
        uname -r
        echo "uname -m"
        uname -m

        echo "-- get kernel source --"
        cp /root/linux-*.tar.gz /opt
        rpi-source --skip-update --nomake --default-config --dest /opt --processor $processorParameter

        cd /opt/linux

        echo "-- Enable J1939 module build --"
        echo 'CONFIG_CAN_J1939=m' >> .config

        echo "-- Build J1939 kernel module --"
        make modules_prepare
        make M=scripts/mod

        echo "-- Install J1939 kernel module --"
        make M=net/can/j1939 modules modules_install
        depmod $(uname -r)

        echo "uname -r"
        uname -r
        echo "uname -m"
        uname -m

        rm -rf /opt/linux-*
        rm -f /opt/linux

        # remove uname fake
        /tmp/remove_fake_uname.sh

    done
done

rm -rf /root/linux-*
rm -f /root/linux