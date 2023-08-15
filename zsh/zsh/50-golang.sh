append_path "/usr/local/go/bin"
append_path "$HOME/go/bin"

gonew() {
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
    printf "# $projectname\n" >"$basedir/$projectname/README.md"

    printf "FROM golang:1.21\n\nWORKDIR /usr/src/app\n\nCOPY . .\nRUN go build -v -o /usr/local/bin/app ./...\n\nCMD [\"app\"]\n" > "$basedir/$projectname/Dockerfile"

    printf ".PHONY: all install clean\n\n" >"$basedir/$projectname/Makefile"
    printf "all:\n\t@go build -o bin/$projectname cmd/$projectname/main.go\n\n" >>"$basedir/$projectname/Makefile"
    printf "install:\n\t@cp bin/$projectname /usr/local/bin/$projectname\n\n" >>"$basedir/$projectname/Makefile"
    printf "container:\n\t@docker build -t $projectname .\n\n" >>"$basedir/$projectname/Makefile"
    printf "clean:\n\t@rm -f bin/$projectname /usr/local/bin/$projectname\n\n" >>"$basedir/$projectname/Makefile"

    spushd "$basedir/$projectname"
    git init --quiet
    go mod init "github.com/lcrownover/$projectname" 2>/dev/null
    spopd
}
