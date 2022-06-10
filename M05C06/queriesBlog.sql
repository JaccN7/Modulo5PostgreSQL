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

-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).

-- Listar todos los usuarios que hayan publicado un post en Junio.