#!/bin/sh

set -ex

# This makes it work on btrfs
sudo truncate -s 0 /swapfile
sudo chattr +C /swapfile
sudo btrfs property set /swapfile compression ""

# Now you can create the swapfile and configure swap on it
SWAP_SIZE=$(./get-memory-size.sh)
SWAP_SIZE=$(expr $SWAP_SIZE \* 2)
sudo fallocate -l ${SWAP_SIZE}Gib /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
# sudo swapon /swapfile  # Edit /etc/fstab to make it persistent across reboots
