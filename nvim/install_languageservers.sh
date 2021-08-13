#!/bin/bash

pushd . >/dev/null 2>&1

cd ~

# puppet
# https://github.com/puppetlabs/puppet-editor-services

npm i -g pyright
npm i -g bash-ls
npm i -g ts-server
gem install solargraph

popd >/dev/null 2>&1
