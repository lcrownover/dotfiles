append_path "/usr/local/go/bin"
append_path "$HOME/go/bin"

function gonew() {
	if [[ $# -lt 1 ]]; then
		echo "usage: gonew PROJECT_NAME [basedir]"
		return
	fi

	projectname="$1"
	shift

	basedir="$(pwd)"
	if [[ "$1" != "" ]]; then
		basedir="$1"
		shift
	fi

	mkdir -p "$basedir/$projectname/cmd/$projectname/"
	mkdir "$basedir/$projectname/bin"

	printf 'package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tfmt.Println("hello world")\n}\n' >"$basedir/$projectname/cmd/$projectname/main.go"
	printf "# %s\n" "$projectname" >"$basedir/$projectname/README.md"

	printf "FROM golang:1.21\n\nWORKDIR /usr/src/app\n\nCOPY . .\nRUN go build -v -o /usr/local/bin/app ./...\n\nCMD [\"app\"]\n" >"$basedir/$projectname/Dockerfile"

	printf "bin/\n" >"$basedir/$projectname/.gitignore"

	printf ".PHONY: all install clean run container handler\n\n" >"$basedir/$projectname/Makefile"
	printf "all:\n\t@go build -o bin/%s cmd/%s/main.go\n\n" "$projectname" "$projectname" >>"$basedir/$projectname/Makefile"
	printf "run:\n\t@go run cmd/%s/main.go\n\n" "$projectname" >>"$basedir/$projectname/Makefile"
	printf "install:\n\t@cp bin/%s /usr/local/bin/%s\n\n" "$projectname" "$projectname" >>"$basedir/$projectname/Makefile"
	printf "container:\n\t@docker build -t %s .\n\n" "$projectname" >>"$basedir/$projectname/Makefile"
	printf "handler:\n\t@go build -o handler cmd/%s/main.go\n\n" "$projectname" >>"$basedir/$projectname/Makefile"
	printf "clean:\n\t@rm -f bin/%s /usr/local/bin/%s\n\n" "$projectname" "$projectname" >>"$basedir/$projectname/Makefile"

	spushd "$basedir/$projectname"
	git init --quiet
	go mod init "github.com/lcrownover/$projectname" 2>/dev/null
	go mod tidy 2>/dev/null
	spopd
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
