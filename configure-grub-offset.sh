#!/bin/sh

set -exu

swap_uuid=$1
resume_offset=$2

# Update grub settings and grub
sudo grubby --update-kernel=ALL --args=resume=UUID=$swap_uuid
sudo grubby --update-kernel=ALL --args=resume_offset=$resume_offset
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
