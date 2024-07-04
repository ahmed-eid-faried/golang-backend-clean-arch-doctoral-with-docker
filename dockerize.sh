#!/bin/bash

# chmod +x cmd/api/main.go
# chmod +x dockerize.sh
# ./dockerize.sh

# Function to check if a port is in use and stop the process using it
stop_process_on_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null; then
        local pid=$(lsof -Pi :$port -sTCP:LISTEN -t)
        echo "Port $port is in use by process $pid. Stopping process $pid..."
        kill -9 $pid
        echo "Process $pid stopped."
    else
        echo "Port $port is available."
    fi
}

# Check and stop processes using specific ports
stop_processes_on_ports() {
    stop_process_on_port 8888
    stop_process_on_port 5432
    stop_process_on_port 27017
    stop_process_on_port 6379
}

# Docker Compose up with build and port checks
docker_compose_up() {
    # Stop existing containers if running
    docker-compose down

    # Build and start containers
    docker-compose up --build -d

    # Display running containers
    docker-compose ps

    # Optional: Run additional commands like database migrations or tests here
    # Example:
    # docker-compose exec app go run migrations.go
}

# Main function to dockerize and run the project
main() {
    stop_processes_on_ports
    docker_compose_up
    echo "Docker containers are up and running."
}

go mod tidy
swag init -g cmd/api/main.go
# Call the main function
main
