#!/bin/sh

set -e

sudo ~/.local/bin/btrfs_map_physical /swapfile | sed -n '2p' | awk '{print $NF}'
