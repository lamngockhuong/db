# Database Testing Repository

This repository contains test cases and scenarios for PostgreSQL and MySQL databases. It's designed to help developers test various database features, behaviors, and edge cases across different versions.

## Supported Database Versions

### PostgreSQL

- 17
- 16

### MySQL

- 9
- 8

## Repository Structure

```
.
├── tests/
│   ├── postgresql/          # PostgreSQL test cases
│   │   ├── version_17/      # Tests specific to PostgreSQL 17
│   │   └── version_16/      # Tests specific to PostgreSQL 16
│   └── mysql/              # MySQL test cases
│       ├── version_9/      # Tests specific to MySQL 9
│       └── version_8/      # Tests specific to MySQL 8
├── scripts/
│   └── run_containers.sh   # Container management script
└── docker-compose.yml      # Container configuration
```

## Test Categories

1. **Basic Operations**

   - CRUD operations
   - Data types and constraints
   - Indexes and performance

2. **Advanced Features**

   - Transactions and ACID properties
   - Concurrency and locking
   - Partitioning and sharding

3. **Edge Cases**
   - Error handling
   - Boundary conditions
   - Performance under load

## Getting Started

### Prerequisites

- Docker or Podman installed
- Docker Compose or Podman Compose

### Running Tests

1. Start the required database container:

   ```bash
   ./scripts/run_containers.sh start postgres_17_test  # For PostgreSQL 17
   # or
   ./scripts/run_containers.sh start mysql_9_test      # For MySQL 9
   ```

2. Navigate to the specific test directory:

   ```bash
   cd tests/postgresql/version_17  # For PostgreSQL 17 tests
   # or
   cd tests/mysql/version_9        # For MySQL 9 tests
   ```

3. Execute the test cases

## Contributing

When adding new test cases:

1. Create a new directory for your test category if it doesn't exist
2. Add a README.md in your test directory explaining:
   - Purpose of the test
   - Expected behavior
   - Any prerequisites or setup required
3. Include sample data and expected results
4. Document any version-specific behaviors

## Container Management

The repository includes a container management script (`scripts/run_containers.sh`) to help set up and manage database containers for testing. See the script's help for usage:

```bash
./scripts/run_containers.sh help
```

## Best Practices

1. **Test Isolation**

   - Each test should be independent
   - Clean up test data after execution
   - Use transactions where appropriate

2. **Documentation**

   - Document test prerequisites
   - Include expected results
   - Note any version-specific behaviors

3. **Version Compatibility**
   - Test across all supported versions
   - Document version-specific features
   - Handle version differences appropriately
