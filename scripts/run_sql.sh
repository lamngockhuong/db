#!/bin/bash

# Set container runtime (docker or podman)
CONTAINER_RUNTIME=${CONTAINER_RUNTIME:-podman}

# Validate container runtime
if ! command -v "$CONTAINER_RUNTIME" &> /dev/null; then
    echo "Error: $CONTAINER_RUNTIME is not installed or not in PATH"
    exit 1
fi

# Function to execute PostgreSQL SQL file
run_postgres_sql() {
    local sql_file=$1
    local output_file="results/postgresql/$(basename "$sql_file" .sql)_$(date +%Y%m%d_%H%M%S).log"
    echo "Executing PostgreSQL SQL file: $sql_file using $CONTAINER_RUNTIME"
    echo "Output will be saved to: $output_file"
    "$CONTAINER_RUNTIME" exec -i postgres_17_test psql -U testuser -d testdb < "$sql_file" 2>&1 | tee "$output_file"
}

# Function to execute MySQL SQL file
run_mysql_sql() {
    local sql_file=$1
    local output_file="results/mysql/$(basename "$sql_file" .sql)_$(date +%Y%m%d_%H%M%S).log"
    echo "Executing MySQL SQL file: $sql_file using $CONTAINER_RUNTIME"
    echo "Output will be saved to: $output_file"
    "$CONTAINER_RUNTIME" exec -i mysql_9_test mysql -utestuser -ptestpass testdb < "$sql_file" 2>&1 | tee "$output_file"
}

# Check if file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <sql_file> [db_type]"
    echo "db_type: postgres or mysql (default: postgres)"
    echo "Note: Set CONTAINER_RUNTIME environment variable to 'docker' or 'podman' (default: docker)"
    exit 1
fi

SQL_FILE=$1
DB_TYPE=${2:-postgres}

# Check if file exists
if [ ! -f "$SQL_FILE" ]; then
    echo "Error: File $SQL_FILE does not exist"
    exit 1
fi

# Create results directory structure
mkdir -p results/postgresql
mkdir -p results/mysql

# Execute SQL file based on database type
case $DB_TYPE in
    "postgres")
        run_postgres_sql "$SQL_FILE"
        ;;
    "mysql")
        run_mysql_sql "$SQL_FILE"
        ;;
    *)
        echo "Error: Invalid database type. Use 'postgres' or 'mysql'"
        exit 1
        ;;
esac
