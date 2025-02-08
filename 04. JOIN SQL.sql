-- *JOINS* --

-- *INNER JOIN O JOIN * --

-- Ejemplo 1
SELECT *
FROM series
INNER JOIN actuaciones
ON series.serie_id = actuaciones.serie_id;

-- Ejemplo 2
SELECT * 
FROM actores as a
JOIN actuaciones as ac
ON a.actor_id = ac.actor_id
WHERE ac.personaje like '%er';

-- Ejemplo 3
SELECT titulo, personaje
FROM series
INNER JOIN actuaciones
ON series.serie_id = actuaciones.serie_id;

-- *LEFT JOIN o LEFT OUTER JOIN* --

-- Ejemplo 1
SELECT 
	series.titulo AS 'Titulo de la serie',
	episodios.titulo AS 'Titulo de Episodio'
FROM series
LEFT JOIN episodios
ON series.serie_id = episodios.serie_id
ORDER BY series.titulo ASC;

-- Ejemplo 2
SELECT s.titulo AS 'Titulo de la Serie',
    e.titulo AS 'Titulo del Episodio',
    e.rating_imdb AS 'Rating IMDB'
FROM series AS s
LEFT OUTER JOIN episodios AS e
ON s.serie_id = e.serie_id
ORDER BY s.titulo ASC
LIMIT 15;

-- Ejemplo 3
SELECT
    series.titulo AS 'Título de la Serie',
    episodios.titulo AS 'Título del Episodio',
    episodios.rating_imdb AS 'Rating IMDB'
FROM series
LEFT JOIN episodios 
ON series.serie_id = episodios.serie_id
WHERE series.titulo = 'Stranger Things'
ORDER BY episodios.rating_imdb DESC;

-- *RIGHT JOIN o RIGHT OUTER JOIN* --

-- Ejemplo 1
SELECT
	s.titulo AS 'Titulo de la serie',
    e.titulo AS 'Titulo del episodio'
    FROM episodios AS e
	RIGHT JOIN series AS s
    ON e.serie_id = s.serie_id
    ORDER BY s.titulo;

-- Ejemplo 2
SELECT 
    series.titulo AS 'Título de la Serie',
    episodios.titulo AS 'Título del Episodio',
    episodios.duracion AS 'Duración'
FROM episodios
RIGHT JOIN series ON episodios.serie_id = series.serie_id
WHERE episodios.duracion > 30
ORDER BY series.titulo;

-- *UNION ALL* --

-- Ejemplo 
SELECT *
FROM series
WHERE genero = 'Ciencia ficcion'

UNION ALL

SELECT *
FROM series
WHERE genero = 'Drama'

UNION ALL

SELECT *
FROM series
WHERE genero = 'Comedia';

-- UNION ALL arroja valores duplicados y los agrega al resultado de la QEURY

-- Ejemplo 2
SELECT *
FROM series
WHERE genero = 'Ciencia ficcion'

UNION ALL

SELECT *
FROM series
WHERE genero = 'Drama'

UNION ALL

SELECT *
FROM series
WHERE genero = 'Drama';

-- ---------------------------------------
-- *UNION* --

-- A diferencia de UNION ALL que daba valores duplicados UNION solo arroja valores unicos

-- Ejemplo 1
SELECT *
FROM series
WHERE genero = 'Ciencia ficcion'

UNION 

SELECT *
FROM series
WHERE genero = 'Drama'

UNION 

SELECT *
FROM series
WHERE genero = 'Drama';

-- En el apartado del SELECT todas deben coincidir es decir si estoy haciendo llamado 
-- al campo titulo y genero debo hacer lo mismo en todas los query que voy a utilizar para el UNION

-- Ejemplo 2
SELECT titulo, genero
FROM series
WHERE genero = 'Ciencia ficcion'

UNION 

SELECT titulo, genero
FROM series
WHERE genero = 'Drama';

-- Ejemplo 3
SELECT titulo
FROM episodios
WHERE duracion > 20

UNION

SELECT titulo
FROM episodios
WHERE rating_imdb > 9;
