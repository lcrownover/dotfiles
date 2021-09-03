# Neovim - lcrownover

Other than linking the directories, here's the setup for macOS.


## Prerequisites

My primary location for repositories

`mkdir -p $HOME/repos`

rbenv - ruby environments

```bash
brew install rbenv
rbenv install 2.7.2
rbenv global 2.7.2
gem install bundler
gem install neovim
```

pyenv - python environments

```bash
brew install pyenv
pyenv install 3.9.7
pyenv global 3.9.7
```


## Languages

### efm

efm is a general-purpose language server, used for formatting.

```bash
brew install efm-langserver
luarocks install --server=https://luarocks.org/dev luaformatter
```

### lua

Clone the language server

```bash
brew install ninja
cd ~/repos
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
```

Build the language server

```bash
cd 3rd/luamake
ninja -f compile/ninja/macos.ninja
cd ../..
./3rd/luamake/luamake rebuild
```

### vim

```bash
npm i -g vim-language-server
```

### python

```bash
npm i -g pyright
```

### bash

```bash
npm i -g bash-language-server
```

### typescript

```bash
npm i -g ts-server
```

### ruby

```bash
gem install solargraph
```

### puppet

```bash
cd ~/repos
git clone https://github.com/puppetlabs/puppet-editor-services.git
cd puppet-editor-services
gem install puppet-lint
gem install solargraph
bundle install
```

### go

```bash
brew install golang
```

