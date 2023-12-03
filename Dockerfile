FROM golang:1.21-alpine AS builder

ARG PROJ github.com/tetra12/tekton-tutorial
WORKDIR /go/src/${PROJ}

COPY go.mod .
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app -ldflags="-s -w"

FROM scratch
COPY --from=builder /go/src/${PROJ}/app .
EXPOSE 8080
CMD ["./app"]
