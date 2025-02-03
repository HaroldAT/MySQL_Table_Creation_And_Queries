-- *SubConsultas o Subquery* --

-- Ejemplo 1
SELECT *
FROM episodios
WHERE serie_id = (SELECT serie_id
				  FROM series
                  WHERE titulo = 'The office');

-- Ejemplo 2
SELECT titulo
FROM series
WHERE serie_id IN (SELECT serie_id
				  FROM episodios
                  WHERE rating_imdb > 8);
                  
-- Ejemplo 3
SELECT *
FROM actuaciones
WHERE actor_id = (SELECT actor_id
				   FROM actores
                   WHERE nombre = 'Bryan Cranston');
                   
-- *IF* --

-- Ejemplo 1
SELECT titulo, rating_imdb,
IF(rating_imdb >= 8, 'Rating Alto', 'Rating bajo') AS 'Categoria de Rating'
FROM episodios
ORDER BY rating_imdb DESC;        

-- Ejemplo 2
SELECT nombre, YEAR(fecha_nacimiento) AS 'Año de Nacimiento',
IF (YEAR(fecha_nacimiento) > 2000, 'Adulto Joven', 'Adulto') AS 'Categoria de Actores'
FROM actores;

-- Ejemplo 3
SELECT *,
IF (año_lanzamiento >= 2020, 'Recientes', 'Antiguas') AS 'Categoria de serie'
FROM series;

-- *CASE* -- 

-- Ejemplo 1

SELECT titulo, año_lanzamiento,
CASE
	WHEN año_lanzamiento >= 2020 THEN 'Nueva'
    WHEN año_lanzamiento BETWEEN 2010 AND 2019 THEN 'Clasica'
    ELSE 'Antigua'
    END AS 'Categoria'
FROM series;

-- Ejemplo 2

SELECT titulo,
CASE 
    WHEN año_lanzamiento < 2010 THEN 'Antigua'
    WHEN año_lanzamiento >= 2010 THEN 'Reciente'
    END AS 'Antigüedad'
FROM series;

-- Otra manera del ejemplo 2

SELECT titulo,
CASE 
    WHEN año_lanzamiento < 2010 THEN 'Antigua'
    ELSE 'Reciente'
    END AS 'Antigüedad'
FROM series;

-- Ejemplo 3

SELECT titulo,
CASE 
    WHEN genero = 'Drama' THEN 'Dramatico'
    WHEN genero = 'Comedia' THEN 'Divertido'
    ELSE 'Otro'
    END AS 'Categoría de Género'
FROM series;

-- *CAST* --

-- Ejemplo 1
SELECT *
FROM episodios
WHERE CAST(fecha_estreno AS DATE) > '2010-01-01';

-- Ejemplo 2

SELECT titulo, 
       CAST(año_lanzamiento AS CHAR) AS 'Año de Lanzamiento'
FROM series;

-- *Funciones de Fecha* --

-- Ejemplo 1

SELECT fecha_estreno 
FROM episodios;

-- EN ESTE EJEMPLO SOLO TOMO EL AÑO CON UNA FUNCION TIPO DATE
SELECT fecha_estreno, YEAR(fecha_estreno) AS 'Año Estreno', MONTH(fecha_estreno) AS 'Mes Estreno'
FROM episodios;

SELECT fecha_estreno, DAY(fecha_estreno) AS 'Dia Estreno'
FROM episodios;

-- Ejemplo 2
SELECT fecha_estreno, 
DATE_ADD(fecha_estreno, INTERVAL 30 DAY)  AS '30 Dias Luego del Estreno'
FROM episodios;

SELECT fecha_estreno, 
DATE_ADD(fecha_estreno, INTERVAL -30 DAY)  AS '30 Dias Antes del Estreno'
FROM episodios;

SELECT fecha_estreno,
DATE_ADD(fecha_estreno, INTERVAL 2 MONTH) AS '2 Meses Luego del Estreno'
FROM episodios;

SELECT fecha_estreno,
DATE_ADD(fecha_estreno, INTERVAL -2 MONTH) AS '2 Meses Antes del Estreno'
FROM episodios;

