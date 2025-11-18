FROM alpine:latest

RUN apk add -v build-base
RUN apk add -v go
RUN apk add -v ca-certificates
RUN apk add --no-cache \
    unzip \
    openssh

COPY ./pocketbase-custom /pb
WORKDIR /pb

RUN go mod download

RUN go build
WORKDIR /

EXPOSE 8080

CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
