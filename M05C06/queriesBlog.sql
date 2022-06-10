-- Seleccionar el correo, id y título de todos los post publicados por el usuario 5

SELECT
    usuario.email as correo_usuario,
    post.ID as post_id,
    post.titulo as titulo_post
FROM
    post
    JOIN usuario ON post.usuario_id = usuario.ID
WHERE
    usuario.ID = 5;

-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.

SELECT
    u.email,
    coment.ID as id_comentario,
    coment.texto contenido_comentario
FROM
    comentario coment
    JOIN usuario u ON coment.usuario_id = u.ID
WHERE
    u.email <> 'usuario06@hotmail.com';

-- Listar los usuarios que no han publicado ningún post.

SELECT
    email AS usuarios_sin_post
FROM
    usuario
    LEFT JOIN post ON usuario.ID = post.usuario_id
WHERE
    post.usuario_id IS NULL;

-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).

--Opción 1: Mostrar post y comentarios.

SELECT
    post.ID,
    post.titulo,
    post.usuario_id,
    CASE
        WHEN comentario.texto IS NULL THEN 'Sin Comentarios'
        ELSE comentario.texto
    END AS comentarios
FROM
    post
    LEFT JOIN comentario ON post.ID = comentario.post_id
ORDER BY
    post.ID ASC;

-- Opción 2: Mostrar post y cantidad de comentarios.

SELECT
    post.ID,
    post.titulo,
    post.usuario_id,
    COUNT (comentario.texto) AS cant_comentarios
FROM
    post
    LEFT JOIN comentario ON post.ID = comentario.post_id
GROUP BY
    post.ID
ORDER BY
    post.ID ASC;

-- Listar todos los usuarios que hayan publicado un post en Junio.

SELECT
    email
FROM
    usuario
    JOIN post ON usuario.ID = post.usuario_id
WHERE
    to_char(fecha, 'MM') = '06';