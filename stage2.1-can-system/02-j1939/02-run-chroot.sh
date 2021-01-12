#!/bin/bash -e

# Fake uname output
cat > /usr/local/bin/uname << 'EOF'
#!/bin/bash
if [ "$1" == "-r" ]
then
    # just respond with the last v7 kernel version found
    cd /lib/modules
    ls -d *-v7+ | tail -1
elif [ "$1" == "-m" ]
then
    echo "arm7"
fi
EOF

chmod +x /usr/local/bin/uname

echo "-- get kernel source --"
rm -rf /opt/linux*
#rpi-source --nomake --delete --default-config
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
rm -f /usr/local/bin/uname
