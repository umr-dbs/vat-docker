# NodeJS Image
FROM node:9.11-alpine AS builder

# Setup directories
WORKDIR /app

# Add dependencies
RUN apk update && \
    apk add git

# Get WAVE
ARG WAVE_VERSION=master
RUN git clone --depth 1 --branch $WAVE_VERSION https://github.com/umr-dbs/wave.git

# Build WAVE
RUN cd /app/wave && \
    npm install && \
    npm run build-production

##################################################
##################################################
##################################################

# Apache Image
#FROM httpd:alpine AS runner
FROM php:apache-stretch AS runner

# Setup directories
WORKDIR /app

# Copy program and link config
COPY --from=builder /app/wave/dist /var/www/html/
RUN ln -s /app/config/wave.json /var/www/html/assets/config.json

# Configure Apache
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
RUN /usr/sbin/a2enmod deflate
COPY deflate.conf /etc/apache2/mods-enabled/deflate.conf

# Update System, Clean up Scripts and APT when done.
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /app/install

# Make port 80 available to the world outside this container
EXPOSE 80

# Config File
VOLUME /app/config

# Expose Log Files
VOLUME /var/log/apache2

