# Mapping Dependencies Image
FROM umrdbs/mapping-dependencies:latest AS builder

# Setup directories
WORKDIR /app
COPY scripts /app/install

# Get mapping-r-server and mapping-core
ARG MAPPING_CORE_VERSION=master
ARG MAPPING_R_SERVER_VERSION=master

RUN git clone --depth 1 --branch $MAPPING_R_SERVER_VERSION https://github.com/umr-dbs/mapping-r-server.git && \
    git clone --depth 1 --branch $MAPPING_CORE_VERSION https://github.com/umr-dbs/mapping-core.git

# Install Dependencies
RUN chmod +x /app/install/install-dependencies.sh && \
    /app/install/install-dependencies.sh

# Build Server
RUN chmod +x /app/install/build-server.sh && \
    /app/install/build-server.sh

# Create Service and Copy Config File and Create Symbolic Link
RUN mkdir /etc/service/mapping-r-server && \
    cp /app/install/mapping-r-server-service.sh /etc/service/mapping-r-server/run && \
    chmod +x /etc/service/mapping-r-server/run && \
    mkdir /app/conf/ && \
    cp /app/mapping-r-server/target/bin/conf/settings-default.toml /app/conf/settings-default.toml && \
    cp /app/install/settings.toml /etc/mapping.conf && \
    ln -s /app/config/mapping-r-server.toml /app/conf/settings.toml

# Update System, Clean up Scripts and APT when done.
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /app/install

# Make port 10200 available to the world outside this container
EXPOSE 10200

# Link to Config Directory
VOLUME /app/config

# Expose Log File
VOLUME /var/log/mapping-r-server

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

