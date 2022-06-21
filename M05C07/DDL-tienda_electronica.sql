-- CREAR BASE DE DATOS

CREATE DATABASE "tienda_de_electronica" WITH OWNER = "postgres" ENCODING = 'UTF8';

-- CREAR TABLAS

-- CREAR TABLA CLIENTE

CREATE TABLE cliente (
    ID SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR (30) NOT NULL,
    primer_apellido VARCHAR (30) NOT NULL,
    rut INTEGER NOT NULL,
    dv CHAR (1) NOT NULL,
    direccion VARCHAR (50)
);

-- CREAR TABLA FACTURA

CREATE TABLE factura (
    nro_factura INTEGER PRIMARY KEY NOT NULL,
    id_cliente INTEGER NOT NULL,
    fecha_factura DATE NOT NULL,
    subtotal_factura INTEGER NOT NULL,
    iva_factura INTEGER NOT NULL,
    total_factura INTEGER NOT NULL
);

-- CREAR TABLA DETALLE_FACTURA

CREATE TABLE detalle_factura (
    nro_detalle INTEGER PRIMARY KEY NOT NULL,
    nro_factura INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    subtotal_producto INTEGER NOT NULL,
    iva_producto INTEGER NOT NULL,
    cantidad_producto INTEGER NOT NULL
);

-- CREAR TABLA PRODUCTO

CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY NOT NULL,
    id_categoria INTEGER NOT NULL,
    nombre_producto VARCHAR (30) NOT NULL,
    descripcion VARCHAR (75),
    stock INTEGER NOT NULL,
    valor_unitario INTEGER NOT NULL
);

-- CREAR TABLA CATEGORIA

CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY NOT NULL,
    nombre_categoria VARCHAR (25) NOT NULL,
    descripcion VARCHAR (75)
);

-- AÑADIR LLAVES FORANEAS

-- LLAVES FORANEAS A FACTURA

ALTER TABLE
    factura
ADD
    CONSTRAINT FK_Cliente_Factura FOREIGN KEY (id_cliente) REFERENCES cliente (ID);

-- LLAVES FORANEAS A DETALLE_FACTURA

ALTER TABLE
    detalle_factura
ADD
    CONSTRAINT FK_Factura_DetalleFactura FOREIGN KEY (nro_factura) REFERENCES factura (nro_factura);

ALTER TABLE
    detalle_factura
ADD
    CONSTRAINT FK_Producto_DetalleFactura FOREIGN KEY (id_producto) REFERENCES producto (id_producto);

-- LLAVES FORANEAS A PRODUCTO

ALTER TABLE
    producto
ADD
    CONSTRAINT FK_Categoria_Producto FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);