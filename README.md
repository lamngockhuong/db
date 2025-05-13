# Database Testing Repository

This repository contains test cases and scenarios for PostgreSQL and MySQL databases. It's designed to help developers test various database features, behaviors, and edge cases across different versions.

## Supported Database Versions

### PostgreSQL

- 17 (Port: 5417)
- 16 (Port: 5416)

### MySQL

- 9 (Port: 3390)
- 8 (Port: 3380)

## Repository Structure

```
.
├── tests/                    # Test cases directory
│   ├── postgresql/          # PostgreSQL test cases
│   │   └── length_test/     # Tests for string length functions
│   └── mysql/              # MySQL test cases
│       └── length_test/     # Tests for string length functions
├── scripts/                 # Utility scripts
│   ├── run_containers.sh   # Container management script
│   ├── run_sql.sh         # SQL execution script
│   └── common.sh          # Common functions for scripts
├── results/                # Test results and logs
├── docker-compose.yml      # Container configuration
├── .gitignore             # Git ignore rules
├── .cursorignore          # Cursor IDE ignore rules
└── LICENSE                # MIT License file
```

## Database Configuration

### PostgreSQL

- Default user: testuser
- Default password: testpass
- Default database: testdb
- Data persistence: Yes (Docker volumes)

### MySQL

- Root password: rootpass
- Default user: testuser
- Default password: testpass
- Default database: testdb
- Data persistence: Yes (Docker volumes)

## Test Categories

1. **Basic Operations**

   - CRUD operations
   - Data types and constraints
   - Indexes and performance
   - Basic SQL queries and joins

2. **Advanced Features**

   - Transactions and ACID properties
   - Concurrency and locking
   - Partitioning and sharding
   - Stored procedures and functions
   - Triggers and events

3. **Edge Cases**
   - Error handling and recovery
   - Boundary conditions
   - Performance under load
   - Data integrity scenarios
   - Version-specific features

## Getting Started

### Prerequisites

- Docker or Podman installed
- Docker Compose or Podman Compose
- Basic knowledge of SQL and database concepts

### Running Tests

1. Start the required database container:

   ```bash
   # Using Docker (default)
   ./scripts/run_containers.sh start postgres_17_test  # For PostgreSQL 17
   # or
   ./scripts/run_containers.sh start mysql_9_test      # For MySQL 9

   # Using Podman
   CONTAINER_RUNTIME=podman ./scripts/run_containers.sh start postgres_17_test
   ```

2. Execute SQL test files:

   ```bash
   # Run PostgreSQL test
   ./scripts/run_sql.sh tests/postgresql/length_test/length_test.sql postgres 17

   # Run MySQL test
   ./scripts/run_sql.sh tests/mysql/length_test/length_test.sql mysql 9
   ```

   The script will:

   - Execute the SQL file in the specified database container
   - Save the output to the results directory with timestamp
   - Display the results in the terminal

3. Check test results:

   ```bash
   # View PostgreSQL test results
   ls -l results/postgresql/version_17/

   # View MySQL test results
   ls -l results/mysql/version_9/
   ```

   Test results are saved in the following format:

   ```
   results/
   ├── postgresql/
   │   └── version_17/
   │       └── length_test_YYYYMMDD_HHMMSS.log
   └── mysql/
       └── version_9/
           └── length_test_YYYYMMDD_HHMMSS.log
   ```

4. Stop containers when done:

   ```bash
   ./scripts/run_containers.sh stop postgres_17_test  # Stop PostgreSQL 17
   # or
   ./scripts/run_containers.sh stop mysql_9_test      # Stop MySQL 9
   ```

### Container Management

The repository includes a container management script (`scripts/run_containers.sh`) with the following commands:

```bash
./scripts/run_containers.sh help    # Show help
./scripts/run_containers.sh start   # Start containers
./scripts/run_containers.sh stop    # Stop containers
./scripts/run_containers.sh status  # Show container status
./scripts/run_containers.sh logs    # View container logs
./scripts/run_containers.sh list    # List available containers
```

## Best Practices

1. **Test Isolation**

   - Each test should be independent and self-contained
   - Clean up test data after execution
   - Use transactions where appropriate
   - Avoid test interdependencies

2. **Documentation**

   - Document test prerequisites and setup
   - Include expected results and edge cases
   - Note any version-specific behaviors
   - Document performance expectations

3. **Version Compatibility**

   - Test across all supported versions
   - Document version-specific features
   - Handle version differences appropriately
   - Maintain backward compatibility

4. **Security**

   - Use secure passwords in production
   - Follow principle of least privilege
   - Secure sensitive test data
   - Use environment variables for credentials

5. **Performance**
   - Monitor resource usage
   - Clean up unused containers
   - Use appropriate indexes
   - Optimize test queries

## Contributing

When adding new test cases:

1. Create a new directory for your test category if it doesn't exist
2. Add a README.md in your test directory explaining:
   - Purpose of the test
   - Expected behavior
   - Any prerequisites or setup required
   - Version compatibility notes
3. Include sample data and expected results
4. Document any version-specific behaviors
5. Follow the established directory structure
6. Update the main README.md if necessary

## Troubleshooting

Common issues and solutions:

1. **Container won't start**

   - Check if ports are available
   - Verify Docker/Podman is running
   - Check container logs

2. **Database connection issues**

   - Verify container is running
   - Check port mappings
   - Verify credentials

3. **Test failures**
   - Check version compatibility
   - Verify test prerequisites
   - Review test logs

## License

This project is licensed under the MIT License - see the LICENSE file for details.
