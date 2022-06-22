-- Crear tabla autos

CREATE TABLE autos (
    ID SERIAL PRIMARY KEY NOT NULL,
    marca VARCHAR (15) NOT NULL,
    modelo VARCHAR (15) NOT NULL,
    anio INTEGER NOT NULL,
    color VARCHAR (15) NOT NULL,
    precio INTEGER NOT NULL
);

--Crear tabla ventas

CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY NOT NULL,
    fecha DATE NOT NULL,
    id_auto INTEGER,
    cliente VARCHAR (35),
    referencia INTEGER,
    cantidad INTEGER,
    metodo_pago VARCHAR (20)
);

--Agregar foreign key a ventas

ALTER TABLE
    ventas
ADD
    CONSTRAINT FK_Autos_Ventas FOREIGN KEY (id_auto) REFERENCES autos (ID);

-- Importar datos desde CSV

COPY autos FROM 'directorio\autos.csv' DELIMITER ',' CSV HEADER;

COPY ventas
FROM
    'directorio\ventas.csv' DELIMITER ',' CSV HEADER;

--Parte 1 Vehiculos Clientes

SELECT
    ventas.cliente,
    autos.marca,
    autos.modelo
FROM
    ventas
    INNER JOIN autos ON ventas.id_auto = autos.id;

--Parte 2 Todas las ventas (Con o sin vehiculo asociado)

SELECT * FROM ventas;

--Parte 3 Vehiculos no vendidos

SELECT
    autos.id,
    autos.marca,
    autos.modelo
FROM
    ventas
    RIGHT JOIN autos ON ventas.id_auto = autos.ID
WHERE
    ventas.id_auto IS NULL;

--Parte 4

SELECT
    ventas.*,
    autos.*
FROM
    ventas
    LEFT JOIN autos ON ventas.id_auto = autos.ID;

--Parte 5

SELECT
    ventas.*,
    case
        when autos.id is null then 'No existe registro del vehiculo comprado'
    end as error_registro
FROM
    ventas
    LEFT JOIN autos ON ventas.id_auto = autos.ID
WHERE
    ventas.id_auto IS NULL;

--Parte 6 Pagos debito

SELECT
    ventas.cliente,
    autos.marca,
    autos.modelo
FROM
    ventas
    INNER JOIN autos ON ventas.id_auto = autos.ID
WHERE
    ventas.metodo_pago = 'debito';

--Parte 7 Ventas con un precio mayor a 1.500.000

SELECT * FROM ventas WHERE cantidad > 1500000;