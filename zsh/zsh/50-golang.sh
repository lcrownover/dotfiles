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

    printf 'package main\n\nimport (\n\t"fmt"\n)\n\nfunc main() {\n\tfmt.Println("hello world")\n}\n' > "$basedir/$projectname/cmd/$projectname/main.go"
    printf "# $projectname\n" > "$basedir/$projectname/README.md"

    spushd "$basedir/$projectname"
    git init --quiet
    go mod init "github.com/lcrownover/$projectname" 2> /dev/null
    spopd
}
