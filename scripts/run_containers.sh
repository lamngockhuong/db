#!/bin/bash

# Source common functions
source "$(dirname "$0")/common.sh"

# Validate container runtime
validate_container_runtime

# Function to start containers
start_containers() {
    local container_name=$1
    if [ -z "$container_name" ]; then
        echo "Starting all containers using $CONTAINER_RUNTIME..."
        "$CONTAINER_RUNTIME" compose up -d
    else
        if validate_container_name "$container_name"; then
            echo "Starting container $container_name using $CONTAINER_RUNTIME..."
            "$CONTAINER_RUNTIME" compose up -d "$container_name"
        else
            echo "Error: Invalid container name format. Use format: <db_type>_<version>_test"
            echo "Example: postgres_17_test or mysql_9_test"
            exit 1
        fi
    fi
}

# Function to stop containers
stop_containers() {
    local container_name=$1
    if [ -z "$container_name" ]; then
        echo "Stopping all containers..."
        "$CONTAINER_RUNTIME" compose down
    else
        echo "Stopping container $container_name..."
        "$CONTAINER_RUNTIME" compose stop "$container_name"
    fi
}

# Function to show container status
show_status() {
    echo "Container Status:"
    echo "----------------"
    "$CONTAINER_RUNTIME" compose ps
}

# Function to show container logs
show_logs() {
    local container_name=$1
    if [ -z "$container_name" ]; then
        echo "Available containers:"
        list_containers
        read -p "Enter container name to view logs: " container_name
    fi

    if validate_container_name "$container_name"; then
        if is_container_running "$container_name"; then
            echo "Showing logs for $container_name:"
            "$CONTAINER_RUNTIME" logs -f "$container_name"
        else
            echo "Error: Container $container_name is not running"
        fi
    else
        echo "Error: Invalid container name format. Use format: <db_type>_<version>_test"
        echo "Example: postgres_17_test or mysql_9_test"
        exit 1
    fi
}

# Function to list available containers
list_containers() {
    echo "Available PostgreSQL versions:"
    for version in "${POSTGRES_VERSIONS[@]}"; do
        echo "postgres_${version}_test"
    done

    echo -e "\nAvailable MySQL versions:"
    for version in "${MYSQL_VERSIONS[@]}"; do
        echo "mysql_${version}_test"
    done
}

# Function to show help
show_help() {
    echo "Usage: $0 [command] [container_name]"
    echo ""
    echo "Commands:"
    echo "  start   - Start all containers or a specific container"
    echo "  stop    - Stop all containers or a specific container"
    echo "  status  - Show container status"
    echo "  logs    - Show container logs"
    echo "  list    - List available containers"
    echo "  help    - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 start                   # Start all containers"
    echo "  $0 start postgres_17_test  # Start PostgreSQL 17 container"
    echo "  $0 start mysql_9_test      # Start MySQL 9 container"
    echo "  $0 stop mysql_8_test       # Stop MySQL 8 container"
    echo ""
    echo "Note: Set CONTAINER_RUNTIME environment variable to 'docker' or 'podman' (default: podman)"
}

# Main script logic
case "$1" in
    "start")
        start_containers "$2"
        ;;
    "stop")
        stop_containers "$2"
        ;;
    "status")
        show_status
        ;;
    "logs")
        show_logs "$2"
        ;;
    "list")
        list_containers
        ;;
    "help"|"")
        show_help
        ;;
    *)
        echo "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac
