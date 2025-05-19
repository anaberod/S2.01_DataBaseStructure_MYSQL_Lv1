
CREATE TABLE province (
    province_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    province_id INT,
    FOREIGN KEY (province_id) REFERENCES province(province_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10),
    phone_number VARCHAR(20),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE store (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    nif VARCHAR(20) UNIQUE,
    phone_number VARCHAR(20),
    role ENUM('cook', 'delivery') NOT NULL,
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

CREATE TABLE pizza_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    price DECIMAL(8,2) NOT NULL,
    type ENUM('pizza', 'burger', 'drink') NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES pizza_category(category_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_datetime DATETIME,
    delivery_type ENUM('delivery', 'pickup') NOT NULL,
    total_price DECIMAL(10,2),
    customer_id INT,
    store_id INT,
    delivery_employee_id INT, -- sólo si es delivery
    delivery_datetime DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (delivery_employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE order_product (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO province (name) VALUES
('California'),
('Texas');

INSERT INTO city (name, province_id) VALUES
('Los Angeles', 1),
('San Francisco', 1), 
('Houston', 2); 

INSERT INTO store (address, postal_code, city_id) VALUES
('456 Pizza Avenue', '90001', 1),        -- Los Angeles
('789 Crust Street', '94102', 2),        -- San Francisco
('321 Toppings Blvd', '77001', 3);       -- Houston

INSERT INTO pizza_category (name) VALUES
('Classic'),
('Special'),
('Vegan');

INSERT INTO product (name, description, image_url, price, type, category_id) VALUES
('Margherita Pizza', 'Classic pizza with tomato and mozzarella', 'margherita.jpg', 8.99, 'pizza', 1),
('Pepperoni Pizza', 'Pepperoni slices with mozzarella and tomato sauce', 'pepperoni.jpg', 10.50, 'pizza', 2),
('Vegan Delight', 'Dairy-free cheese, vegetables, and tomato sauce', 'vegan_delight.jpg', 11.25, 'pizza', 3),
('BBQ Burger', 'Grilled beef with BBQ sauce', 'bbq_burger.jpg', 7.50, 'burger', NULL),
('Coca-Cola', '330ml cola soft drink', 'cocacola.jpg', 1.80, 'drink', NULL);

INSERT INTO employee (first_name, last_name, nif, phone_number, role, store_id) VALUES
('John', 'Smith', 'A12345678', '555111111', 'cook', 1),
('Emily', 'Johnson', 'B87654321', '555111112', 'delivery', 1),
('Michael', 'Brown', 'C23456789', '555222221', 'cook', 2),
('Sophia', 'Davis', 'D98765432', '555222222', 'delivery', 2),
('David', 'Wilson', 'E34567890', '555333331', 'cook', 3),
('Olivia', 'Martinez', 'F87654320', '555333332', 'delivery', 3);

INSERT INTO customer (first_name, last_name, address, postal_code, phone_number, city_id) VALUES
('Alice', 'Walker', '123 Sunset Blvd', '90001', '555444001', 1),
('Brian', 'Adams', '456 Ocean Drive', '90002', '555444002', 1),
('Chloe', 'Bennett', '789 Golden Gate Ave', '94102', '555444003', 2),
('Daniel', 'Clark', '321 Bay Street', '94103', '555444004', 2),
('Ella', 'Mitchell', '654 Texas Rd', '77001', '555444005', 3),
('Frank', 'Thompson', '987 Lone Star Pkwy', '77002', '555444006', 3);

INSERT INTO orders (
    order_datetime, delivery_type, total_price,
    customer_id, store_id, delivery_employee_id, delivery_datetime
) VALUES
('2025-05-01 13:30:00', 'delivery', 18.29, 1, 1, 2, '2025-05-01 14:00:00'),
('2025-05-03 12:45:00', 'delivery', 22.50, 3, 2, 4, '2025-05-03 13:20:00'),
('2025-05-05 18:00:00', 'delivery', 19.70, 5, 3, 6, '2025-05-05 18:35:00');

INSERT INTO orders (
    order_datetime, delivery_type, total_price,
    customer_id, store_id, delivery_employee_id, delivery_datetime
) VALUES
('2025-05-01 13:30:00', 'delivery', 18.29, 1, 1, 2, '2025-05-01 14:00:00'),
('2025-05-03 12:45:00', 'delivery', 12.30, 3, 2, 4, '2025-05-03 13:20:00'),
('2025-05-05 18:00:00', 'delivery', 32.79, 5, 3, 6, '2025-05-05 18:35:00'),
('2025-05-06 12:00:00', 'delivery', 12.30, 2, 1, 2, '2025-05-06 12:35:00'),
('2025-05-07 19:45:00', 'delivery', 13.05, 4, 2, 4, '2025-05-07 20:10:00');

INSERT INTO order_product (order_id, product_id, quantity) VALUES
-- Order 1
(1, 1, 1),  
(1, 3, 2),  

-- Order 2
(2, 4, 1),  
(2, 3, 1),  

-- Order 3
(3, 1, 2),  
(3, 3, 3),  
(3, 5, 1),  

-- Order 4
(4, 4, 1),  
(4, 3, 1),  

-- Order 5
(5, 5, 1),  
(5, 3, 1);  


