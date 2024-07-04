# Dockerfile
FROM golang:latest

# Set necessary environment variables needed for your app
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Set the working directory inside the container
WORKDIR /app

# Copy the entire source code into the container
COPY . .

# Download necessary Go modules
RUN go mod download

# Build the Go app
RUN go build -o main .

# Command to run the executable
CMD ["./main"]
