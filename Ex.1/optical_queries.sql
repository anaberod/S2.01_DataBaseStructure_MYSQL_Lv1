SELECT 
    c.id AS customer_id,
    c.name,
    COUNT(s.id) AS total_facturas
FROM sale s
JOIN customer c ON s.customer_id = c.id
WHERE s.sale_date BETWEEN '2025-01-01' AND '2025-12-31'  -- ← Ajusta este rango
  AND c.id = 1                                           -- ← ID del cliente específico
GROUP BY c.id, c.name;

SELECT 
    e.id AS employee_id,
    e.name AS empleado,
    g.brand AS modelo_gafa,
    COUNT(s.id) AS cantidad_vendida
FROM sale s
JOIN employee e ON s.employee_id = e.id
JOIN glasses g ON s.glasses_id = g.id
WHERE YEAR(s.sale_date) = 2025                         -- ← Ajusta el año
  AND e.id = 1                                         -- ← ID del empleado específico
GROUP BY e.id, e.name, g.brand;

SELECT 
    sup.supplier_id,
    sup.name AS proveedor,
    COUNT(s.id) AS total_ventas
FROM sale s
JOIN glasses g ON s.glasses_id = g.id
JOIN supplier sup ON g.supplier_id = sup.supplier_id
GROUP BY sup.supplier_id, sup.name
ORDER BY total_ventas DESC;                         -- ordenador de mayor a menor éxito

