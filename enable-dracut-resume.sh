#!/bin/sh

set -ex

# Add to the initramfs the necessary modules for resuming the system
sudo rm -f /etc/dracut.conf.d/resume.conf
sudo touch /etc/dracut.conf.d/resume.conf
echo 'add_dracutmodules+=" resume "' | sudo tee -a /etc/dracut.conf.d/resume.conf
sudo dracut -f
