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

# PATCH - fix path to libcrc/crcccitt.c in ecu_lua_script.cpp
cat<<EOF | patch --directory=src
*** ecu_lua_script.cpp  2019-05-02 02:22:45.081810699 +0100
--- ecu_lua_script.cpp  2019-05-02 02:25:16.741270323 +0100
***************
*** 5,11 ****
   */

  #include "ecu_lua_script.h"
! #include "crcccitt.c"
  #include "utilities.h"
  #include <iostream>
  #include <string.h>
--- 5,11 ----
   */

  #include "ecu_lua_script.h"
! #include "libcrc/crcccitt.c"
  #include "utilities.h"
  #include <iostream>
  #include <string.h>
EOF


# make car-simulator
make

# place this file into /dist/Debug/GNU-Linux/lua_config/
mkdir -p dist/Debug/GNU-Linux/lua_config
cp "example luas/example.lua"  dist/Debug/GNU-Linux/lua_config/example.lua
chown -R pi dist/Debug/GNU-Linux/lua_config
