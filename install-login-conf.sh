#!/bin/sh

set -exu

sudo mkdir -p /etc/systemd/logind.conf.d/
sudo cp login.conf /etc/systemd/logind.conf.d/
