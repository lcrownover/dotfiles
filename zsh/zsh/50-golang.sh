append_path "/usr/local/go/bin"
append_path "$HOME/go/bin"

gonew() {
	if [[ $# -lt 1 ]]; then
		echo "usage: gonew PROJECT_NAME [basedir]"
		return
	fi

	projectname="$1"
	shift

	projectdir="$(pwd)/$projectname"
	if [[ "$1" != "" ]]; then
		projectdir="$1"
		shift
	fi

	mkdir -p "$projectdir/cmd/$projectname/"
	mkdir "$projectdir/bin"

	printf 'package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tfmt.Println("hello world")\n}\n' >"$projectdir/cmd/$projectname/main.go"
	printf "# %s\n" "$projectname" >"$projectdir/README.md"

	printf "FROM golang:1.21\n\nWORKDIR /usr/src/app\n\nCOPY . .\nRUN go build -v -o /usr/local/bin/app ./...\n\nCMD [\"app\"]\n" >"$projectdir/Dockerfile"

	printf "bin/\n" >"$projectdir/.gitignore"

	printf ".PHONY: all install clean run container handler\n\n" >"$projectdir/Makefile"
	printf "all:\n\t@go build -o bin/%s cmd/%s/main.go\n\n" "$projectname" "$projectname" >>"$projectdir/Makefile"
	printf "run:\n\t@go run cmd/%s/main.go\n\n" "$projectname" >>"$projectdir/Makefile"
	printf "install:\n\t@cp bin/%s /usr/local/bin/%s\n\n" "$projectname" "$projectname" >>"$projectdir/Makefile"
	printf "container:\n\t@docker build -t %s .\n\n" "$projectname" >>"$projectdir/Makefile"
	printf "handler:\n\t@go build -o handler cmd/%s/main.go\n\n" "$projectname" >>"$projectdir/Makefile"
	printf "clean:\n\t@rm -f bin/%s /usr/local/bin/%s\n\n" "$projectname" "$projectname" >>"$projectdir/Makefile"

	spushd "$projectdir"
	git init --quiet
	go mod init "github.com/lcrownover/$projectname" 2>/dev/null
	go mod tidy 2>/dev/null
	spopd
}
