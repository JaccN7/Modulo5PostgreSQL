-- INSERTAR REGISTROS

-- INSERTAR REGISTROS EN CLIENTE

INSERT INTO
    cliente (nombre, primer_apellido, rut, dv, direccion)
VALUES
    (
        'Eric',
        'Cartman',
        11111111,
        '1',
        'Calle Falsa 123, South Park, Colorado'
    ),
    (
        'Kenny',
        'McCormick',
        22222222,
        '2',
        'Calle Falsa 456, South Park, Colorado'
    ),
    (
        'Stan',
        'Marsh',
        33333333,
        '3',
        'Calle Falsa 789, South Park, Colorado'
    );

-- INSERTAR REGISTROS EN CATEGORIA

INSERT INTO
    categoria (nombre_categoria, descripcion)
VALUES
    (
        'Computacion y Electronica',
        'Computacion y Electronica'
    ),
    (
        'Consolas y Videojuegos',
        'Consolas y Videojuegos'
    );

-- INSERTAR REGISTROS EN PRODUCTO

INSERT INTO
    producto (
        id_categoria,
        nombre_producto,
        descripcion,
        stock,
        valor_unitario
    )
VALUES
    (
        2,
        'Consola PlayStation 5',
        'Sony - Consola Playstation 5',
        10,
        729990
    ),
    (
        1,
        'Headset Razer Kraken V3',
        'Razer - Headset Razer Kraken V3 Hypersense NSW/PS5/PC',
        6,
        110000
    ),
    (
        1,
        'Teclado Razer Ornata V2 (Esp)',
        'Razer - Teclado Razer Ornata V2 (Español)',
        3,
        75000
    ),
    (
        2,
        'Consola Nintendo Switch',
        'Nintendo - Consola Nintendo Switch Modelo OLED Blanco',
        5,
        350000
    ),
    (
        2,
        'Consola Xbox Series X',
        'Microsoft - Consola Xbox Series X',
        20,
        569990
    );

-- INSERTAR REGISTROS EN FACTURA Y EN DETALLE_FACTURA

-- TCL - TRANSACTION

-- INSTRUCCIONES: INGRESAR 3 FACTURAS - usar transacciones para el ingreso de las facturas.

-- ● 1 para el cliente 1, con 3 productos diferentes

-- COMPROBACIONES: STOCK > 0 PARA INSERTAR UNA LINEA DE DETALLE DE UN PRODUCTO

BEGIN;

-- INSERTAR REGISTROS PARA LA PRIMERA FACTURA

INSERT INTO factura VALUES ( 1, 1, '03-06-2022', 0, 0, 0 );

-- PUNTO DE GUARDADO PARA FACTURA

SAVEPOINT factura_creada;

-- INSERTAR REGISTROS DENTRO DEL DETALLE DE LA FACTURA

-- PRIMERA LINEA DE DETALLE

INSERT INTO
    detalle_factura
VALUES
    (
        1,
        1,
        (
            SELECT
                id_producto
            FROM
                producto
            WHERE
                id_producto = 1
        ),
        (
            SELECT
                (valor_unitario / 1.19)
            FROM
                producto
            WHERE
                id_producto = 1
        ),
        (
            SELECT
                ((valor_unitario / 1.19) * 0.19)
            FROM
                producto
            WHERE
                id_producto = 1
        ),
        (
            SELECT
                valor_unitario
            FROM
                producto
            WHERE
                id_producto = 1
        )
    );

-- ACTUALIZAR STOCK DEL PRODUCTO

UPDATE producto SET stock = stock - 1 WHERE id_producto = 1;

-- SEGUNDA LINEA DE DETALLE

INSERT INTO
    detalle_factura
VALUES
    (
        2,
        1,
        (
            SELECT
                id_producto
            FROM
                producto
            WHERE
                id_producto = 2
        ),
        (
            SELECT
                (valor_unitario / 1.19)
            FROM
                producto
            WHERE
                id_producto = 2
        ),
        (
            SELECT
                ((valor_unitario / 1.19) * 0.19)
            FROM
                producto
            WHERE
                id_producto = 2
        ),
        (
            SELECT
                valor_unitario
            FROM
                producto
            WHERE
                id_producto = 2
        )
    );

-- ACTUALIZAR STOCK DEL PRODUCTO

UPDATE producto SET stock = stock - 1 WHERE id_producto = 2;

-- TERCERA LINEA DE DETALLE

INSERT INTO
    detalle_factura
VALUES
    (
        3,
        1,
        (
            SELECT
                id_producto
            FROM
                producto
            WHERE
                id_producto = 4
        ),
        (
            SELECT
                (valor_unitario / 1.19)
            FROM
                producto
            WHERE
                id_producto = 4
        ),
        (
            SELECT
                ((valor_unitario / 1.19) * 0.19)
            FROM
                producto
            WHERE
                id_producto = 4
        ),
        (
            SELECT
                valor_unitario
            FROM
                producto
            WHERE
                id_producto = 4
        )
    );

-- ACTUALIZAR STOCK DEL PRODUCTO

UPDATE producto SET stock = stock - 1 WHERE id_producto = 4;

-- ACTUALIZAR FACTURA EL RESULTADO DE LA SUMA DE LAS LINEAS DE DETALLE

UPDATE
    factura
