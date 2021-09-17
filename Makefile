all: build push run

build:
	go build main.go

push:
	 docker build -t pepsi7959/websocket . && docker push pepsi7959/websocket 

run: 
	go run main.go
