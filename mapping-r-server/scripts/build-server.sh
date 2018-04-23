#!/bin/bash

set -e # Exit on error
set -x # Output command

cd mapping-r-server

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  .

make \
    -j$(cat /proc/cpuinfo | grep processor | wc -l) \
    r_server

