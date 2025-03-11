#!/usr/bin/env zsh

append_path "/usr/local/go/bin"
append_path "$HOME/go/bin"

function gonew() {
	function usage() {
		echo "usage: gonew PROJECT_NAME [basedir]"
		return
	}
	if [[ $# -lt 1 ]]; then
		usage
	fi

	projectname="$1"
	binname="$(echo $projectname | cut -d'-' -f1)"
	if [[ "$projectname" = "." ]]; then
		usage
		return
	fi
	shift

	projectdir="$(pwd)/$projectname"
	if [[ "$1" != "" ]]; then
		projectdir="$1"
		shift
	fi

	mkdir -p "$projectdir/cmd/$binname/"
	mkdir "$projectdir/bin"

	cat <<EOF >"$projectdir/cmd/$binname/main.go"
package main

import (
    "fmt"
)

func main() {
    fmt.Println("hello world")
}
EOF
	test -f "$projectdir/README.md" || printf "# %s\n" "$projectname" >"$projectdir/README.md"

	cat <<EOF >"$projectdir/Dockerfile"
FROM golang:1.21

WORKDIR /usr/src/app

COPY . .
RUN go build -v -o /usr/local/bin/app cmd/$binname/main.go

CMD ["app"]
EOF

	test -f "$projectdir/.gitignore" || cat <<EOF >"$projectdir/.gitignore"
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

	cat <<EOF >"$projectdir/Makefile"
.PHONY: build install clean run container handler
all: build

build:
	@go build -o bin/$binname cmd/$binname/main.go

run: build
	@go run cmd/$binname/main.go

install: build
	@cp bin/$binname /usr/local/bin/$binname

container:
	@docker build -t $binname .

handler:
	@go build -o handler cmd/$binname/main.go

clean:
	@rm -f bin/$binname /usr/local/bin/$binname
EOF

	spushd "$projectdir"
	git init --quiet
	go mod init "github.com/lcrownover/$projectname" 2>/dev/null && \
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
