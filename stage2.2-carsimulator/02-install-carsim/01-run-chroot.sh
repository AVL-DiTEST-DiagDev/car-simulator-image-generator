#!/bin/bash -e

cat > /opt/car-simulator/carsimulator@.service <<EOF
[Unit]
Description="Diagnostic CarSimulator on %I"

[Service]
TimeoutStartSec=0
WorkingDirectory=/opt/car-simulator/dist/Debug/GNU-Linux
ExecStart=/opt/car-simulator/dist/Debug/GNU-Linux/amos-ss17-proj4 %i
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
EOF

systemctl enable /opt/car-simulator/carsimulator@.service
systemctl enable carsimulator@can0
systemctl enable carsimulator@can1
