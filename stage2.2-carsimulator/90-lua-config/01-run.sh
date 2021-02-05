#!/bin/bash
echo "______________________________________________________________________________"
echo ""
echo "			Installing Lua configuration files"
echo ""

install -d -v -m 777 "${ROOTFS_DIR}/opt/car-simulator/dist/Debug/GNU-Linux/lua_config/"
install -v -m 666 $(dirname $0)/../lua_config/*		"${ROOTFS_DIR}/opt/car-simulator/dist/Debug/GNU-Linux/lua_config/"
