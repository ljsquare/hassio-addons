#!/usr/bin/bashio
set +u

export DB_HOST=$(bashio::services "mysql" "host")
export APP_KEY=$(bashio::config 'APP_KEY')
export DB_CONNECTION="mysql"
export DB_PORT=$(bashio::services "mysql" "port")
export DB_USERNAME=$(bashio::services "mysql" "username")
export DB_PASSWORD=$(bashio::services "mysql" "password")
export DKR_RUN_PASSPORT_INSTALL=false

export DB_DATABASE="firefly"
mysql -u "${DB_USERNAME}" -p"${DB_PASSWORD}" -h "${DB_HOST}" -P "${DB_PORT}" --execute="CREATE DATABASE IF NOT EXISTS firefly"


source /usr/local/bin/entrypoint.sh