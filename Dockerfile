# # Dockerfile

# # Use the official golang image from Docker Hub
# FROM golang:latest

# # Set necessary environment variables needed for your app
# ENV GO111MODULE=on \
#     CGO_ENABLED=0 \
#     GOOS=linux \
#     GOARCH=amd64

# # Set the working directory inside the container
# WORKDIR /app

# # Copy just the go.mod and go.sum files to the working directory
# COPY go.mod go.sum ./

# # Download necessary Go modules
# COPY . .
# RUN go mod download

# # Copy the entire source code into the container
# COPY ./pkg/config/config.sample.yaml ./pkg/config/config.yaml

# # Build the Go app located in cmd/api directory
# RUN go build -o /app/golang-backend-clean-arch-doctoral-with-docker ./cmd/api

# # Expose port 8888 to the outside world (if your app listens on this port)
# EXPOSE 8888

# # Command to run the executable
# ENTRYPOINT ["/app/golang-backend-clean-arch-doctoral-with-docker"]


FROM golang:latest

WORKDIR /app
COPY . .
RUN go mod download

COPY ./pkg/config/config.sample.yaml ./pkg/config/config.yaml
RUN go build -o /app/golang-backend-clean-arch-doctoral-with-docker ./cmd/api

EXPOSE 8888
ENTRYPOINT ["/app/golang-backend-clean-arch-doctoral-with-docker"]