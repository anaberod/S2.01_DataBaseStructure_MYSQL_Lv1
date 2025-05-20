SELECT 
    c.name AS customer_name,
    COUNT(s.id) AS total_sales
FROM 
    sale s
JOIN customer c ON s.customer_id = c.id
WHERE 
    s.sale_date BETWEEN '2025-05-01' AND '2025-05-31' -- puedes cambiar el rango
    AND c.id = 1 -- cambia el ID del cliente según necesites
GROUP BY 
    c.id, c.name;

SELECT 
    e.name AS employee_name,
    g.brand AS glasses_brand,
    COUNT(*) AS times_sold
FROM 
    sale s
JOIN employee e ON s.employee_id = e.id
JOIN glasses g ON s.glasses_id = g.id
WHERE 
    YEAR(s.sale_date) = 2025
    AND e.id = 1 -- cambia por el ID del empleado que te interese
GROUP BY 
    e.name, g.brand;

SELECT DISTINCT 
    s.name AS supplier_name
FROM 
    sale sa
JOIN glasses g ON sa.glasses_id = g.id
JOIN supplier s ON g.supplier_id = s.supplier_id;
