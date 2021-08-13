#!/bin/bash

pushd . >/dev/null 2>&1

cd ~

# puppet
# https://github.com/puppetlabs/puppet-editor-services

npm i pyright
npm i bash-ls
npm i ts-server
gem install solargraph

popd >/dev/null 2>&1
