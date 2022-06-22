-- M05C03 Ejercicio en Clase

-- Parte 1

-- 1. Crear una base de datos con nombre “Posts”.

CREATE DATABASE "posts" WITH OWNER = "postgres" ENCODING = 'utF8';

-- 2. Crear una tabla “post”, con los atributos id, nombre de usuario, fecha de creación, contenido y descripción.

CREATE TABLE posts (
    ID SERIAL PRIMARY KEY NOT NULL,
    nombre_de_usuario VARCHAR (15) NOT NULL,
    fecha_de_creacion DATE NOT NULL,
    contenido VARCHAR (35),
    descripcion VARCHAR (35)
);

-- 3.  Insertar 3 post, 2 para el usuario "Pamela" y uno para "Carlos".

INSERT INTO
    posts (
        nombre_de_usuario,
        fecha_de_creacion,
        contenido,
        descripcion
    )
VALUES
    (
        'Pamela',
        '01/06/2022',
        'Este es el primer post de Pamela',
        'Solo es un post'
    ),
    (
        'Pamela',
        '03/06/2022',
        'Este es el segundo post de Pamela',
        'Solo es un post'
    ),
    (
        'Carlos',
        '05/06/2022',
        'Este es el primer post de Carlos',
        'Solo es un post'
    );

-- 4. Modificar la tabla post, agregando la columna título.

ALTER TABLE posts ADD COLUMN titulo VARCHAR ( 15 );

-- 5. Agregar título a las publicaciones ya ingresadas.

UPDATE posts SET titulo = 'Titulo Post 1' WHERE ID = 1;

UPDATE posts SET titulo = 'Titulo Post 2' WHERE ID = 2;

UPDATE posts SET titulo = 'Titulo Post 3' WHERE ID = 3;

-- 6. Insertar 2 post para el usuario "Pedro".

INSERT INTO
    posts (
        nombre_de_usuario,
        fecha_de_creacion,
        contenido,
        descripcion,
        titulo
    )
VALUES
    (
        'Pedro',
        '09/06/2022',
        'Este es el primer post de Pedro',
        'Solo es un post',
        'Titulo Post 4'
    );

-- 7.  Eliminar el post de Carlos.

DELETE FROM posts WHERE ID = 3;

-- 8. Ingresar un nuevo post para el usuario "Carlos"

INSERT INTO
    posts (
        nombre_de_usuario,
        fecha_de_creacion,
        contenido,
        descripcion,
        titulo
    )
VALUES
    (
        'Carlos',
        '15/06/2022',
        'Este es un nuevo post de Carlos',
        'Solo es un post',
        'Titulo Post 5'
    );

--Parte 2

-- 1. Crear una nueva tabla llamada “comentarios”, con los atributos id, fecha, hora de creación y contenido, que se relacione con la tabla posts.

CREATE TABLE comentarios (
    ID SERIAL PRIMARY KEY NOT NULL,
    id_post INTEGER NOT NULL,
    fechayhora TIMESTAMP NOT NULL,
    contenido VARCHAR (35)
);

ALTER TABLE
    comentarios
ADD
    CONSTRAINT FK_Posts_Comentarios FOREIGN KEY (id_post) REFERENCES posts (ID);

-- 2. Crear 2 comentarios para el post de "Pamela" y 4 para "Carlos".

INSERT INTO
    comentarios (id_post, fechayhora, contenido)
VALUES
    (
        1,
        '2022-06-01 22:59:59',
        'Comentario 1 al Post de Pamela'
    ),
    (
        1,
        '2022-06-02 15:00:59',
        'Comentario 2 al Post de Pamela'
    ),
    (
        5,
        '2022-06-16 16:59:59',
        'Comentario 1 al Post de Carlos'
    ),
    (
        5,
        '2022-06-16 16:59:59',
        'Comentario 2 al Post de Carlos'
    ),
    (
        5,
        '2022-06-16 16:59:59',
        'Comentario 3 al Post de Carlos'
    ),
    (
        5,
        '2022-06-16 16:59:59',
        'Comentario 4 al Post de Carlos'
    );

-- 3. Crear un nuevo post para "Margarita".

INSERT INTO
    posts (
        nombre_de_usuario,
        fecha_de_creacion,
        contenido,
        descripcion,
        titulo
    )
VALUES
    (
        'Margarita',
        '18/06/2022',
        'Este es un nuevo post de Margarita',
        'Solo es un post',
        'Titulo Post 6'
    );

-- 4. Ingresar 5 comentarios para el post de Margarita.

INSERT INTO
    comentarios (id_post, fechayhora, contenido)
VALUES
    (
        6,
        '2022-06-18 22:59:59',
        'Comentario 1 al Post de Margarita'
    ),
    (
        6,
        '2022-06-19 15:00:59',
        'Comentario 2 al Post de Margarita'
    ),
    (
        6,
        '2022-06-19 18:59:59',
        'Comentario 3 al Post de Margarita'
    ),
    (
        6,
        '2022-06-20 19:59:59',
        'Comentario 4 al Post de Margarita'
    ),
    (
        6,
        '2022-06-20 20:15:59',
        'Comentario 5 al Post de Margarita'
    );