-- Create a database (optional, if not already created)
CREATE DATABASE IF NOT EXISTS sample_db;

-- Use the database
USE sample_db;

-- Create a table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    uname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insert some data
INSERT INTO users (uname, email) VALUES 
('hepin', 'hepin@example.com'),
('abc', 'abc@example.com'),
('def', 'def@example.com');

-- Query the table
SELECT * FROM users;
