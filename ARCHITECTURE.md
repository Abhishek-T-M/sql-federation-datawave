# DataWave Industries - SQL Federation Architecture

## System Overview
```
┌─────────────────────────────────────────────────────────────┐
│                    CLIENT LAYER                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Web UI     │  │  Metabase    │  │   Trino CLI  │      │
│  │   :8080      │  │    :3000     │  │              │      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
└─────────┼──────────────────┼──────────────────┼─────────────┘
          │                  │                  │
          └──────────────────┼──────────────────┘
                             │
┌────────────────────────────▼─────────────────────────────────┐
│                  FEDERATION LAYER                             │
│              ┌─────────────────────────┐                      │
│              │   Trino Query Engine    │                      │
│              │       Port 8080         │                      │
│              └────────────┬────────────┘                      │
│                           │                                   │
│         ┌─────────────────┼─────────────────┐                │
│         │                 │                 │                │
│    ┌────▼────┐       ┌────▼────┐      ┌────▼────┐           │
│    │Postgres │       │  MySQL  │      │  Hive   │           │
│    │Connector│       │Connector│      │Connector│           │
│    └────┬────┘       └────┬────┘      └────┬────┘           │
└─────────┼──────────────────┼─────────────────┼───────────────┘
          │                  │                 │
┌─────────▼──────────────────▼─────────────────▼───────────────┐
│                     DATA SOURCES                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │  PostgreSQL  │  │    MySQL     │  │    MinIO     │       │
│  │              │  │              │  │              │       │
│  │   Logistics  │  │Supply Chain  │  │   S3 Store   │       │
│  │   Database   │  │   Database   │  │              │       │
│  │              │  │              │  │              │       │
│  │   Port 5432  │  │  Port 3306   │  │  Port 9000   │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
└───────────────────────────────────────────────────────────────┘
```

## Component Details

### Federation Layer
- **Trino**: Distributed SQL query engine
  - Version: Latest
  - Port: 8080
  - Catalogs: postgres, mysql, hive (optional)
  
### Data Sources
1. **PostgreSQL** (logistics)
   - Port: 5432
   - Database: logistics
   - Tables: shipments, customers
   
2. **MySQL** (supply_chain)
   - Port: 3306
   - Database: supply_chain
   - Tables: warehouses, inventory
   
3. **MinIO** (object storage)
   - API Port: 9000
   - Console Port: 9001
   - S3-compatible storage

### Presentation Layer
- **Trino Web UI**: Query monitoring and management
- **Metabase**: Business intelligence and visualization
- **CLI Access**: Direct SQL interface via Trino CLI

## Network Architecture

- **Network**: datawave-network (bridge)
- **DNS**: Container name resolution
- **Volumes**: Persistent storage for databases
- **Health Checks**: Automatic service health monitoring

## Data Flow

1. Client sends SQL query to Trino
2. Trino parses and optimizes query
3. Trino pushes down filters to source databases
4. Source databases execute local queries
5. Trino aggregates results
6. Results returned to client

## Security Considerations

- Container network isolation
- No exposed root passwords in production
- Health checks for service monitoring
- MinIO access control
