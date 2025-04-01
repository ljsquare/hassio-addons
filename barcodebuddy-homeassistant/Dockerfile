ARG BUILD_FROM
FROM golang:1.20 AS build_base
LABEL stage=builder

RUN mkdir /compile
  
COPY supervisor/ /compile  

RUN cd /compile && CGO_ENABLED=0 go build -o /compile/supervisor .


FROM $BUILD_FROM
#FROM ghcr.io/hassio-addons/base:15.0.8

RUN apk add ca-certificates curl && mkdir /app && touch /app/.isdocker

RUN \
 mkdir -p \
	/app \
	/config \
	/defaults 

# add local files
COPY root/ /


# install packages
RUN \
 echo "**** installing os packages ****" && \
 apk add --no-cache \
	apache2-utils \
	bash \
	ca-certificates \
	coreutils \
	curl \
	evtest \
	#libressl3.7-libssl \
    libressl \
	nano \
	nginx \
	#openssl \
	php81 \
	php81-curl \
	php81-fileinfo \
	php81-fpm \
	php81-gettext \
	php81-json \
	php81-mbstring \
	php81-openssl \
	php81-pdo \
	php81-pdo_sqlite \
	php81-redis \
	php81-session \
	php81-simplexml \
	php81-sockets \
	php81-sqlite3 \
	php81-xml \
	php81-xmlwriter \
	php81-zlib \
	procps \
	redis \
	screen \
	shadow \
	sudo \
	tzdata && \
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \
 chown redis:redis /etc/redis.conf && \
 useradd -d /config -s /bin/false barcodebuddy && \
 chmod 755 /etc && \
 chown barcodebuddy:barcodebuddy -R /var/log/php81 && \
 ln -s /usr/bin/php81 /usr/bin/php && \
 ln -s /config /data


# set version label
ARG BUILD_DATE
ARG VERSION
ARG BBUDDY_RELEASE
LABEL build_version="BarcodeBuddy HA ${VERSION} Build ${BUILD_DATE}"
LABEL maintainer="LJ"

# Build arguments
ARG BUILD_ARCH
ARG BUILD_REF
ARG BUILD_VERSION



RUN \
 echo "**** Installing BarcodeBuddy ****" && \
 mkdir -p /app/bbuddy && \
 if [ -z ${BBUDDY_RELEASE+x} ]; then \
	BBUDDY_RELEASE=$(curl -sX GET "https://api.github.com/repos/Forceu/barcodebuddy/releases/latest" \
	| awk '/tag_name/{print $4; exit}' FS='[""]'); \
 fi && \
 curl -o \
	/tmp/bbuddy.tar.gz -L \
	"https://github.com/Forceu/barcodebuddy/archive/${BBUDDY_RELEASE}.tar.gz" && \
 tar xf \
	/tmp/bbuddy.tar.gz -C \
	/app/bbuddy/ --strip-components=1 && \
   sed -i 's/[[:blank:]]*const[[:blank:]]*IS_DOCKER[[:blank:]]*=[[:blank:]]*false;/const IS_DOCKER = true;/g' /app/bbuddy/config-dist.php && \
 echo "Set disable_coredump false" > /etc/sudo.conf && \
sed -i 's/SCRIPT_LOCATION=.*/SCRIPT_LOCATION="\/app\/bbuddy\/index.php"/g' /app/bbuddy/example/grabInput.sh && \
 sed -i 's/pm.max_children = 5/pm.max_children = 20/g' /etc/php81/php-fpm.d/www.conf && \
sed -i 's/WWW_USER=.*/WWW_USER="barcodebuddy"/g' /app/bbuddy/example/grabInput.sh && \
sed -i 's/IS_DOCKER=.*/IS_DOCKER=true/g' /app/bbuddy/example/grabInput.sh && \
sed -i 's/const DEFAULT_USE_REDIS =.*/const DEFAULT_USE_REDIS = "1";/g' /app/bbuddy/incl/db.inc.php && \
 rm -rf \
	/root/.cache \
	/tmp/*


COPY --from=build_base /compile/supervisor /app/supervisor

EXPOSE 80 443
VOLUME /config
# Labels
LABEL \
    io.hass.name="Barcode Buddy for Grocy" \
    io.hass.description="Barcode system for Grocy" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} 

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
