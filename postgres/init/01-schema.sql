-- Logistics Database Schema
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    tracking_number VARCHAR(50) UNIQUE NOT NULL,
    origin VARCHAR(100),
    destination VARCHAR(100),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(200),
    email VARCHAR(200),
    country VARCHAR(100)
);

-- Sample Data
INSERT INTO shipments (tracking_number, origin, destination, status) VALUES
('TRK001234', 'Los Angeles, CA', 'New York, NY', 'In Transit'),
('TRK001235', 'Seattle, WA', 'Miami, FL', 'Delivered'),
('TRK001236', 'Chicago, IL', 'Houston, TX', 'Processing'),
('TRK001237', 'Boston, MA', 'San Francisco, CA', 'In Transit'),
('TRK001238', 'Denver, CO', 'Atlanta, GA', 'Delivered');

INSERT INTO customers (customer_name, email, country) VALUES
('Acme Corp', 'contact@acme.com', 'USA'),
('Global Logistics Inc', 'info@globallog.com', 'Canada'),
('Euro Freight', 'hello@eurofreight.eu', 'Germany'),
('Asia Trade Co', 'support@asiatrade.com', 'Singapore'),
('Pacific Shipping', 'info@pacificship.com', 'Australia');
