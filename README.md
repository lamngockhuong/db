# Database Management Scripts

This repository contains scripts for managing PostgreSQL and MySQL databases using Docker/Podman containers.

## Prerequisites

- Docker or Podman installed
- Docker Compose or Podman Compose installed

## Container Runtime

The scripts support both Docker and Podman. By default, Podman is used. You can change this by setting the `CONTAINER_RUNTIME` environment variable:

```bash
# Use Docker
export CONTAINER_RUNTIME=docker

# Use Podman (default)
export CONTAINER_RUNTIME=podman
```

## Available Scripts

### 1. Container Management (`scripts/run_containers.sh`)

This script helps you manage your database containers.

#### Usage

```bash
./scripts/run_containers.sh [command] [container_name]
```

#### Commands

- `start [container_name]`: Start all containers or a specific container

  ```bash
  # Start all containers
  ./scripts/run_containers.sh start

  # Start specific container
  ./scripts/run_containers.sh start postgres_17_test
  ./scripts/run_containers.sh start mysql_9_test
  ```

- `stop [container_name]`: Stop all containers or a specific container

  ```bash
  # Stop all containers
  ./scripts/run_containers.sh stop

  # Stop specific container
  ./scripts/run_containers.sh stop postgres_17_test
  ./scripts/run_containers.sh stop mysql_9_test
  ```

- `status`: Show container status

  ```bash
  ./scripts/run_containers.sh status
  ```

- `logs [container_name]`: Show container logs

  ```bash
  ./scripts/run_containers.sh logs postgres_17_test
  ./scripts/run_containers.sh logs mysql_9_test
  ```

- `list`: List available containers

  ```bash
  ./scripts/run_containers.sh list
  ```

- `help`: Show help message
  ```bash
  ./scripts/run_containers.sh help
  ```

### 2. SQL Execution (`scripts/run_sql.sh`)

This script helps you execute SQL files in your database containers.

#### Usage

```bash
./scripts/run_sql.sh <sql_file> [db_type]
```

#### Parameters

- `sql_file`: Path to your SQL file
- `db_type`: Database type (postgres or mysql, default: postgres)

#### Examples

```bash
# Execute SQL file in PostgreSQL
./scripts/run_sql.sh your_query.sql

# Execute SQL file in MySQL
./scripts/run_sql.sh your_query.sql mysql
```

#### Output

SQL execution results will be saved in the `results` directory:

- PostgreSQL results: `results/postgresql/`
- MySQL results: `results/mysql/`

## Container Information

### PostgreSQL Container

- Container name: `postgres_17_test`
- Port: 5432
- Credentials:
  - Username: testuser
  - Password: testpass
  - Database: testdb

### MySQL Container

- Container name: `mysql_9_test`
- Port: 3306
- Credentials:
  - Username: testuser
  - Password: testpass
  - Database: testdb

## Directory Structure

```
.
├── docker-compose.yml
├── README.md
├── results/
│   ├── postgresql/
│   └── mysql/
├── scripts/
│   ├── run_containers.sh
│   └── run_sql.sh
└── tests/
    ├── mysql/
    └── postgresql/
```
