#!/bin/bash

# Source common functions
source "$(dirname "$0")/common.sh"

# Validate container runtime
validate_container_runtime

# Function to execute PostgreSQL SQL file
run_postgres_sql() {
    local sql_file=$1
    local version=$2
    local container_name="postgres_${version}_test"
    local output_file="results/postgresql/version_${version}/$(basename "$sql_file" .sql)_$(date +%Y%m%d_%H%M%S).log"

    # Create version-specific directory
    create_version_dir "postgresql" "$version"

    echo "Executing PostgreSQL ${version} SQL file: $sql_file using $CONTAINER_RUNTIME"
    echo "Output will be saved to: $output_file"

    if ! is_container_running "$container_name"; then
        echo "Error: Container $container_name is not running"
        exit 1
    fi

    "$CONTAINER_RUNTIME" exec -i "$container_name" psql -U testuser -d testdb < "$sql_file" 2>&1 | tee "$output_file"
}

# Function to execute MySQL SQL file
run_mysql_sql() {
    local sql_file=$1
    local version=$2
    local container_name="mysql_${version}_test"
    local output_file="results/mysql/version_${version}/$(basename "$sql_file" .sql)_$(date +%Y%m%d_%H%M%S).log"

    # Create version-specific directory
    create_version_dir "mysql" "$version"

    echo "Executing MySQL ${version} SQL file: $sql_file using $CONTAINER_RUNTIME"
    echo "Output will be saved to: $output_file"

    if ! is_container_running "$container_name"; then
        echo "Error: Container $container_name is not running"
        exit 1
    fi

    "$CONTAINER_RUNTIME" exec -i "$container_name" mysql -utestuser -ptestpass testdb < "$sql_file" 2>&1 | tee "$output_file"
}

# Function to show help
show_help() {
    echo "Usage: $0 <sql_file> <db_type> <version>"
    echo ""
    echo "Arguments:"
    echo "  sql_file    Path to SQL file to execute"
    echo "  db_type     Database type (postgres or mysql)"
    echo "  version     Database version"
    echo ""
    echo "Available versions:"
    echo "  PostgreSQL: ${POSTGRES_VERSIONS[*]}"
    echo "  MySQL: ${MYSQL_VERSIONS[*]}"
    echo ""
    echo "Examples:"
    echo "  $0 query.sql postgres 17    # Execute SQL on PostgreSQL 17"
    echo "  $0 query.sql mysql 9        # Execute SQL on MySQL 9"
    echo ""
    echo "Note: Set CONTAINER_RUNTIME environment variable to 'docker' or 'podman' (default: podman)"
}

# Check arguments
if [ $# -lt 3 ]; then
    show_help
    exit 1
fi

SQL_FILE=$1
DB_TYPE=$2
VERSION=$3

# Check if file exists
if [ ! -f "$SQL_FILE" ]; then
    echo "Error: File $SQL_FILE does not exist"
    exit 1
fi

# Validate database type and version
if ! validate_version "$DB_TYPE" "$VERSION"; then
    echo "Error: Invalid version '$VERSION' for $DB_TYPE"
    show_available_versions "$DB_TYPE"
    exit 1
fi

# Execute SQL file based on database type
case $DB_TYPE in
    "postgres")
        run_postgres_sql "$SQL_FILE" "$VERSION"
        ;;
    "mysql")
        run_mysql_sql "$SQL_FILE" "$VERSION"
        ;;
    *)
        echo "Error: Invalid database type. Use 'postgres' or 'mysql'"
        exit 1
        ;;
esac
