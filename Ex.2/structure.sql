-- Provincias
CREATE TABLE province (
    province_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Ciudades
CREATE TABLE city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    province_id INT NOT NULL,
    FOREIGN KEY (province_id) REFERENCES province(province_id)
);

-- Clientes
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    phone_number VARCHAR(20),
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- Tiendas
CREATE TABLE store (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- Empleados
CREATE TABLE employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nif VARCHAR(20) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('cook', 'delivery') NOT NULL,
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- Categorías de pizza
CREATE TABLE pizza_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Productos
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    type ENUM('pizza', 'burger', 'drink') NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES pizza_category(category_id)
);

-- Pedidos
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_datetime DATETIME NOT NULL,
    delivery_type ENUM('delivery', 'pickup') NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- Productos por pedido
CREATE TABLE order_product (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Entregas (solo para pedidos de tipo 'delivery')
CREATE TABLE delivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    delivery_employee_id INT NOT NULL,
    delivery_datetime DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (delivery_employee_id) REFERENCES employee(employee_id)
);

-- Trigger para validar que el empleado asignado al delivery tenga el rol correcto
DELIMITER //

CREATE TRIGGER check_delivery_employee_role
BEFORE INSERT ON delivery
FOR EACH ROW
BEGIN
    IF (SELECT role FROM employee WHERE employee_id = NEW.delivery_employee_id) != 'delivery' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El empleado asignado no tiene el rol de delivery.';
    END IF;
END;
//

DELIMITER ;

INSERT INTO province (name) VALUES
('Greater London'),
('West Midlands'),
('Greater Manchester');

INSERT INTO city (name, province_id) VALUES
('London', 1),
('Birmingham', 2),
('Manchester', 3);

INSERT INTO customer (first_name, last_name, address, postal_code, phone_number, city_id) VALUES
('Emily', 'Smith', '10 Baker Street', 'NW1 6XE', '07123456789', 1),
('James', 'Taylor', '22 High Street', 'B4 7BB', '07234567890', 2),
('Olivia', 'Brown', '5 Oxford Road', 'M1 5QA', '07345678901', 3);

INSERT INTO store (address, postal_code, city_id) VALUES
('101 Camden Road', 'NW1 9EU', 1),
('55 New Street', 'B2 4DU', 2),
('77 Deansgate', 'M3 2BW', 3);

INSERT INTO employee (first_name, last_name, nif, phone_number, role, store_id) VALUES
('Liam', 'Johnson', 'UK123456A', '07000000001', 'cook', 1),
('Sophie', 'Evans', 'UK123457B', '07000000002', 'delivery', 2),
('Daniel', 'White', 'UK123458C', '07000000003', 'delivery', 3);

INSERT INTO pizza_category (name) VALUES
('Classic'),
('Vegetarian'),
('Specialty');

INSERT INTO product (name, description, image_url, price, type, category_id) VALUES
('Margherita Pizza', 'Classic cheese and tomato pizza', NULL, 8.99, 'pizza', 1),
('Veggie Supreme', 'Loaded with vegetables', NULL, 9.99, 'pizza', 2),
('Cola Drink', '330ml canned cola', NULL, 1.50, 'drink', NULL);

INSERT INTO orders (order_datetime, delivery_type, total_price, customer_id, store_id) VALUES
('2025-05-01 18:30:00', 'pickup', 8.99, 1, 1),
('2025-05-02 19:00:00', 'delivery', 11.49, 2, 2),
('2025-05-03 20:15:00', 'delivery', 10.49, 3, 3);

INSERT INTO order_product (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- pickup
(2, 2, 1),  -- delivery
(3, 1, 1),  -- delivery
(3, 3, 1);  -- delivery (drink)

INSERT INTO delivery (order_id, delivery_employee_id, delivery_datetime) VALUES
(2, 2, '2025-05-02 19:45:00'),
(3, 3, '2025-05-03 20:45:00');








