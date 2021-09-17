FROM golang:1.16.4

ENV GO111MODULE=on

RUN apt-get update

ENV TZ=Asia/Bangkok

ENV TINI_VERSION v0.19.0
RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

WORKDIR /app

ADD main.go main.go
ADD index.html index.html
ADD go.mod go.mod
ADD go.sum go.sum

RUN go get gopkg.in/olahol/melody.v1

RUN go build main.go

ENTRYPOINT ["/usr/bin/tini","--","/app/main"]
