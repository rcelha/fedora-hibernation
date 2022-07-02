#!/bin/sh

set -ex

mkdir -p ~/.local/bin/
cd ~/.local/bin
wget -q 'https://raw.githubusercontent.com/osandov/osandov-linux/61679ecd914d653bab14d0e752595e86b9f50513/scripts/btrfs_map_physical.c'
gcc -O2 -o btrfs_map_physical btrfs_map_physical.c
rm btrfs_map_physical.c
