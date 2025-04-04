ARG BUILD_FROM
FROM $BUILD_FROM

ARG TZ=Europe/Amsterdam

RUN  echo 'deb http://http.us.debian.org/debian testing main non-free contrib' >> /etc/apt/sources.list &&\
    apt update &&\
    apt install -y unzip alsa-utils libgdiplus ffmpeg wget xz-utils

VOLUME ["/data"]

#ADD https://ispyfiles.azureedge.net/downloads/Agent_Linux64_4_4_6_0.zip /agent/
RUN wget -c $(wget -qO- "https://www.ispyconnect.com/api/Agent/DownloadLocation4?platform=Linux64&fromVersion=0" | tr -d '"') -O agent.zip; \
    unzip agent.zip -d /agent && \
    rm agent.zip

COPY run /agent/

RUN chmod +x /agent/Agent && \
  chmod +x /agent/agent-register.sh && \
  chmod +x /agent/agent-reset.sh && \
  chmod +x /agent/agent-reset-local-login.sh && \
  chmod +x /agent/run

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


CMD ["/agent/run"]

LABEL \
  io.hass.version="VERSION" \
  io.hass.type="addon" \
  io.hass.arch="amd64"
