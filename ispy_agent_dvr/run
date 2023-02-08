#!/usr/bin/with-contenv bashio

Folder="$(bashio::config 'folder')"

cd /agent

if ! bashio::fs.directory_exists "/data/Media";
then
  mkdir /data/Media
fi

if ! bashio::fs.directory_exists "/data/Commands";
then
  mkdir /data/Commands
fi

ln -s /data/Media Media
ln -s /data/Commands Commands

if (bashio::config.true 'override');
then
  if ! bashio::fs.directory_exists "/share/${Folder}";
  then
    mkdir /share/${Folder}
  fi
  ln -s /share/${Folder} Media/WebServerRoot/Media
fi

./Agent
