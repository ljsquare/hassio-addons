# Use Ubuntu LTS
FROM ubuntu:22.04

#ARG BUILD_FROM
#FROM $BUILD_FROM

# Define download location variables

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Amsterdam
ARG name


# Download and install dependencies
RUN apt-get update \
    && apt-get install -y wget unzip software-properties-common alsa-utils

# Download/Install iSpy Agent DVR:
# Check if we were given a specific version
RUN echo "Downloading latest" && \
    wget -c $(wget -qO- "https://www.ispyconnect.com/api/Agent/DownloadLocation4?platform=Linux64&fromVersion=0" | tr -d '"') -O agent.zip; \
    unzip agent.zip -d /data && \
    rm agent.zip

# Install libgdiplus, used for smart detection
RUN apt-get install -y libgdiplus

# Install ffmpeg
RUN add-apt-repository -y ppa:savoury1/ffmpeg4 && \
        add-apt-repository -y ppa:savoury1/ffmpeg5 && \
        apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y ffmpeg

# Install Time Zone
RUN apt-get install -y tzdata

# Install curl, used for calling external webservices in Commands
RUN apt-get install -y curl

# Clean up
RUN apt-get -y --purge remove unzip wget \
    && apt autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Docker needs to run a TURN server to get webrtc traffic to and from it over forwarded ports from the host
# These are the default ports. If the ports below are modified here you'll also need to set the ports in XML/Config.xml
# for example <TurnServerPort>3478</TurnServerPort><TurnServerMinPort>50000</TurnServerMinPort><TurnServerMaxPort>50010</TurnServerMaxPort>
# The main server port is overridden by creating a text file called port.txt in the root directory containing the port number, eg: 8090
# To access the UI you must use the local IP address of the host, NOT localhost - for example http://192.168.1.12:8090/

# Modify permission for execution
RUN echo "Adding executable permissions" && \
    chmod +x /data/Agent && \
    chmod +x /data/agent-register.sh && \
    chmod +x /data/agent-reset.sh && \
    chmod +x /data/agent-reset-local-login.sh

# Define default environment variables
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# Fix a memory leak on encoded recording
ENV MALLOC_TRIM_THRESHOLD_=100000

# Main UI port
EXPOSE 8090

# STUN server port
EXPOSE 3478/udp

# TURN server UDP port range
EXPOSE 50000-50010/udp

# Data volumes
VOLUME ["/data/Media/XML", "/data/Media/WebServerRoot/Media", "/data/Commands"]

# Define service entrypoint
CMD ["/data/Agent"]

LABEL \
  io.hass.version="VERSION" \
  io.hass.type="addon" \
  io.hass.arch="amd64"
