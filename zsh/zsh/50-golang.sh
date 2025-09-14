#!/usr/bin/env bash

append_path "/usr/local/go/bin"
append_path "$HOME/go/bin"

function gonew() {
	function usage() {
		echo "usage: gonew NAME [basedir]"
	}
	if [[ $# -lt 1 ]]; then
		usage
		return
	fi

	projectname="$1"
	shift

	projectdir="$(pwd)/$projectname"
	if [[ "$1" != "" ]]; then
		projectdir="$1"
		shift
	fi

	mkdir -p "$projectdir/bin"

	spushd "$projectdir"

	git init --quiet
	go mod init "github.com/lcrownover/$projectname" 2>/dev/null

	cat <<EOF >"main.go"
package main

import (
    "fmt"
)

func main() {
    fmt.Println("hello world")
}
EOF
	test -f "README.md" || printf "# %s\n" "$projectname" >"README.md"

	cat <<EOF >"$projectdir/Dockerfile"
FROM golang:1.24

WORKDIR /usr/src/app

COPY . .
RUN go build -v -o /usr/local/bin/app main.go

CMD ["app"]
EOF

	test -f ".gitignore" || cat <<EOF >".gitignore"
bin/

*.exe
*.exe~
*.dll
*.so
*.dylib

# Test binary, built with `go test -c`
*.test

# Output of the go coverage tool, specifically when used with LiteIDE
*.out

# Dependency directories (remove the comment below to include it)
# vendor/

# Go workspace file
go.work
go.work.sum

# env file
.env
EOF

	cat <<EOF >"Makefile"
.PHONY: build install clean run container
all: build

build:
	@go build -o bin/$projectname main.go

run: build
	@go run main.go

install: build
	@cp bin/$projectname /usr/local/bin/$projectname

container:
	@docker build -t $projectname .

clean:
	@rm -f bin/$projectname /usr/local/bin/$projectname
EOF

	go mod tidy 2>/dev/null
}

function goupdate() {
	usage() {
		echo "usage: goupdate <linux|mac> <version>"
		return
	}
	if [[ $# -lt 2 ]]; then
		echo "not enough arguments"
		usage
		return
	fi

	case "$1" in
	linux)
		platform="linux-amd64"
		;;
	mac)
		platform="darwin-arm64"
		;;
	*)
		echo "invalid platform"
		usage
		return
		;;
	esac
	shift

	version="$1"
	shift

	tarball="go$version.$platform.tar.gz"

	wget -q https://go.dev/dl/$tarball || return
	echo "updating go to $version"
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf $tarball
	rm -rf $tarball
}
