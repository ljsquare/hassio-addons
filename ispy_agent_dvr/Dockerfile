FROM homeassistant/amd64-base-ubuntu:latest

ARG TZ=Europe/Amsterdam

RUN apt-get update \
    && apt-get install -y unzip software-properties-common alsa-utils libgdiplus tzdata curl

RUN add-apt-repository -y ppa:savoury1/ffmpeg4 && \
	add-apt-repository -y ppa:savoury1/ffmpeg5 && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y ffmpeg

# Data volumes
VOLUME ["/data","/data/Media/XML", "/data/Media/WebServerRoot/Media", "/data/Commands"]

WORKDIR /data

ADD https://ispyfiles.azureedge.net/downloads/Agent_Linux64_4_4_6_0.zip .
RUN unzip Agent_Linux64_4_4_6_0.zip  && rm Agent_Linux64_4_4_6_0.zip

RUN chmod +x Agent && \
  chmod +x agent-register.sh && \
  chmod +x agent-reset.sh && \
  chmod +x agent-reset-local-login.sh

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

ENTRYPOINT [ "/init" ]
# Define service entrypoint
CMD ["/data/Agent"]

LABEL \
  io.hass.version="VERSION" \
  io.hass.type="addon" \
  io.hass.arch="amd64"
