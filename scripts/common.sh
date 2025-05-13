#!/bin/bash

# Set container runtime (docker or podman)
CONTAINER_RUNTIME=${CONTAINER_RUNTIME:-podman}

# Define available versions
POSTGRES_VERSIONS=("17" "16")
MYSQL_VERSIONS=("9" "8")

# Validate container runtime
validate_container_runtime() {
    if ! command -v "$CONTAINER_RUNTIME" &> /dev/null; then
        echo "Error: $CONTAINER_RUNTIME is not installed or not in PATH"
        exit 1
    fi
}

# Function to check if container is running
is_container_running() {
    local container_name=$1
    "$CONTAINER_RUNTIME" ps -q -f name="$container_name" | grep -q .
    return $?
}

# Function to validate version
validate_version() {
    local db_type=$1
    local version=$2

    if [ "$db_type" = "postgres" ]; then
        for v in "${POSTGRES_VERSIONS[@]}"; do
            if [ "$v" = "$version" ]; then
                return 0
            fi
        done
    elif [ "$db_type" = "mysql" ]; then
        for v in "${MYSQL_VERSIONS[@]}"; do
            if [ "$v" = "$version" ]; then
                return 0
            fi
        done
    fi
    return 1
}

# Function to extract database info from container name
extract_db_info() {
    local container_name=$1
    if [[ $container_name =~ ^(postgres|mysql)_([0-9]+)_test$ ]]; then
        local db_type="${BASH_REMATCH[1]}"
        local version="${BASH_REMATCH[2]}"
        echo "$db_type $version"
        return 0
    fi
    return 1
}

# Function to validate container name
validate_container_name() {
    local container_name=$1
    local db_info
    db_info=$(extract_db_info "$container_name")
    if [ $? -eq 0 ]; then
        local db_type version
        read -r db_type version <<< "$db_info"
        if validate_version "$db_type" "$version"; then
            return 0
        fi
    fi
    return 1
}

# Function to show available versions
show_available_versions() {
    local db_type=$1
    echo "Available versions for $db_type:"
    if [ "$db_type" = "postgres" ]; then
        printf '%s\n' "${POSTGRES_VERSIONS[@]}"
    elif [ "$db_type" = "mysql" ]; then
        printf '%s\n' "${MYSQL_VERSIONS[@]}"
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

# Function to create version-specific directory
create_version_dir() {
    local db_type=$1
    local version=$2
    mkdir -p "results/${db_type}/version_${version}"
}
