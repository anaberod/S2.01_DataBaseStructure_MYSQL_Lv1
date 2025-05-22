
CREATE TABLE address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100),
    street_number VARCHAR(10),
    floor VARCHAR(10),
    door VARCHAR(10),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100)
);


CREATE TABLE supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nif VARCHAR(20) UNIQUE,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(id) ON DELETE SET NULL
);


CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    registration_date DATE,
    referred_by INT,
    address_id INT,
    FOREIGN KEY (referred_by) REFERENCES customer(id) ON DELETE SET NULL,
    FOREIGN KEY (address_id) REFERENCES address(id) ON DELETE SET NULL
);


CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);


CREATE TABLE glasses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    left_lens_grade VARCHAR(10),
    right_lens_grade VARCHAR(10),
    frame_type ENUM('rimless', 'plastic', 'metal'),
    frame_color VARCHAR(30),
    left_lens_color VARCHAR(30),
    right_lens_color VARCHAR(30),
    price DECIMAL(8,2),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id) ON DELETE SET NULL
);


CREATE TABLE sale (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE,
    customer_id INT,
    employee_id INT,
    glasses_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE SET NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE SET NULL,
    FOREIGN KEY (glasses_id) REFERENCES glasses(id) ON DELETE SET NULL
);

INSERT INTO address (street, street_number, floor, door, city, postal_code, country) VALUES
('Main St', '101', '1', 'A', 'Madrid', '28001', 'Spain'),
('Second Ave', '202', '2', 'B', 'Barcelona', '08002', 'Spain'),
('Third Blvd', '303', '3', 'C', 'Valencia', '46003', 'Spain');

INSERT INTO supplier (name, nif, address_id) VALUES
('Optic Pro', 'B12345678', 1),
('Visionary Supplies', 'B87654321', 2),
('LensCraft', 'B56781234', 3);

INSERT INTO customer (name, phone, email, registration_date, referred_by, address_id) VALUES
('Ana López', '600123456', 'ana.lopez@email.com', '2024-01-15', NULL, 1),
('Carlos Ruiz', '600654321', 'carlos.ruiz@email.com', '2024-02-10', 1, 2),
('Lucía Gómez', '600111222', 'lucia.gomez@email.com', '2024-03-05', 1, 3);

INSERT INTO employee (name, phone, email) VALUES
('Pedro Martín', '699000111', 'pedro.martin@optic.com'),
('Marta Sánchez', '699111222', 'marta.sanchez@optic.com'),
('Raúl Díaz', '699222333', 'raul.diaz@optic.com');

INSERT INTO glasses (brand, left_lens_grade, right_lens_grade, frame_type, frame_color, left_lens_color, right_lens_color, price, supplier_id) VALUES
('Ray-Ban', '-1.00', '-1.25', 'metal', 'black', 'clear', 'clear', 120.50, 1),
('Oakley', '-0.50', '-0.75', 'plastic', 'red', 'blue', 'blue', 150.00, 2),
('Gucci', '-1.75', '-2.00', 'rimless', 'gold', 'green', 'green', 220.00, 3);

INSERT INTO sale (sale_date, customer_id, employee_id, glasses_id) VALUES
('2025-01-10', 1, 1, 1),
('2025-02-15', 2, 2, 2),
('2025-03-20', 3, 3, 3);







