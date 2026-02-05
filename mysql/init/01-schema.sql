-- Supply Chain Database Schema
CREATE TABLE warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(200),
    location VARCHAR(200),
    capacity INT,
    manager VARCHAR(100)
);

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_id INT,
    product_name VARCHAR(200),
    quantity INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

-- Sample Data
INSERT INTO warehouses (warehouse_name, location, capacity, manager) VALUES
('West Coast Hub', 'Los Angeles, CA', 50000, 'John Smith'),
('East Coast Hub', 'New York, NY', 45000, 'Sarah Johnson'),
('Midwest Center', 'Chicago, IL', 40000, 'Michael Brown'),
('Southern Depot', 'Houston, TX', 35000, 'Emily Davis'),
('Northwest Facility', 'Seattle, WA', 38000, 'David Wilson');

INSERT INTO inventory (warehouse_id, product_name, quantity) VALUES
(1, 'Electronics', 1500),
(1, 'Furniture', 800),
(2, 'Clothing', 3200),
(2, 'Electronics', 2100),
(3, 'Automotive Parts', 1800),
(3, 'Furniture', 950),
(4, 'Food Products', 5000),
(5, 'Medical Supplies', 1200);
