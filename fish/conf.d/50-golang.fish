fish_add_path /usr/local/go/bin
fish_add_path $HOME/go/bin

function gonew
    if test (count $argv) -lt 1
        echo "usage: gonew NAME [basedir]"
        return
    end

    set projectname $argv[1]
    set argv $argv[2..]

    set projectdir (pwd)/$projectname
    if test (count $argv) -ge 1 -a -n "$argv[1]"
        set projectdir $argv[1]
        set argv $argv[2..]
    end

    mkdir -p "$projectdir/bin"
    spushd "$projectdir"

    git init --quiet
    go mod init "github.com/lcrownover/$projectname" 2>/dev/null

    begin
        printf 'package main\n\n'
        printf 'import (\n'
        printf '\t"fmt"\n'
        printf ')\n\n'
        printf 'func main() {\n'
        printf '\tfmt.Println("hello world")\n'
        printf '}\n'
    end > main.go

    test -f README.md; or printf "# %s\n" $projectname > README.md

    begin
        printf 'FROM golang:1.24\n\n'
        printf 'WORKDIR /usr/src/app\n\n'
        printf 'COPY . .\n'
        printf 'RUN go build -v -o /usr/local/bin/app main.go\n\n'
        printf 'CMD ["app"]\n'
    end > "$projectdir/Dockerfile"

    if not test -f .gitignore
        begin
            printf 'bin/\n\n'
            printf '*.exe\n*.exe~\n*.dll\n*.so\n*.dylib\n\n'
            printf '# Test binary, built with `go test -c`\n'
            printf '*.test\n\n'
            printf '# Output of the go coverage tool, specifically when used with LiteIDE\n'
            printf '*.out\n\n'
            printf '# Dependency directories (remove the comment below to include it)\n'
            printf '# vendor/\n\n'
            printf '# Go workspace file\n'
            printf 'go.work\ngo.work.sum\n\n'
            printf '# env file\n'
            printf '.env\n'
        end > .gitignore
    end

    begin
        printf '.PHONY: build install clean run container\n'
        printf 'all: build\n\n'
        printf 'build:\n\t@go build -o bin/%s main.go\n\n' $projectname
        printf 'run: build\n\t@go run main.go\n\n'
        printf 'install: build\n\t@cp bin/%s /usr/local/bin/%s\n\n' $projectname $projectname
        printf 'container:\n\t@docker build -t %s .\n\n' $projectname
        printf 'clean:\n\t@rm -f bin/%s /usr/local/bin/%s\n' $projectname $projectname
    end > Makefile

    go mod tidy 2>/dev/null
end

function goupdate
    if test (count $argv) -lt 1
        echo "not enough arguments"
        echo "usage: goupdate <version>"
        return
    end

    switch (uname)
        case Linux
            set platform linux-amd64
        case Darwin
            set platform darwin-arm64
        case '*'
            echo "invalid platform"
            return
    end

    set goversion $argv[1]
    set tarball "go$goversion.$platform.tar.gz"
    set tarfile "/tmp/$tarball"

    wget -O $tarfile -q https://go.dev/dl/$tarball; or return
    echo "updating go to $goversion"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf $tarfile
    rm -rf $tarfile
end