SET
    subtotal_factura = (
        SELECT
            SUM (subtotal_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 1
    ),
    iva_factura = (
        SELECT
            SUM (iva_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 1
    ),
    total_factura = (
        SELECT
            SUM (cantidad_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 1
    )
WHERE
    nro_factura = 1;

-- ROLLBACK PARA VOLVER AL SAVEPOINT (FACTURA CREADA)

ROLLBACK TO SAVEPOINT factura_creada;

-- ROLLBACK DE TODA LA OPERACIÓN

ROLLBACK;

-- TERMINAR LA OPERACIÓN Y GUARDAR LOS CAMBIOS

COMMIT;

-- ● 1 para el cliente 2, con 2 productos diferentes

-- COMPROBACIONES: STOCK > 0 PARA INSERTAR UNA LINEA DE DETALLE DE UN PRODUCTO

BEGIN;

-- INSERTAR REGISTROS PARA LA SEGUNDA FACTURA

INSERT INTO factura VALUES ( 2, 2, '06-06-2022', 0, 0, 0 );

-- PUNTO DE GUARDADO PARA FACTURA

SAVEPOINT factura_creada;

-- INSERTAR REGISTROS DENTRO DEL DETALLE DE LA FACTURA

-- PRIMERA LINEA DE DETALLE

INSERT INTO
    detalle_factura
VALUES
    (
        4,
        2,
        (
            SELECT
                id_producto
            FROM
                producto
            WHERE
                id_producto = 3
        ),
        (
            SELECT
                (valor_unitario / 1.19)
            FROM
                producto
            WHERE
                id_producto = 3
        ),
        (
            SELECT
                ((valor_unitario / 1.19) * 0.19)
            FROM
                producto
            WHERE
                id_producto = 3
        ),
        (
            SELECT
                valor_unitario
            FROM
                producto
            WHERE
                id_producto = 3
        )
    );

-- ACTUALIZAR STOCK DEL PRODUCTO

UPDATE producto SET stock = stock - 1 WHERE id_producto = 3;

-- SEGUNDA LINEA DE DETALLE

INSERT INTO
    detalle_factura
VALUES
    (
        5,
        2,
        (
            SELECT
                id_producto
            FROM
                producto
            WHERE
                id_producto = 5
        ),
        (
            SELECT
                (valor_unitario / 1.19)
            FROM
                producto
            WHERE
                id_producto = 5
        ),
        (
            SELECT
                ((valor_unitario / 1.19) * 0.19)
            FROM
                producto
            WHERE
                id_producto = 5
        ),
        (
            SELECT
                valor_unitario
            FROM
                producto
            WHERE
                id_producto = 5
        )
    );

-- ACTUALIZAR STOCK DEL PRODUCTO

UPDATE producto SET stock = stock - 1 WHERE id_producto = 5;

-- ACTUALIZAR FACTURA EL RESULTADO DE LA SUMA DE LAS LINEAS DE DETALLE

UPDATE
    factura
SET
    subtotal_factura = (
        SELECT
            SUM (subtotal_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 2
    ),
    iva_factura = (
        SELECT
            SUM (iva_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 2
    ),
    total_factura = (
        SELECT
            SUM (cantidad_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 2
    )
WHERE
    nro_factura = 2;

-- ROLLBACK PARA VOLVER AL SAVEPOINT (FACTURA CREADA)

ROLLBACK TO SAVEPOINT factura_creada;

-- ROLLBACK DE TODA LA OPERACIÓN

ROLLBACK;

-- TERMINAR LA OPERACIÓN Y GUARDAR LOS CAMBIOS

COMMIT;

-- ● 1 para el cliente 3, con 1 solo producto

-- COMPROBACIONES: STOCK > 0 PARA INSERTAR UNA LINEA DE DETALLE DE UN PRODUCTO

BEGIN;

-- INSERTAR REGISTROS PARA LA SEGUNDA FACTURA

INSERT INTO factura VALUES ( 3, 3, '08-06-2022', 0, 0, 0 );

-- PUNTO DE GUARDADO PARA FACTURA

SAVEPOINT factura_creada;

-- INSERTAR REGISTROS DENTRO DEL DETALLE DE LA FACTURA

-- PRIMERA LINEA DE DETALLE

INSERT INTO
    detalle_factura
VALUES
    (
        6,
        3,
        (
            SELECT
                id_producto
            FROM
                producto
            WHERE
                id_producto = 1
        ),
        (
            SELECT
                (valor_unitario / 1.19)
            FROM
                producto
            WHERE
                id_producto = 1
        ),
        (
            SELECT
                ((valor_unitario / 1.19) * 0.19)
            FROM
                producto
            WHERE
                id_producto = 1
        ),
        (
            SELECT
                valor_unitario
            FROM
                producto
            WHERE
                id_producto = 1
        )
    );

-- ACTUALIZAR STOCK DEL PRODUCTO

UPDATE producto SET stock = stock - 1 WHERE id_producto = 1;

-- ACTUALIZAR FACTURA EL RESULTADO DE LA SUMA DE LAS LINEAS DE DETALLE

UPDATE
    factura
SET
    subtotal_factura = (
        SELECT
            SUM (subtotal_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 3
    ),
    iva_factura = (
        SELECT
            SUM (iva_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 3
    ),
    total_factura = (
        SELECT
            SUM (cantidad_producto)
        FROM
            detalle_factura
        WHERE
            nro_factura = 3
    )
WHERE
    nro_factura = 3;

-- ROLLBACK PARA VOLVER AL SAVEPOINT (FACTURA CREADA)

ROLLBACK TO SAVEPOINT factura_creada;

-- ROLLBACK DE TODA LA OPERACIÓN

ROLLBACK;

-- TERMINAR LA OPERACIÓN Y GUARDAR LOS CAMBIOS

COMMIT;