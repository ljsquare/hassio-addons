#!/usr/bin/bashio
set +u

export DB_HOST=$(bashio::services "mysql" "host")
export APP_KEY=$(bashio::config 'APP_KEY')
export DB_CONNECTION="mysql"
export DB_PORT=$(bashio::services "mysql" "port")
export DB_USERNAME=$(bashio::services "mysql" "username")
export DB_PASSWORD=$(bashio::services "mysql" "password")
export DEFAULT_LANGUAGE=$(bashio::config 'DEFAULT_LANGUAGE')
export DKR_RUN_PASSPORT_INSTALL=false
export MAIL_MAILER=log
export MAIL_FROM=noreply@example.com


export DB_DATABASE="firefly"
mysql -u "${DB_USERNAME}" -p"${DB_PASSWORD}" -h "${DB_HOST}" -P "${DB_PORT}" --execute="CREATE DATABASE IF NOT EXISTS firefly"
if ! bashio::fs.directory_exists "/share/firefly_upload";
  then
    mkdir /share/firefly_upload
  fi
  if ! bashio::fs.directory_exists "/var/www/html/storage/upload";
  then
    mkdir -p /var/www/html/storage/upload
  fi

  ln -sf /share/firefly_upload /var/www/html/storage/upload

source /usr/local/bin/entrypoint.sh