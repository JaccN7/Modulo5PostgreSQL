-- Crear Tablas

CREATE TABLE pokedex_kanto (
    nro_pokedex INTEGER PRIMARY KEY NOT NULL,
    nombre VARCHAR (15) NOT NULL,
    tipo1 VARCHAR (15) NOT NULL,
    tipo2 VARCHAR (15)
);

CREATE TABLE captura_pokemon (
    pokedex INTEGER NOT NULL,
    fecha_captura DATE NOT NULL,
    lugar VARCHAR (25) NOT NULL,
    huevo BOOLEAN NOT NULL,
    peso FLOAT NOT NULL,
    estatura FLOAT NOT NULL
);

-- Añadir foreign key

ALTER TABLE
    captura_pokemon
ADD
    CONSTRAINT FK_PokedexKanto_CapturaPkemon FOREIGN KEY (pokedex) REFERENCES pokedex_kanto (nro_pokedex);

--Importar registros desde CSV

COPY pokedex_kanto
FROM
    'directorio\pokemonesKanto.csv' DELIMITER ',' CSV HEADER;

COPY captura_pokemon
FROM
    'directorio\mis_pokemones.csv' DELIMITER ',' CSV HEADER;

--Parte 1 - A. Listar los pokemones cuya columna pokédex sea mayor a 50.

SELECT * FROM pokedex_kanto WHERE nro_pokedex > 50;

--Parte 1 - B. Listar pokemones de tipo psíquico.

SELECT
    *
FROM
    pokedex_kanto
WHERE
    tipo1 = 'psiquico'
    OR tipo2 = 'psiquico';

--Parte 1 - C. Listar los primeros 22 registros de la tabla pokedex_kanto.

SELECT * FROM pokedex_kanto ORDER BY nro_pokedex ASC LIMIT 22;

-- Parte 2 - Listar los primeros 30 registro de la tabla pokedex_kanto.

-- Establecer alias “pokename” para nombre y “nro_pokedex” para nro_pokedex

SELECT
    nro_pokedex AS nro_pokedex,
    nombre AS pokename,
    tipo1,
    tipo2
FROM
    pokedex_kanto
ORDER BY
    nro_pokedex ASC
LIMIT
    30;

-- Parte 3 - Contar cantidad de pokemon dentro de la pokedex de Kanto

SELECT COUNT ( * ) AS cantidad_pokemon FROM pokedex_kanto;

-- Parte 4 - Contar pokemon con segundo tipo roca

SELECT
    tipo2,
    COUNT (*) AS cantidad_tipo2
FROM
    pokedex_kanto
WHERE
    tipo2 = 'roca'
GROUP BY
    tipo2;