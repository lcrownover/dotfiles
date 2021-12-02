function go_new_project() {
    mkdir -p "$1/cmd/$1"
    mkdir -p "$1/bin"
    printf 'package main\n\nimport (\n    "fmt"\n)\n\nfunc main() {\n    fmt.Println("hello world")\n}\n' > "$1/cmd/$1/main.go"
    cd "$1"
    go mod init "github.com/lcrownover/$1" 2> /dev/null
}
alias gonew='go_new_project'
append_path "$HOME/go/bin"
