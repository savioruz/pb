FROM golang:1.25-alpine AS builder

WORKDIR /app

RUN apk add --no-cache build-base ca-certificates

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=1 go build -o pocketbase

FROM alpine:latest

RUN apk add --no-cache ca-certificates unzip openssh

WORKDIR /pb

COPY --from=builder /app/pocketbase .

EXPOSE 8080

CMD ["./pocketbase", "serve", "--http=0.0.0.0:8080"]
