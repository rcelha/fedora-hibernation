#!/bin/sh

set -exu

sudo mkdir -p /etc/systemd/sleep.conf.d/
sudo cp sleep.conf /etc/systemd/sleep.conf.d/
