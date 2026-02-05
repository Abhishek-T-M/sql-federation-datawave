-- DataWave Industries SQL Federation Test Queries
-- Run these in Trino CLI: docker exec -it datawave-trino trino

-- ===================================
-- 1. CATALOG DISCOVERY
-- ===================================
SHOW CATALOGS;
SHOW SCHEMAS FROM postgres;
SHOW SCHEMAS FROM mysql;

-- ===================================
-- 2. SINGLE SOURCE QUERIES
-- ===================================

-- PostgreSQL queries
SELECT * FROM postgres.public.shipments;
SELECT * FROM postgres.public.customers;

-- MySQL queries
SELECT * FROM mysql.supply_chain.warehouses;
SELECT * FROM mysql.supply_chain.inventory;

-- ===================================
-- 3. FEDERATED QUERIES (CROSS-DATABASE)
-- ===================================

-- Simple cross-database join
SELECT 
    s.tracking_number,
    s.origin,
    s.destination,
    w.warehouse_name,
    w.location
FROM postgres.public.shipments s
CROSS JOIN mysql.supply_chain.warehouses w
LIMIT 10;

-- Aggregation across databases
SELECT 
    w.location as warehouse_location,
    w.manager,
    COUNT(DISTINCT s.shipment_id) as total_shipments
FROM postgres.public.shipments s
CROSS JOIN mysql.supply_chain.warehouses w
GROUP BY w.location, w.manager
ORDER BY total_shipments DESC;

-- Complex multi-table join
SELECT 
    c.customer_name,
    c.country,
    s.tracking_number,
    s.status,
    w.warehouse_name,
    i.product_name,
    i.quantity
FROM postgres.public.customers c
CROSS JOIN postgres.public.shipments s
CROSS JOIN mysql.supply_chain.warehouses w
CROSS JOIN mysql.supply_chain.inventory i
WHERE w.warehouse_id = i.warehouse_id
LIMIT 20;

-- ===================================
-- 4. ANALYTICAL QUERIES
-- ===================================

-- Shipment status distribution
SELECT 
    status,
    COUNT(*) as shipment_count
FROM postgres.public.shipments
GROUP BY status;

-- Inventory by warehouse
SELECT 
    w.warehouse_name,
    w.location,
    SUM(i.quantity) as total_inventory
FROM mysql.supply_chain.warehouses w
JOIN mysql.supply_chain.inventory i ON w.warehouse_id = i.warehouse_id
GROUP BY w.warehouse_name, w.location
ORDER BY total_inventory DESC;

-- ===================================
-- 5. DATA QUALITY CHECKS
-- ===================================

-- Count records in each table
SELECT 'postgres.shipments' as table_name, COUNT(*) as row_count FROM postgres.public.shipments
UNION ALL
SELECT 'postgres.customers', COUNT(*) FROM postgres.public.customers
UNION ALL
SELECT 'mysql.warehouses', COUNT(*) FROM mysql.supply_chain.warehouses
UNION ALL
SELECT 'mysql.inventory', COUNT(*) FROM mysql.supply_chain.inventory;
