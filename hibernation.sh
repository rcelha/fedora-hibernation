#!/bin/sh

set -exu

./install-btrfs-map-physical.sh
./create-swap.sh
swap_uuid=$(sudo findmnt -no UUID -T /swapfile)
./enable-dracut-resume.sh
swap_offset=$(./get-swap-offset.sh)
resume_offset=$(expr $swap_offset / 4096)
./configure-grub-offset.sh $swap_uuid $resume_offset
./install-services.sh
./install-sleep-conf.sh
