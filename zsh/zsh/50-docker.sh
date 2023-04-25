dev_rust() {
    PROJECT_NAME="$(basename $PWD)"
    docker build . -t $PROJECT_NAME
    docker run -it -w /app -v $(pwd):/app $PROJECT_NAME bash
}
