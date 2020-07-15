FROM golang:1.13 as goimage
ENV SRC=/go/src/
ENV GO111MODULE=on
RUN mkdir -p /go/src/
WORKDIR /go/src/github.com/hillfolk/go-rest-api-template
RUN git clone -b develop --single-branch https://github.com/hillfolk/go-rest-api-template.git /go/src/github.com/hillfolk/go-rest-api-template && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -ldflags "-X main.Version=`git describe --tags` -X main.Commit=`git rev-parse --short HEAD`" -o bin/go-rest-api-template

FROM alpine:3.9 as baseimagealp
ENV WORK_DIR=/docker/bin

WORKDIR $WORK_DIR

COPY --from=goimage /go/src/github.com/hillfolk/go-rest-api-template/bin/ ./

ENTRYPOINT /docker/bin/go-rest-api-template
EXPOSE 1323