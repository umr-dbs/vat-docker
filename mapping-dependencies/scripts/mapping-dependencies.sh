#!/bin/bash

set -e # Exit on error
set -x # Output command

# Add custom PPAs
## GDAL
add-apt-repository ppa:ubuntugis/ppa
## Poco
add-apt-repository ppa:gezakovacs/poco
# CMake >= 3.7
#add-apt-repository ppa:adrozdoff/cmake

apt-get update

# Programs
## Build tools
apt-get install --yes \
    clang \
    curl \
    git \
    make \
    python-setuptools \
    sqlite3 \
    xxdiff

## CMake
easy_install pip
pip install --upgrade cmake

# Dependencies
apt-get install --yes \
    libarchive-dev \
    libboost-all-dev \
    libbz2-dev \
    libcurl3-dev \
    libfcgi-dev \
    libgdal-dev \
    libgeos++-dev \
    libgeos-dev \
    libgtest-dev \
    libjpeg-dev \
    libpng-dev \
    libpoco-dev \
    libpqxx-dev \
    libproj-dev \
    libpugixml-dev \
    libsqlite3-dev \
    liburiparser-dev \
    libxerces-c-dev \
    valgrind

