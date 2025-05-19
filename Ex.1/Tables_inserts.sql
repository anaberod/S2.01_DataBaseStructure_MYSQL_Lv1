ALTER TABLE supplier CHANGE COLUMN id supplier_id INT AUTO_INCREMENT;

ALTER TABLE supplier MODIFY COLUMN name VARCHAR(100) NOT NULL;

ALTER TABLE supplier DROP COLUMN address;

ALTER TABLE supplier CHANGE COLUMN tax_id nif VARCHAR(20);

ALTER TABLE supplier ADD UNIQUE (nif);

ALTER TABLE supplier ADD COLUMN street VARCHAR(100);
ALTER TABLE supplier ADD COLUMN street_number VARCHAR(10);
ALTER TABLE supplier ADD COLUMN floor VARCHAR(10);
ALTER TABLE supplier ADD COLUMN door VARCHAR(10);
ALTER TABLE supplier ADD COLUMN city VARCHAR(100);
ALTER TABLE supplier ADD COLUMN postal_code VARCHAR(20);
ALTER TABLE supplier ADD COLUMN country VARCHAR(100);


CREATE TABLE glasses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50),
    left_lens_grade VARCHAR(10),
    right_lens_grade VARCHAR(10),
    frame_type ENUM('rimless', 'plastic', 'metal'),
    frame_color VARCHAR(30),
    left_lens_color VARCHAR(30),
    right_lens_color VARCHAR(30),
    price DECIMAL(8,2),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES supplier(id)
);
CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    registration_date DATE,
    referred_by INT,
    FOREIGN KEY (referred_by) REFERENCES customer(id)
);
CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);
CREATE TABLE sale (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE,
    customer_id INT,
    employee_id INT,
    glasses_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (glasses_id) REFERENCES glasses(id)
);

INSERT INTO supplier (name, address, phone, fax, tax_id) VALUES
('Vision Supplies S.L.', 'Calle Mayor 123, Madrid', '911223344', '911223345', 'B12345678'),
('Global Glass Co.', 'Av. América 456, Valencia', '963112233', '963112234', 'B87654321'),
('OptiWorld S.A.', 'Passeig de Gràcia 77, Barcelona', '932445566', '932445567', 'B11223344');
INSERT INTO glasses (brand, left_lens_grade, right_lens_grade, frame_type, frame_color, left_lens_color, right_lens_color, price, supplier_id) VALUES
('Ray-Ban', '-1.25', '-1.75', 'metal', 'black', 'gray', 'gray', 129.99, 1),
('Oakley', '0.00', '-2.00', 'plastic', 'red', 'blue', 'blue', 149.50, 2),
('Gucci', '-0.75', '-0.50', 'rimless', 'silver', 'clear', 'clear', 210.00, 3);
INSERT INTO customer (name, address, phone, email, registration_date, referred_by) VALUES
('Laura Gómez', 'Calle Luna 10, Madrid', '600123123', 'laura@example.com', '2025-05-01', NULL),
('Carlos Ruiz', 'Av. Libertad 99, Valencia', '611234567', 'carlos@example.com', '2025-05-02', 1),
('Marta Pérez', 'Gran Vía 45, Barcelona', '622334455', 'marta@example.com', '2025-05-03', 1);
INSERT INTO employee (name, phone, email) VALUES
('Ana Torres', '633445566', 'ana@example.com'),
('Javier López', '644556677', 'javier@example.com'),
('Sofía Ramírez', '655667788', 'sofia@example.com');
INSERT INTO sale (sale_date, customer_id, employee_id, glasses_id) VALUES
('2025-05-05', 1, 1, 1),
('2025-05-06', 2, 2, 2),
('2025-05-07', 3, 3, 3);






