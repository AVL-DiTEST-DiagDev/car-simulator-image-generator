#!/bin/bash -e
# Author :  Julia Fuchs   (julia.fuchs@avl.com)
#           Emil Brunner  (emil.brunner@avl.com)
#           Tobias Jaehnel (tjaehnel@gmail.com)

# Enable SPI 
#  do_spi 0 = enable SPI
#  do_spi 1 = disable SPI
#
echo "______________________________________________________________________________"
echo ""
echo "			Enable SPI Port "
echo ""
sudo raspi-config nonint do_spi 0

# Enable MCP2515 CAN bus controllers 
echo "______________________________________________________________________________"
echo ""
echo "			Enable MCP2515 CAN bus controllers  "
echo ""
sudo bash -c 'cat << EOF >> /boot/config.txt
# Enable MCP2515 CAN bus controllers for PiCAN2 Duo CAN-Bus Board
#   CAN 1 (can0)
#   GPIO 25 Rx-IRQ
#   CAN 2 (can1)
#   GPIO 24 Rx-IRQ
#
# Syntax for Raspberry 2
#dtoverlay=mcp2515-can1-overlay,oscillator=20000000,interrupt=24
#dtoverlay=mcp2515-can0-overlay,oscillator=20000000,interrupt=25
# Syntax for Raspberry 3
dtoverlay=mcp2515-can1,oscillator=20000000,interrupt=24
dtoverlay=mcp2515-can0,oscillator=20000000,interrupt=25
dtoverlay=spi-bcm2835-overlay
EOF'
