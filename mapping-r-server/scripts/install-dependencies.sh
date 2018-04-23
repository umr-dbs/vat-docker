#!/bin/bash

set -e # Exit on error
set -x # Output command

apt-get update

apt-get install --yes r-cran-rcpp

# Install RInside
wget --no-verbose https://cran.r-project.org/src/contrib/Archive/RInside/RInside_0.2.13.tar.gz
tar -xvf RInside_0.2.13.tar.gz

cp /app/install/RInsideConfig.h RInside/inst/include/RInsideConfig.h

R CMD INSTALL RInside

R -e 'install.packages(c("caret", "ggplot2", "randomForest", "raster", "sp"), repos="http://cran.us.r-project.org", Ncpus='$(cat /proc/cpuinfo | grep processor | wc -l)')'

