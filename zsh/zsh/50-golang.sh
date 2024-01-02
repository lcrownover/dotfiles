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

	mkdir -p "$projectdir/cmd/$projectname/"
	mkdir "$projectdir/bin"

	cat <<EOF >"$projectdir/cmd/$projectname/main.go"
package main

import (
    "fmt"
)

func main() {
    fmt.Println("hello world")
}
EOF
	printf "# %s\n" "$projectname" >"$projectdir/README.md"

	cat <<EOF >"$projectdir/Dockerfile"
FROM golang:1.21

WORKDIR /usr/src/app

COPY . .
RUN go build -v -o /usr/local/bin/app cmd/$projectname/main.go

CMD ["app"]
EOF

	cat <<EOF >"$projectdir/.gitignore"
bin/
env.sh
EOF

	cat <<EOF >"$projectdir/Makefile"
.PHONY: build install clean run container handler
all: build

build:
    @go build -o bin/$projectname cmd/$projectname/main.go

run: build
    @go run cmd/$projectname/main.go

install: build
    @cp bin/$projectname /usr/local/bin/$projectname

container:
    @docker build -t $projectname .

handler:
    @go build -o handler cmd/$projectname/main.go

clean:
    @rm -f bin/$projectname /usr/local/bin/$projectname
EOF

	spushd "$projectdir"
	git init --quiet
	go mod init "github.com/lcrownover/$projectname" 2>/dev/null
	go mod tidy 2>/dev/null
	# spopd
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
