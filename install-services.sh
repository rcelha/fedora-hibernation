#!/bin/sh

set -exu

# Create service for enabling the swap file and disabling the zram swap device before hibernation
sudo rm -f /etc/systemd/system/hibernate-preparation.service
sudo touch /etc/systemd/system/hibernate-preparation.service
echo '[Unit]
Description=Enable swap file and disable zram before hibernate
Before=systemd-hibernate.service
Before=systemd-suspend-then-hibernate.service

[Service]
User=root
Type=oneshot
ExecStart=/bin/bash -c "/usr/sbin/swapon /swapfile && /usr/sbin/swapoff /dev/zram0"

[Install]
WantedBy=systemd-hibernate.service
WantedBy=systemd-suspend-then-hibernate.service
' | sudo tee -a /etc/systemd/system/hibernate-preparation.service
sudo systemctl enable hibernate-preparation.service

# Disable the swap file when the system just resumed
sudo rm -f /etc/systemd/system/hibernate-resume.service
sudo touch /etc/systemd/system/hibernate-resume.service
echo '[Unit]
Description=Disable swap after resuming from hibernation
After=hibernate.target
After=suspend-then-hibernate.target

[Service]
User=root
Type=oneshot
ExecStart=/usr/sbin/swapoff /swapfile

[Install]
WantedBy=hibernate.target
WantedBy=suspend-then-hibernate.target
' | sudo tee -a /etc/systemd/system/hibernate-resume.service
sudo systemctl enable hibernate-resume.service

# To avoid false positives regarding to swap space, due to the zram device existence, we need to disable some checks
sudo mkdir -p /etc/systemd/system/systemd-logind.service.d/
cat <<-EOF | sudo tee /etc/systemd/system/systemd-logind.service.d/override.conf
[Service]
Environment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1
EOF

sudo mkdir -p /etc/systemd/system/systemd-hibernate.service.d/
sudo mkdir -p /etc/systemd/system/systemd-suspend-then-hibernate.service.d/
cat <<-EOF | sudo tee /etc/systemd/system/systemd-hibernate.service.d/override.conf /etc/systemd/system/systemd-suspend-then-hibernate.service.d/override.conf
[Service]
Environment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1
EOF
