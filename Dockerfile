# Dockerfile

FROM golang:latest

WORKDIR /app
COPY . .
RUN go mod download

COPY ./pkg/config/config.sample.yaml ./pkg/config/config.yaml
RUN go build -o /app/golang-backend-clean-arch-doctoral-with-docker ./cmd/api

EXPOSE 8888
ENTRYPOINT ["/app/golang-backend-clean-arch-doctoral-with-docker"]