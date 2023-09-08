#!/bin/bash -e
# Author :  Julia Fuchs   (julia.fuchs@avl.com)
#           Emil Brunner  (emil.brunner@avl.com)
#           Tobias Jaehnel (tjaehnel@gmail.com)
# 
echo "______________________________________________________________________________"
echo ""
echo "			Compile and install car-simulator (AVL DiTEST GmbH)"
echo ""

# clone car-simulator
cd /opt
rm -rf car-simulator
git clone -q https://github.com/AVL-DiTEST-DiagDev/car-simulator.git
cd car-simulator

# make car-simulator
make
