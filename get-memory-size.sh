#!/bin/sh

set -e
free -g | awk 'FNR == 2 {print $2}'
