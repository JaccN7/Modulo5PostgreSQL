-- Realizar las siguientes consultas:
-- 5. ¿Cuál es el nombre del cliente que realizó la compra más cara?
SELECT
	factura.id_cliente,
	concat ( cliente.nombre, ' ', cliente.primer_apellido ) AS nombre_cliente,
	factura.nro_factura,
	factura.total_factura as total_gastado 
FROM
	factura
	LEFT JOIN cliente ON factura.id_cliente = cliente.ID 
ORDER BY
	factura.total_factura desc limit 1;
-- 6. ¿Cuáles son los nombres de los clientes que pagaron más de 60$? Considere un IVA del 19%
SELECT
	factura.id_cliente,
	concat ( cliente.nombre, ' ', cliente.primer_apellido ) AS nombre_cliente,
	factura.nro_factura,
	factura.subtotal_factura,
	factura.iva_factura AS IVA19,
	factura.total_factura 
FROM
	factura
	INNER JOIN cliente ON factura.id_cliente = cliente.ID 
WHERE
	factura.total_factura > 60 
ORDER BY
	factura.total_factura DESC;
-- 7. ¿Cuántos clientes han comprado más de 5 productos? Considere la cantidad por producto comprado.
SELECT
	querie.id_cliente,
	concat ( cliente.nombre, ' ', cliente.primer_apellido ) as cliente,
	querie.nro_factura,
	querie.cantidad_productos 
FROM
	(
	SELECT
		factura.id_cliente,
		factura.nro_factura,
		COUNT ( nro_detalle ) AS cantidad_productos 
	FROM
		detalle_factura
		INNER JOIN factura ON detalle_factura.nro_factura = factura.nro_factura 
	GROUP BY
		factura.nro_factura 
	) AS querie
	INNER JOIN cliente ON querie.id_cliente = cliente.ID 
WHERE
	querie.cantidad_productos > 5;