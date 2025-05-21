SELECT 
    ci.name AS city_name,
    COUNT(op.quantity) AS total_drinks_sold
FROM order_product op
JOIN product p ON op.product_id = p.product_id
JOIN orders o ON op.order_id = o.order_id
JOIN store s ON o.store_id = s.store_id
JOIN city ci ON s.city_id = ci.city_id
WHERE p.type = 'drink'
  AND ci.name = 'Manchester'  -- ← Cambia por la localidad que desees
GROUP BY ci.name;

SELECT 
    e.first_name,
    e.last_name,
    COUNT(d.delivery_id) AS total_deliveries
FROM delivery d
JOIN employee e ON d.delivery_employee_id = e.employee_id
WHERE e.employee_id = 3  -- ← Cambia por el ID del empleado que quieras consultar
GROUP BY e.employee_id, e.first_name, e.last_name;

