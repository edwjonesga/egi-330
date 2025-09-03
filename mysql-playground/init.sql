CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (name, position, salary) VALUES
('Alice', 'Engineer', 75000.00),
('Bob', 'Manager', 85000.00),
('Carol', 'Designer', 65000.00);
