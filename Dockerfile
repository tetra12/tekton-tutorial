FROM golang:1.21-alpine AS build
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app -ldflags="-s -w"

FROM scratch
COPY --from=build /go/app /bin/
EXPOSE 8080
CMD ["app"]
