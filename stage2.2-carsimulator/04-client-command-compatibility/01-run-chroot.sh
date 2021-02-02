#!/bin/bash -e
# Link CarSimulator from it's "old" location such that the carsim commandline tool can find it.
mkdir -p /home/pi/Desktop/car-simulator
ln -s /opt/car-simulator /home/pi/Desktop/car-simulator/car-simulator

# Put a script to start the carsimulator. This one is used by the carsim commandline client
mkdir -p /home/pi/Desktop/python
cat > /home/pi/Desktop/python/startServer.py <<EOF
#!/usr/bin/python
import os
os.system('sudo systemctl restart carsimulator@can0')
os.system('sudo systemctl restart carsimulator@can1')
EOF

# Enable SSH as this is how the commandline client accesses the carsimulator
touch /boot/ssh
