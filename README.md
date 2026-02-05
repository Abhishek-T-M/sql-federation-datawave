
### Component Interactions & Data Flow

**How the Federation Works:**

1. **Query Submission** → User submits SQL query via Trino Web UI, CLI, or Metabase
2. **Query Parsing** → Trino parses and validates SQL syntax
3. **Query Planning** → Trino creates distributed execution plan across catalogs
4. **Optimization** → Cost-based optimizer applies predicate pushdown and join optimization
5. **Execution** → Trino sends sub-queries to connectors via JDBC
6. **Data Retrieval** → Connectors query source databases (PostgreSQL, MySQL)
7. **Result Aggregation** → Trino collects and merges results from all sources
8. **Response** → Final result set returned to client

**Network Communication:**
- Docker bridge network: `datawave-network`
- DNS resolution: containers reference each other by name
- JDBC connections: `jdbc:postgresql://postgres:5432/logistics`

**Data Persistence:**
- Persistent volumes ensure data survives container restarts
- Volumes: postgres-data, mysql-data, minio-data, metabase-data

### Design Rationale

| Decision | Reason |
|----------|--------|
| Trino | Industry-standard distributed SQL engine |
| Docker Compose | Simple local dev, portable to production |
| Health checks | Proper startup dependencies |
| Bridge network | Isolated container communication |


### Component Interactions & Data Flow

**How the Federation Works:**

1. **Query Submission** → User submits SQL query via Trino Web UI, CLI, or Metabase
2. **Query Parsing** → Trino parses and validates SQL syntax
3. **Query Planning** → Trino creates distributed execution plan across catalogs
4. **Optimization** → Cost-based optimizer applies predicate pushdown and join optimization
5. **Execution** → Trino sends sub-queries to connectors via JDBC
6. **Data Retrieval** → Connectors query source databases (PostgreSQL, MySQL)
7. **Result Aggregation** → Trino collects and merges results from all sources
8. **Response** → Final result set returned to client

**Network Communication:**
- Docker bridge network: `datawave-network`
- DNS resolution: containers reference each other by name
- JDBC connections: `jdbc:postgresql://postgres:5432/logistics`

**Data Persistence:**
- Persistent volumes ensure data survives container restarts
- Volumes: postgres-data, mysql-data, minio-data, metabase-data

### Design Rationale

| Decision | Reason |
|----------|--------|
| Trino | Industry-standard distributed SQL engine |
| Docker Compose | Simple local dev, portable to production |
| Health checks | Proper startup dependencies |
| Bridge network | Isolated container communication |

