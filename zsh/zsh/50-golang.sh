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

    printf 'package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tfmt.Println("hello world")\n}\n' > "$basedir/$projectname/cmd/$projectname/main.go"
    printf "# $projectname\n" > "$basedir/$projectname/README.md"

    spushd "$basedir/$projectname"
    git init --quiet
    go mod init "github.com/lcrownover/$projectname" 2> /dev/null
    spopd
}

gobae() {
    bin="$(basename $(pwd))"
    GOOS=linux GOARCH=amd64 go build -o bin/$bin cmd/$bin/main.go
    docker_file=$(mktemp)
    printf "FROM golang:1.9.0\nCOPY bin/$bin /go/bin/$bin\n" > $docker_file
    docker build -f $docker_file -t $bin .
    rm $docker_file
    docker run $bin $bin $@
}
