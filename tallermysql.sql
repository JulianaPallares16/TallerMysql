NORMALIZACIÓN 

CREATE TABLE IF NOT EXISTS customer(
  id VARCHAR(50) PRIMARY KEY,
  nombre VARCHAR(50),
  email VARCHAR(50) UNIQUE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS address(
  id INT AUTO_INCREMENT PRIMARY KEY,
  dirección VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS countries(
  id INT AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(50) UNIQUE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS regions(
  id INT AUTO_INCREMENT PRIMARY KEY,
  region_name VARCHAR(50) UNIQUE,
  country_id INT,
  CONSTRAINT FK_country_id FOREIGN KEY (country_id) REFERENCES countries(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS cities(
  id INT AUTO_INCREMENT PRIMARY KEY,
  city_name VARCHAR(50) UNIQUE,
  region_id INT,
  CONSTRAINT FK_region_id FOREIGN KEY (region_id) REFERENCES regions(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS zip_code(
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(50) UNIQUE,
  city_id INT,
  CONSTRAINT FK_city_id FOREIGN KEY (city_id) REFERENCES cities(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS suppliers(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS locations(
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id VARCHAR(50),
  CONSTRAINT FK_cliente_id FOREIGN KEY (cliente_id) REFERENCES customer(id),
  proveedor_id INT,
  CONSTRAINT FK_proveedor_id FOREIGN KEY (proveedor_id) REFERENCES suppliers(id),
  direccion_id INT,
  CONSTRAINT FK_direccion_id FOREIGN KEY (direccion_id) REFERENCES address(id),
  codigopostal_id INT,
  CONSTRAINT FK_codigopostal_id FOREIGN KEY (codigopostal_id) REFERENCES zip_code(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS empleoyees(
  id INT AUTO_INCREMENT PRIMARY KEY,
  documento VARCHAR(50) UNIQUE
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS empleoyee_data(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  salario DECIMAL(10,2),
  fecha_contrato DATE,
  empleado_id INT,
  CONSTRAINT FK_empleado_id FOREIGN KEY (empleado_id) REFERENCES empleoyees(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS positions(
  id INT AUTO_INCREMENT PRIMARY KEY,
  cargo VARCHAR(50),
  descripción TEXT
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS empleoyee_position(
  id INT AUTO_INCREMENT PRIMARY KEY,
  cargo_id INT,
  CONSTRAINT FK_cargo_id FOREIGN KEY (cargo_id) REFERENCES positions(id),
  empleado_id INT,
  CONSTRAINT FK_empleadoid FOREIGN KEY (empleado_id) REFERENCES empleoyees(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS customer_phone(
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(50),
  código_area VARCHAR(3),
  cliente_id VARCHAR(50),
  CONSTRAINT FK_clienteid FOREIGN KEY (cliente_id) REFERENCES customer(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS supplier_contact(
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(50) UNIQUE,
  proveedor_id INT,
  CONSTRAINT FK_proveedorid FOREIGN KEY (proveedor_id) REFERENCES suppliers(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS supplier_phone(
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(50),
  código_area VARCHAR(3),
  proveedorcontacto_id INT,
  CONSTRAINT FK_proveedorcontacto_id FOREIGN KEY (proveedorcontacto_id) REFERENCES supplier_contact(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS empleoyee_supplier(
  proveedor_id INT,
  CONSTRAINT FK_proveedorrid FOREIGN KEY (proveedor_id) REFERENCES suppliers(id),
  empleado_id INT,
  CONSTRAINT FK_empleadooid FOREIGN KEY (empleado_id) REFERENCES empleoyees(id),
  PRIMARY KEY (proveedor_id, empleado_id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS product_types(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripción TEXT
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS products(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  precio DECIMAL(10,2),
  proveedor_id INT,
  CONSTRAINT FK_provedorid FOREIGN KEY (proveedor_id) REFERENCES suppliers(id),
  tipoproducto_id INT,
  CONSTRAINT FK_tipoproducto_id FOREIGN KEY (tipoproducto_id) REFERENCES product_types(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS orders(
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id VARCHAR(50),
  CONSTRAINT FK_clientid FOREIGN KEY (cliente_id) REFERENCES customer(id),
  fecha DATE,
  empleado_id INT,
  CONSTRAINT FK_empleoyeeid FOREIGN KEY (empleado_id) REFERENCES empleoyees(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS order_detail(
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT,
  CONSTRAINT FK_pedido_id FOREIGN KEY (pedido_id) REFERENCES orders(id),
  producto_id INT,
  CONSTRAINT FK_producto_id FOREIGN KEY (producto_id) REFERENCES products(id),
  cantidad INT,
  precio DECIMAL(10,2)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS order_history(
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_nuevo VARCHAR(50),
  fecha_nueva DATE,
  pedido_id INT,
  CONSTRAINT FK_pedidoid FOREIGN KEY (pedido_id) REFERENCES orders(id)
) ENGINE = INNODB;

DATOS

INSERT INTO customer(id, nombre, email) VALUES ('1104260414', 'Juliana', 'julianaapallaresn@gmail.com'), ('18973450', 'Edgar', 'pallaresedgar@gmail.com'), ('64574575', 'Biela', 'biandel14@hotmail.com'), ('234567', 'Ivanna', 'paterninamercadoivanna@gmail.com');

INSERT INTO address(dirección) VALUES ('Carrera 9 #6i'), ('Avenida inventada 22'), ('Çalle 7 transversal 11');

INSERT INTO address(dirección) VALUES ('Carrera 10 #6y'),  ('Calle 10 #6y'), ('Carrera 10 #13j');

INSERT INTO countries(country_name) VALUES ('Colombia'), ('Venezuela'), ('Ecuador');

INSERT INTO regions(region_name, country_id) VALUES ('Sucre',1), ('Cordoba',1), ('Cesar',1);

INSERT INTO cities(city_name, region_id) VALUES ('Sincelejo', 1), ('Monteria', 2), ('Curumaní', 3);

INSERT INTO zip_code(city_id, codigo) VALUES (1, 'm12345'), (2, 'e12345'), (3, 'b12345');

INSERT INTO locations(cliente_id, direccion_id, codigopostal_id) VALUES ('1104260414', 1, 1), ('18973450', 2, 2), ('64574575', 3, 3);

INSERT INTO locations(proveedor_id, direccion_id, codigopostal_id) VALUES (1, 4, 1), (2, 5, 3), (3, 6, 3);

INSERT INTO positions(cargo, descripción) VALUES ('Asesor', 'Persona especializada que brinda orientación, recomendaciones o soluciones en un área específica para apoyar la toma de decisiones o mejorar resultados'), ('Gerente general', 'Supervisa toda la organización y define estrategias globales');

INSERT INTO empleoyees(documento) VALUES ('123456'), ('654321'), ('246810'), ('1234569');

INSERT INTO empleoyee_position(cargo_id, empleado_id) VALUES (1, 4), (1, 1), (2,2), (1,3);

INSERT INTO empleoyee_data(nombre, salario, fecha_contrato, empleado_id) VALUES ('Dhall', 2500000.00, '2024-03-12', 4), ('Diego', 2500000.00, '2024-03-26', 1), ('Mayudis', 8500000.00, '2020-03-06', 2), ('Marlen', 2500000.00, '2024-03-16', 3);

INSERT INTO suppliers(nombre) VALUES ('Dulceria de la costa'), ('Tienda1'), ('Tienda2');

INSERT INTO product_types(nombre, descripción) VALUES ('Gaseosas', 'Bebida azucarada con colorantes artificiales y gas'), ('Dulces', 'Comida hecha a base de azucares'), ('Enlatados', 'Productos alimenticios almacenados en latas'); 

INSERT INTO products(nombre, precio, proveedor_id, tipoproducto_id) VALUES ('Bolita de leche', 5000.00, 1, 2), ('Coca cola', 3000.00, 2, 1), ('Cocada', 6000.00, 1, 2);

INSERT INTO products(nombre, precio, proveedor_id, tipoproducto_id) VALUES ('Frijoles', 5000.00, 3, 3);

INSERT INTO products(nombre, precio, proveedor_id, tipoproducto_id) VALUES ('Sprite', 3000.00, 2, 1), ('Salchichas', 6000.00, 3, 3), ('Maíz', 8000.00, 3, 3);


INSERT INTO orders(cliente_id, fecha, empleado_id) VALUES ('1104260414', '2025-06-14', 1), ('18973450', '2025-06-21', 3), ('64574575', '2024-06-25', 1)

INSERT INTO orders(cliente_id, fecha, empleado_id) VALUES ('1104260414', '2025-06-22', 1);

INSERT INTO order_detail(pedido_id, producto_id, cantidad, precio) VALUES (1, 1, 5, 25000.00), (2, 3, 2, 12000.00), (3, 3, 5, 30000.00); 

INSERT INTO order_detail(pedido_id, producto_id, cantidad, precio) VALUES (2, 2, 2, 6000.00), (4, 1, 2, 10000.00), (3, 4, 1, 5000.00), (4, 3, 5, 30000.00); 

INSERT INTO order_detail(pedido_id, producto_id, cantidad, precio) VALUES (3, 6, 1, 8000.00), (1, 6, 1, 8000.00), (3, 5, 1, 6000.00);

JOINS

1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN .
SELECT o.id AS pedido_id, 
       o.fecha, c.nombre AS cliente_nombre, 
       e.id AS empleado_id, 
       ed.nombre AS empleado_nombre 
FROM orders AS o 
INNER JOIN customer AS c ON c.id = o.cliente_id 
INNER JOIN empleoyees AS e ON e.id = o.empleado_id 
INNER JOIN empleoyee_data AS ed ON ed.empleado_id = e.id;

2. Listar los productos y proveedores que los suministran con INNER JOIN .
SELECT p.id, 
       p.nombre, 
       p.precio, 
       tp.nombre AS tipo_producto, 
       pr.nombre AS proveedor 
FROM products AS p 
INNER JOIN product_types AS tp ON tp.id = p.tipoproducto_id 
INNER JOIN suppliers AS pr ON pr.id = p.proveedor_id;

3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .
SELECT o.id AS pedido_id, 
       o.fecha, c.nombre AS cliente_nombre, 
       d.dirección AS dirección_cliente, 
       co.codigo AS codigoPostal_cliente, 
       ci.city_name AS ciudad_cliente, 
       r.region_name AS estado_cliente, 
       p.country_name AS pais_cliente, 
       e.id AS empleado_id, 
       ed.nombre AS empleado_nombre 
FROM orders AS o 
LEFT JOIN customer AS c ON c.id = o.cliente_id 
LEFT JOIN empleoyees AS e ON e.id = o.empleado_id 
LEFT JOIN empleoyee_data AS ed ON ed.empleado_id = e.id 
LEFT JOIN locations AS l ON l.cliente_id = c.id 
LEFT JOIN address AS d ON d.id = l.direccion_id 
LEFT JOIN zip_code AS co ON co.id = l.codigopostal_id 
LEFT JOIN cities AS ci ON ci.id = co.city_id 
LEFT JOIN regions AS r ON r.id = ci.region_id 
LEFT JOIN countries AS p ON p.id = r.country_id;

4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos ( LEFT JOIN ).
SELECT e.id AS empleado_id, 
       ed.nombre AS empleado_nombre, 
       p.cargo AS cargo_empleado, 
       o.id AS pedido_id 
FROM empleoyees AS e 
LEFT JOIN empleoyee_data AS ed ON ed.empleado_id = e.id 
LEFT JOIN empleoyee_position AS ep ON ep.empleado_id = e.id 
LEFT JOIN positions AS p ON p.id = ep.cargo_id 
LEFT JOIN orders AS o ON o.empleado_id = e.id;

5. Obtener el tipo de producto y los productos asociados con INNER JOIN .
SELECT tp.id AS id_tipoProducto, 
       tp.nombre AS tipo_producto, 
       p.id AS id_producto, p.nombre AS producto 
FROM product_types AS tp 
INNER JOIN products AS p ON p.tipoproducto_id = tp.id;

6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY .
SELECT c.id AS cliente_id, 
       c.nombre AS cliente, 
       COUNT(o.id) AS numero_pedidos 
FROM customer AS c 
LEFT JOIN orders o ON o.cliente_id = c.id 
GROUP BY c.id, c.nombe;

7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos.
SELECT o.id AS pedido, 
       e.id AS id_empleado, 
       ed.nombre AS nombre_empleado 
FROM orders AS o 
INNER JOIN empleoyees AS e ON e.id = o.empleado_id 
INNER JOIN empleoyee_data AS ed ON ed.empleado_id = e.id;

8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).
SELECT p.id AS producto_id, 
       p.nombre AS nombre_producto 
FROM order_detail AS od 
RIGHT JOIN products AS p ON p.id = od.producto_id 
WHERE od.producto_id IS NULL;

9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN .
SELECT c.id AS cliente_id, 
       c.nombre AS cliente, 
       d.dirección AS dirección_cliente, 
       co.codigo AS codigoPostal_cliente, 
       ci.city_name AS ciudad_cliente, 
       r.region_name AS estado_cliente, 
       p.country_name AS pais_cliente, 
       COUNT(o.id) AS numero_pedidos 
FROM customer AS c 
LEFT JOIN orders o ON o.cliente_id = c.id 
LEFT JOIN locations AS l ON l.cliente_id = c.id 
LEFT JOIN address AS d ON d.id = l.direccion_id 
LEFT JOIN zip_code AS co ON co.id = l.codigopostal_id 
LEFT JOIN cities AS ci ON ci.id = co.city_id 
LEFT JOIN regions AS r ON r.id = ci.region_id 
LEFT JOIN countries AS p ON p.id = r.country_id 
GROUP BY c.id, c.nombre, d.dirección, co.codigo, ci.city_name, r.region_name, p.country_name;

10. Unir Proveedores , Productos , y TiposProductos para un listado completo de inventario.
SELECT p.id AS producto_id, 
       p.nombre AS nombre_producto, 
       p.precio, pr.nombre AS proveedor, 
       tp.nombre AS tipo_producto 
FROM products AS p 
INNER JOIN suppliers AS pr ON pr.id = p.proveedor_id 
INNER JOIN product_types AS tp ON tp.id = p.tipoproducto_id;

CONSULTAS SIMPLES

1. Seleccionar todos los productos con precio mayor a $50.
SELECT p.id,
       p.nombre AS producto,
       p.precio 
FROM products AS p 
WHERE p.precio > 50;

2. Consultar clientes registrados en una ciudad específica.
SELECT ci.city_name,
       c.id, c.nombre AS nombre_cliente 
FROM customer AS c 
INNER JOIN locations AS l ON l.cliente_id = c.id 
INNER JOIN zip_code AS zc ON zc.id = l.codigopostal_id 
INNER JOIN cities AS ci ON ci.id = zc.city_id 
WHERE city_name = 'Sincelejo';

3. Mostrar empleados contratados en los últimos 2 años.
SELECT ed.id, 
       ed.nombre AS nombre_empleado, 
       ed.fecha_contrato 
FROM empleoyee_data AS ed 
INNER JOIN empleoyees AS e ON e.id = ed.empleado_id 
WHERE ed.fecha_contrato >= CURDATE() -INTERVAL 2 YEAR;

4. Seleccionar proveedores que suministran más de 5 productos.
SELECT pr.id AS proveedor_id, 
       pr.nombre AS proveedor, 
       COUNT(p.id) AS total_productos 
FROM suppliers AS pr 
INNER JOIN products AS p ON p.proveedor_id = pr.id 
GROUP BY pr.id, pr.nombre 
HAVING COUNT(p.id) > 5;

5. Listar clientes que no tienen dirección registrada en UbicacionCliente .
SELECT c.id, 
       c.nombre AS cliente 
FROM customer AS c 
LEFT JOIN locations AS l ON l.cliente_id = c.id 
WHERE l.cliente_id IS NULL;

6. Calcular el total de ventas por cada cliente.
SELECT c.id, 
       c.nombre AS cliente, 
       COUNT(o.id) AS total_ventas 
FROM customer AS c 
INNER JOIN orders AS o ON o.cliente_id = c.id 
GROUP BY c.id, c.nombre;

7. Mostrar el salario promedio de los empleados.
SELECT AVG(ed.salario) AS promedio_salario 
FROM empleoyee_data AS ed 
INNER JOIN empleoyees AS e ON e.id = ed.empleado_id;

8. Consultar el tipo de productos disponibles en TiposProductos .
SELECT tp.id, 
       tp. nombre AS tipos_productos 
FROM product_types AS tp;

9. Seleccionar los 3 productos más caros.
SELECT id, nombre AS producto, 
       precio 
FROM products 
ORDER BY precio 
DESC LIMIT 3;

10. Consultar el cliente con el mayor número de pedidos.
SELECT c.id, 
       c.nombre AS cliente, 
       COUNT(o.id) AS numero_pedidos 
FROM customer AS c 
INNER JOIN orders AS o ON o.cliente_id = c.id 
GROUP BY c.id, c.nombre 
ORDER BY numero_pedidos 
DESC LIMIT 1;

CONSULTAS MULTITABLA

1. Listar todos los pedidos y el cliente asociado.
SELECT o.id AS id_pedido, 
       o.fecha, c.nombre AS cliente 
FROM orders AS o 
INNER JOIN customer AS c ON c.id = o.cliente_id;

2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT o.id AS pedido_id, 
       o.fecha, c.nombre AS cliente_nombre, 
       d.dirección AS dirección_cliente, 
       co.codigo AS codigoPostal_cliente, 
       ci.city_name AS ciudad_cliente, 
       r.region_name AS estado_cliente, 
       p.country_name AS pais_cliente 
FROM orders AS o INNER JOIN customer AS c ON c.id = o.cliente_id 
INNER JOIN locations AS l ON l.cliente_id = c.id 
INNER JOIN address AS d ON d.id = l.direccion_id 
INNER JOIN zip_code AS co ON co.id = l.codigopostal_id 
INNER JOIN cities AS ci ON ci.id = co.city_id 
INNER JOIN regions AS r ON r.id = ci.region_id 
INNER JOIN countries AS p ON p.id = r.country_id;

3. Listar productos junto con el proveedor y tipo de producto.
SELECT p.nombre AS nombre_producto, 
       pr.nombre AS proveedor, 
       tp.nombre AS tipo_producto 
FROM products AS p 
INNER JOIN suppliers AS pr ON pr.id = p.proveedor_id 
INNER JOIN product_types AS tp ON tp.id = p.tipoproducto_id;

4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
SELECT ci.city_name, 
       e.id AS empleado_id, 
       ed.nombre AS nombre_empleado 
FROM orders AS o 
INNER JOIN empleoyees AS e ON e.id = o.empleado_id 
INNER JOIN empleoyee_data AS ed ON ed.empleado_id = e.id 
INNER JOIN customer AS c ON c.id = o.cliente_id 
INNER JOIN locations AS l ON l.cliente_id = c.id 
INNER JOIN zip_code AS zc ON zc.id = l.codigopostal_id 
INNER JOIN cities AS ci ON ci.id = zc.city_id 
WHERE city_name = 'Sincelejo';

5. Consultar los 5 productos más vendidos.
SELECT p.id, 
       p.nombre AS producto, 
       SUM(od.cantidad) cantidad_vendida 
FROM products AS p 
INNER JOIN order_detail AS od ON od.producto_id = p.id 
GROUP BY p.id, p.nombre 
ORDER BY cantidad_vendida 
DESC LIMIT 5;

6. Obtener la cantidad total de pedidos por cliente y ciudad.
SELECT c.id AS cliente_id, 
       c.nombre AS cliente, 
       ci.city_name AS ciudad, 
       COUNT(o.id) AS total_pedidos 
FROM orders AS o 
INNER JOIN customer AS c ON c.id = o.cliente_id 
INNER JOIN locations AS l ON l.cliente_id = c.id 
INNER JOIN zip_code AS zc ON zc.id = l.codigopostal_id 
INNER JOIN cities AS ci ON ci.id = zc.city_id 
GROUP BY c.id, c.nombre, ci.city_name;

7. Listar clientes y proveedores en la misma ciudad.
SELECT ci.city_name AS ciudad, 
       c.id AS cliente_id, 
       c.nombre AS cliente, 
       pr.id AS proveedor_id, 
       pr.nombre AS proveedor 
FROM locations AS lc 
INNER JOIN customer AS c ON c.id = lc.cliente_id 
INNER JOIN zip_code AS zc ON zc.id = lc.codigopostal_id 
INNER JOIN cities AS ci ON ci.id = zc.city_id 
INNER JOIN locations AS lp ON lp.codigopostal_id = lc.codigopostal_id 
INNER JOIN suppliers AS pr ON pr.id = lp.proveedor_id;

8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT tp.id AS id_tipoproducto, 
       tp.nombre AS tipo_producto, 
       SUM(od.cantidad) AS ventas_totales 
FROM product_types AS tp 
INNER JOIN products AS p ON p.tipoproducto_id = tp.id 
INNER JOIN order_detail AS od ON od.producto_id = p.id 
GROUP BY tp.id, tp.nombre;

9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
SELECT e.id, 
       ed.nombre AS empleado 
FROM empleoyees AS e 
INNER JOIN empleoyee_data AS ed ON ed.empleado_id = e.id 
INNER JOIN orders AS o ON o.empleado_id = e.id 
INNER JOIN order_detail AS od ON od.pedido_id = o.id 
INNER JOIN products AS p ON p.id = od.producto_id 
INNER JOIN suppliers AS pr ON pr.id = p.proveedor_id 
WHERE pr.nombre = 'Dulceria de la costa' 
GROUP BY e.id, ed.nombre;

10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
SELECT pr.id AS proveedor_id, 
       pr.nombre AS proveedor, 
       SUM(od.precio * od.cantidad) AS ingreso_total 
FROM suppliers AS pr 
INNER JOIN products AS p ON p.proveedor_id = pr.id 
INNER JOIN order_detail AS od ON od.producto_id = p.id 
GROUP BY pr.id, pr.nombre;

SUBCONSULTAS

1. Consultar el producto más caro en cada categoría.
SELECT p.nombre AS producto,
       p.precio,
       pt.nombre AS categoría
FROM products AS p
JOIN product_types pt ON p.tipoproducto_id = pt.id
WHERE p.precio = (
    SELECT MAX(p2.precio)
    FROM products AS p2
    WHERE p2.tipoproducto_id = p.tipoproducto_id
);

2. Encontrar el cliente con mayor total en pedidos.
SELECT c.nombre,
    SUM(od.cantidad * od.precio) AS total_compras
FROM customer c
JOIN orders o ON c.id = o.cliente_id
JOIN order_detail od ON o.id = od.pedido_id
GROUP BY c.id, c.nombre
HAVING total_compras = (
    SELECT MAX(total_por_cliente)
    FROM (
        SELECT SUM(od2.cantidad * od2.precio) AS total_por_cliente
        FROM orders o2
        JOIN order_detail od2 ON o2.id = od2.pedido_id
        GROUP BY o2.cliente_id
    ) AS subconsulta
);

3. Listar empleados que ganan más que el salario promedio.
SELECT e.nombre 
FROM empleoyee_data AS e
WHERE e.salario > (
         SELECT AVG(e2.salario)
         FROM empleoyee_data AS e2
);

4. Consultar productos que han sido pedidos más de 5 veces.
SELECT p.nombre
FROM products AS p
WHERE (
      SELECT SUM(o.cantidad)
      FROM order_detail AS o
      WHERE o.producto_id = p.id
) > 5;

5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
SELECT o.id AS detalle_pedido_id,
    p.id AS pedido_id,
    o.producto_id, o.cantidad,
    o.precio, 
    (o.cantidad * o.precio) AS total
FROM orders AS p
JOIN order_detail AS o ON o.pedido_id = p.id
WHERE (o.cantidad * o.precio) > (
SELECT AVG(od.cantidad * od.precio)
FROM order_detail od
);

6. Seleccionar los 3 proveedores con más productos.
SELECT id, nombre AS nombre_proveedor, total_productos
FROM (
    SELECT s.id, s.nombre, COUNT(p.id) AS total_productos
    FROM suppliers s
    JOIN products AS p ON s.id = p.proveedor_id
    GROUP BY s.id, s.nombre
) AS subconsulta
ORDER BY total_productos DESC
LIMIT 3;

7. Consultar productos con precio superior al promedio en su tipo.
SELECT p.nombre, p.precio, pt.nombre AS tipo
FROM products AS p
JOIN product_types AS  pt ON p.tipoproducto_id = pt.id
WHERE p.precio > (
    SELECT AVG(p2.precio)
    FROM products AS p2
    WHERE p2.tipoproducto_id = p.tipoproducto_id
);

8. Mostrar clientes que han realizado más pedidos que la media.
SELECT c.id, c.nombre, COUNT(o.id) AS total_pedidos
FROM customer AS c
JOIN orders AS o ON c.id = o.cliente_id
GROUP BY c.id, c.nombre
HAVING COUNT(o.id) > (
    SELECT AVG(cantidad_pedidos)
    FROM (
        SELECT COUNT(o2.id) AS cantidad_pedidos
        FROM orders AS o2
        GROUP BY o2.cliente_id
    ) AS pedidos_por_cliente
);

9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
SELECT p.nombre AS producto,
       p.precio
FROM products AS p
WHERE p.precio > (
    SELECT AVG(pr.precio)
    FROM products AS pr
);

10. Mostrar empleados cuyo salario es menor al promedio del departamento.
SELECT e.nombre,
       e.salario,
       p.cargo
FROM empleoyee_data AS e
JOIN empleoyee_position ep ON e.empleado_id = ep.empleado_id
JOIN positions p ON ep.cargo_id = p.id
WHERE e.salario < (
    SELECT AVG(e2.salario)
    FROM empleoyee_data e2
    JOIN empleoyee_position ep2 ON e2.empleado_id = ep2.empleado_id
    WHERE ep2.cargo_id = ep.cargo_id
);

PROCEDIMIENTOS ALMACENADOS

1. Crear un procedimiento para actualizar el precio de todos los productos de un proveedor.
DELIMITER $$

CREATE PROCEDURE actualizar_precios_proveedor (
    IN proveedor_id INT,
    IN nuevo_precio DECIMAL(10,2)
)
BEGIN
    UPDATE products
    SET precio = p_nuevo_precio
    WHERE proveedor_id = proveedor_id;
END $$

DELIMITER ;

CALL actualizar_precios_proveedor(3, 150.00);

2. Un procedimiento que devuelva la dirección de un cliente por ID.
DELIMITER $$

CREATE PROCEDURE obtener_direcciones_cliente (
    IN cliente_id VARCHAR(50)
)
BEGIN
    SELECT a.id, a.dirección
    FROM locations l
    JOIN address a ON l.direccion_id = a.id
    WHERE l.cliente_id = cliente_id;
END $$

DELIMITER ;

CALL obtener_direcciones_cliente('1104260414');

3. Crear un procedimiento que registre un pedido nuevo y sus detalles.
DELIMITER $$

CREATE PROCEDURE registrar_pedido_simple (
    IN cliente_id VARCHAR(50),
    IN fecha DATE,
    IN empleado_id INT
)
BEGIN
    INSERT INTO orders (cliente_id, fecha, empleado_id)
    VALUES (cliente_id, fecha, empleado_id);
    
    SELECT LAST_INSERT_ID() AS id_pedido;
END $$

DELIMITER ;

CALL registrar_pedido_simple('18973450', '2025-07-04', 2);

4. Un procedimiento para calcular el total de ventas de un cliente.
DELIMITER $$

CREATE PROCEDURE total_ventas_cliente (
    IN cliente_id VARCHAR(50)
)
BEGIN
    SELECT IFNULL(SUM(od.cantidad * od.precio), 0) AS total_ventas
    FROM orders o
    JOIN order_detail od ON o.id = od.pedido_id
    WHERE o.cliente_id = cliente_id;
END $$

DELIMITER ;

CALL total_ventas_cliente('1104260414');

5. Crear un procedimiento para obtener los empleados por puesto.
DELIMITER $$

CREATE PROCEDURE empleados_por_puesto (
    IN cargo_id INT
)
BEGIN
    SELECT ed.nombre, ed.salario, e.documento, pos.cargo
    FROM empleoyees e
    JOIN empleoyee_data ed ON e.id = ed.empleado_id
    JOIN empleoyee_position ep ON e.id = ep.empleado_id
    JOIN positions pos ON ep.cargo_id = pos.id
    WHERE pos.id = cargo_id;
END $$

DELIMITER ;

CALL empleados_por_puesto(2);

6. Un procedimiento que actualice el salario de empleados por puesto.
DELIMITER $$

CREATE PROCEDURE actualizar_salario_por_puesto (
    IN cargo_id INT,
    IN nuevo_salario DECIMAL(10,2)
)
BEGIN
    UPDATE empleoyee_data ed
    JOIN empleoyee_position ep ON ed.empleado_id = ep.empleado_id
    SET ed.salario = nuevo_salario
    WHERE ep.cargo_id = cargo_id;
END $$

DELIMITER ;

CALL actualizar_salario_por_puesto(2, 2000.00);

7. Crear un procedimiento que liste los pedidos entre dos fechas.
DELIMITER $$

CREATE PROCEDURE pedidos_entre_fechas (
    IN fecha_inicio DATE,
    IN fecha_fin DATE
)
BEGIN
    SELECT o.id AS pedido_id,
           o.fecha,
           o.cliente_id,
           o.empleado_id
    FROM orders o
    WHERE o.fecha BETWEEN fecha_inicio AND fecha_fin
    ORDER BY o.fecha;
END $$

DELIMITER ;

CALL pedidos_entre_fechas('2025-06-01', '2025-07-04');

8. Un procedimiento para aplicar un descuento a productos de una categoría.
DELIMITER $$

CREATE PROCEDURE aplicar_descuento_categoria (
    IN categoria_id INT,
    IN porcentaje_descuento DECIMAL(5,2)
)
BEGIN
    UPDATE products
    SET precio = precio * (1 - (porcentaje_descuento / 100))
    WHERE tipoproducto_id = categoria_id;
END $$

DELIMITER ;

CALL aplicar_descuento_categoria(3, 15);

9. Crear un procedimiento que liste todos los proveedores de un tipo de producto.
DELIMITER $$

CREATE PROCEDURE proveedores_por_tipo_producto (
    IN tipo_producto_id INT
)
BEGIN
    SELECT DISTINCT s.id, s.nombre
    FROM suppliers s
    JOIN products p ON s.id = p.proveedor_id
    WHERE p.tipoproducto_id = tipo_producto_id;
END $$

DELIMITER ;

CALL proveedores_por_tipo_producto(3);

10. Un procedimiento que devuelva el pedido de mayor valor.
DELIMITER $$

CREATE PROCEDURE pedido_mayor_valor()
BEGIN
    SELECT o.id AS pedido_id,
           o.cliente_id,
           o.fecha,
           SUM(od.cantidad * od.precio) AS total
    FROM orders o
    JOIN order_detail od ON o.id = od.pedido_id
    GROUP BY o.id, o.cliente_id, o.fecha
    ORDER BY total DESC
    LIMIT 1;
END $$

DELIMITER ;

CALL pedido_mayor_valor();