-- Ejemplo 3
-- CURDATE() = CURRENT DATE

-- DATEDIFF(fecha1, fecha2) y luego resta fecha1 - fecha2.
-- Entonces seria aqui fecha actual menos fecha estreno

SELECT *,
DATEDIFF(CURDATE(), fecha_estreno) AS 'Dias Transcurridos Desde el Estreno a Dia de Hoy'
FROM episodios;

-- MISMO EJEMPLO PERO USANDO LA FUNCION CONCAT PARA CONCATENAS LA PALABRA 'Dias' A LOS DIAS TRANSCURRIDOS DESDE EL ESTRENO

SELECT serie_id, titulo, fecha_estreno,
CONCAT(DATEDIFF(CURDATE(), fecha_estreno), ' Dias') AS 'Dias Transcurridos Desde el Estreno a Dia de Hoy'
FROM episodios;

-- *Manipulación de Cadenas de Textos* --

-- Ejemplo 1 *UPPER*

SELECT UPPER(titulo) AS 'Titulo en Mayusculas'
FROM series;

-- Ejemplo 2 *LOWER*
SELECT LOWER(nombre) AS 'Nombre en Minusculas'
FROM actores;

-- Ejemplo 3 *CONCAT*

SELECT CONCAT(titulo, ' (', año_lanzamiento, ')') AS titulo_año 
FROM series;

-- Ejemplo 4 *SUBSTRING*

-- CON ESTE SELECCIONAMOS LOS PRIMEROS 5 CARACTERES EL 1 INDICA DESDE DONNE INICIA Y EL 5 DONDE TERMINA
SELECT titulo, SUBSTRING(titulo, 1, 5) AS Extracto_Titulo
FROM episodios;

SELECT titulo, SUBSTRING(titulo, 2, 4) AS Extracto_Titulo
FROM episodios;

-- Ejemplo 5 *LENGHT*

-- ESTA DEVUELVE EL NUMERO DE CARACTERES 	
SELECT titulo, LENGTH (titulo) AS Longitud_Titulo
FROM series;

-- Ejemplo 6 *LEFT* *RIGHT*

-- DESDE LA IZQUIERDA QUE ME DE LOS PRIMEROS CARACTERES
-- DESDE LA DERECHA QUE ME DE LOS PRIMEROS CARACTERES

SELECT titulo,
	LEFT(titulo, 3) AS Inicio_Titulo,
    RIGHT(titulo, 3) AS Final_Titulo
FROM series;

-- *FUNCIONES MATEMATICAS* --

-- Ejemplo 1 *ROUND* 

-- ROUND() redondea un número a la cantidad especificada de decimales.
SELECT titulo, duracion/60.0 AS Horas_Completas,
ROUND(duracion/60.0, 0) AS Horas_Completas_Redondeado
FROM episodios;

-- Ejemplo 2 *CEILING*

--  CEILING() redondea un número al entero superior más cercano.
SELECT titulo, duracion,
CEILING (duracion/60.0) AS Horas_Completas
FROM episodios;

-- Ejemplo 3 *FLOOR*

-- FLOOR() redondea un numero entero al anterior más cercano
SELECT titulo, duracion,
FLOOR (duracion/60.0) AS Horas_Completas
FROM episodios;

-- EJERCICIO FINAL

SELECT 
    Series.titulo AS 'Título de la Serie', 
    Series.año_lanzamiento AS 'Año de Lanzamiento', 
    Series.genero AS 'Género', 
    AVG(Episodios.rating_imdb) AS 'Rating Promedio IMDb'
FROM 
    Series
JOIN 
    Episodios ON Series.serie_id = Episodios.serie_id
WHERE 
    Series.genero IN (SELECT genero FROM (
					  SELECT genero, COUNT(*) AS cantidad_de_series
					  FROM Series 
					  GROUP BY genero 
                      ORDER BY cantidad_de_series DESC
                      LIMIT 3) AS top3)
GROUP BY 
    Series.serie_id
ORDER BY 
    'Rating Promedio IMDb' DESC;