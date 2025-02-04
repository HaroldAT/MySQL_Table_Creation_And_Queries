-- *CTEs* COMMON TABLE EXPRESSIONS -- 

-- LAS CTES LAS PODEMOS DDEFINIR COMO CONSULTAS TEMPORALES QUE SE USSN DENTRO DE UNA CONSULTA SQL
-- O MAS BIEN COMO TABLAS TEMPORALES
-- EJEMPLO 1

WITH 
ListaEpisodios AS (
SELECT serie_id, episodio_id, titulo
FROM episodios
)

SELECT * 
FROM ListaEpisodios
ORDER BY 3 DESC;

-- EJEMPLO 2

-- CON ESTAS PODEMOS HACER USO DE JOINS Y CREAR MAS DE UNA CTE SIEMPRE Y CUANDO VAYAMOS A UTILIZARLA
WITH 
ListaEpisodios AS (
SELECT serie_id, episodio_id, titulo
FROM episodios
),
ListaSeries AS (
SELECT serie_id, descripcion
FROM series
)

SELECT * 
FROM ListaEpisodios
LEFT JOIN ListaSeries
ON ListaEpisodios.serie_id = ListaSeries.serie_id;

-- EJEMPLO 3

WITH PrimerEpisodio AS (
  SELECT serie_id, MIN(fecha_estreno) AS fecha_primer_episodio
  FROM Episodios
  GROUP BY serie_id
)
 
SELECT s.titulo AS 'Título de la Serie', pe.fecha_primer_episodio AS 'Fecha del Primer Episodio'
FROM Series s
JOIN PrimerEpisodio pe ON s.serie_id = pe.serie_id
ORDER BY pe.fecha_primer_episodio ASC;

-- EJEMPLO 4
WITH SeriesPorAño AS (
  SELECT 
    año_lanzamiento,
    COUNT(*) AS total_series
  FROM Series
  WHERE genero = 'Ciencia ficción'
  GROUP BY año_lanzamiento
)
 
SELECT * FROM SeriesPorAño
ORDER BY año_lanzamiento;

-- *FUNCIONES DE VENTANA* --

-- *ROW_NUMBER()* --

-- EJEMPLO 1

-- EN LOS PARENTESIS DEL OVER INDICAMOS EN BASE A QUE DAREMOS EL ORDEN, SIRVE PARA ASIGNARLE UN ORDEN A NUESTRAS FILAS
SELECT titulo, año_lanzamiento,
ROW_NUMBER() OVER(ORDER BY año_lanzamiento DESC) AS Orden_Lanzamiento
FROM series;

-- EJEMPLO 2

WITH OrdenSeries AS(
SELECT titulo, año_lanzamiento,
ROW_NUMBER() OVER(ORDER BY año_lanzamiento DESC) AS Orden_Lanzamiento
FROM series)

SELECT *
FROM OrdenSeries
WHERE Orden_Lanzamiento >=1 && Orden_Lanzamiento <=3;

-- OTRA MANERA DE HACERLO ES CON IN

WITH OrdenSeries AS(
SELECT titulo, año_lanzamiento,
ROW_NUMBER() OVER(ORDER BY año_lanzamiento DESC) AS Orden_Lanzamiento
FROM series)

SELECT *
FROM OrdenSeries
WHERE Orden_Lanzamiento IN (1,2,3);

-- EJEMPLO 3

SELECT titulo, año_lanzamiento,
ROW_NUMBER() OVER (ORDER BY año_lanzamiento DESC) AS clasificacion_global
FROM series;

-- *PARTITION BY*

-- ESTE POR SINTAXIS VA DENTRO DEL OVER

SELECT titulo, genero, año_lanzamiento,
 ROW_NUMBER()OVER (PARTITION BY genero ORDER BY año_lanzamiento) AS ranking_por_genero
FROM series;

-- EJEMPLO 2
SELECT temporada, titulo, fecha_estreno,
 ROW_NUMBER()OVER (PARTITION BY temporada ORDER BY fecha_estreno) AS ranking_temporada
FROM episodios;

-- EJEMPLO 3

SELECT temporada, titulo, rating_imdb,
  ROW_NUMBER() OVER (PARTITION BY temporada ORDER BY rating_imdb DESC) AS 'Ranking IMDb'
FROM Episodios
WHERE serie_id = 2 ORDER BY temporada, `Ranking IMDb`;

-- *RANK* --
-- CON ESTE NO TENEMOS SECUENCIA CONTINUA
-- RANK() asigna un número de clasificación dentro de un conjunto de resultados, pero no es continuo, ya que salta valores en caso de empates.

-- EJEMPLO 1
SELECT titulo, rating_imdb,
	RANK() OVER(ORDER BY rating_imdb DESC) AS ranking_imdb
FROM episodios;

-- EJEMPLO 2
SELECT titulo, rating_imdb,
  RANK() OVER (ORDER BY rating_imdb DESC) AS ranking_imdb
FROM Episodios
ORDER BY ranking_imdb;

-- *DENSE_RANK()* --

-- DENSE_RANK() asigna un número de clasificación sin saltos, incluso si hay empates.

-- EJEMPLO 1

SELECT titulo, rating_imdb,
	DENSE_RANK() OVER(ORDER BY rating_imdb DESC) AS ranking_imdb
FROM episodios;

-- EJEMPLO 2
SELECT titulo, rating_imdb,
  DENSE_RANK() OVER (ORDER BY rating_imdb DESC) AS ranking_imdb
FROM Episodios
ORDER BY ranking_imdb;

-- *REGEXP* --

-- EXPRESIONES REGULARES: Son patrones para buscar, validar o manipular textos eficientemente.


-- EJEMPLO 1

-- '(?i)más' significa que estás usando una expresión regular en MySQL para buscar la palabra "más" dentro de la columna descripcion
-- A diferencia de LIKE este permite hacer busquedas avanzadas y con la secuencua es decir '(?i)' permite buscar mayusculas, minusculas o combinacion de ambas
SELECT titulo, descripcion
FROM series
WHERE descripcion REGEXP '(?i)más';

-- EJEMPLO 2

SELECT titulo, descripcion
FROM series
WHERE descripcion REGEXP '(?i)MisteRIOs';

-- * EJERCICIO FINAL* --

WITH EpisodiosRecientes AS (
  SELECT 
    serie_id,
    COUNT(episodio_id) AS num_episodios
  FROM Episodios
  GROUP BY serie_id
),
Calificaciones AS (
  SELECT 
    serie_id,
    AVG(rating_imdb) AS promedio_imdb
  FROM Episodios
  GROUP BY serie_id
)

SELECT 
  s.titulo,
  er.num_episodios,
  c.promedio_imdb
FROM Series s
JOIN EpisodiosRecientes er ON s.serie_id = er.serie_id
JOIN Calificaciones c ON s.serie_id = c.serie_id
ORDER BY c.promedio_imdb DESC, er.num_episodios DESC;