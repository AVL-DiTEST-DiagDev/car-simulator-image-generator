#!/bin/bash -e

cd /opt
rm -rf car-simulator-control
git clone -b carsimdiscovery https://github.com/AVL-DiTEST-DiagDev/car-simulator-control.git

cat > /opt/car-simulator-control/carsimulator-discovery.service <<EOF
[Unit]
Description="Diagnostic CarSimulator Discovery Service"

[Service]
TimeoutStartSec=0
WorkingDirectory=/opt/car-simulator-control
ExecStart=python3 /opt/car-simulator-control/discovery-raspi-python/carsimDiscoveryServer.py
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
EOF

systemctl enable /opt/car-simulator-control/carsimulator-discovery.service
