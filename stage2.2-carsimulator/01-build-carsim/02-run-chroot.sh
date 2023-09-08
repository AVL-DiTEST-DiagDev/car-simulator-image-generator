#!/bin/bash -e
# Author :  Tobias Jaehnel (tjaehnel@gmail.com)
# 
echo "______________________________________________________________________________"
echo ""
echo "			Compile and install libdoip (AVL DiTEST GmbH)"
echo ""

# clone car-simulator
cd /opt
rm -rf libdoip
git clone -q https://github.com/AVL-DiTEST-DiagDev/libdoip.git
cd libdoip

# build and install libdoip
make all install
