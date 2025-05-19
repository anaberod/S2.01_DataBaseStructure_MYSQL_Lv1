SELECT 
    ci.name AS city,
    COUNT(op.product_id) AS total_drinks_sold
FROM order_product op
JOIN orders o ON op.order_id = o.order_id
JOIN product p ON op.product_id = p.product_id
JOIN store s ON o.store_id = s.store_id
JOIN city ci ON s.city_id = ci.city_id
WHERE p.type = 'drink'
  AND ci.name = 'Los Angeles'  
GROUP BY ci.name;

SELECT 
    e.first_name,
    e.last_name,
    COUNT(o.order_id) AS total_orders_delivered
FROM orders o
JOIN employee e ON o.delivery_employee_id = e.employee_id
WHERE e.first_name = 'Emily' AND e.last_name = 'Johnson' 
GROUP BY e.employee_id, e.first_name, e.last_name;
