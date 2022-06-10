-- CREAR BASE DE DATOS

CREATE DATABASE peliculas OWNER postgres;

-- CREAR TABLA PARA PELICULAS

CREATE TABLE peliculas (
    ID INTEGER PRIMARY KEY NOT NULL,
    titulo_pelicula VARCHAR (75) NOT NULL,
    premiere_date INTEGER NOT NULL,
    director VARCHAR (75) NOT NULL
);

-- CREAR TABLA PARA EL REPARTO

CREATE TABLE reparto (
    ID INTEGER NOT NULL,
    nombre_actor VARCHAR (75) NOT NULL
);

-- AÑADIR FOREING KEY

ALTER TABLE
    reparto
ADD
    CONSTRAINT FK_Peliculas_Reparto FOREIGN KEY (ID) REFERENCES peliculas (ID);

--IMPORTAR REGISTROS DE PELICULAS

COPY peliculas
FROM
    'directorio\peliculas.csv' DELIMITER ',' CSV HEADER;

--IMPORTAR REGISTROS REPARTO

COPY reparto FROM 'directorio\reparto.csv' DELIMITER ',' CSV;

SELECT * FROM peliculas;

SELECT * FROM reparto;

-- BUSCAR ID DE UNA PELICULA BUSCANDO POR NOMBRE DE PELICULA

SELECT
    ID,
    titulo_pelicula AS pelicula
FROM
    peliculas
WHERE
    titulo_pelicula = 'Titanic';

-- BUSCAR REPARTO(ACTORES) POR PELICULA

SELECT
    nombre_actor
FROM
    reparto
    JOIN peliculas ON reparto.ID = peliculas.ID
WHERE
    titulo_pelicula = 'Titanic';

-- BUSCAR PELICULAS EN LAS QUE PARTICIPO UN X ACTOR

SELECT
    titulo_pelicula
FROM
    peliculas
    JOIN reparto ON peliculas.ID = reparto.ID
WHERE
    nombre_actor = 'Harrison Ford';

-- MOSTRAR EN CUANTAS PELICULAS PARTICIPA UN X ACTOR

SELECT
    nombre_actor,
    COUNT (titulo_pelicula) AS cantidad_peliculas
FROM
    peliculas
    JOIN reparto ON peliculas.ID = reparto.ID
WHERE
    nombre_actor = 'Harrison Ford'
GROUP BY
    nombre_actor;

-- MOSTRAR PELICULAS ESTRENAS EN UN RANGO DE AÑOS ORDENADAS ALFABETICAMENTE (A - Z)

SELECT
    titulo_pelicula,
    premiere_date as estreno
FROM
    peliculas
WHERE
    premiere_date BETWEEN 1990
    AND 1999
ORDER BY
    titulo_pelicula ASC;

-- MOSTRAR LA LONGITUD DE LOS TITULOS DE LAS PELICULAS

SELECT
    titulo_pelicula,
    LENGTH(titulo_pelicula) as longitud_titulo
FROM
    peliculas;

-- MOSTRAR PELICULA CON EL TITULO DE MAYOR LONGITUD

SELECT
    titulo_pelicula,
    LENGTH(titulo_pelicula) as longitud_titulo
FROM
    peliculas
ORDER BY
    longitud_titulo desc
limit
    1;