#!/bin/sh
set -e

apt-get update
apt-get install --yes \
  ruby \
  make

gem install funit
