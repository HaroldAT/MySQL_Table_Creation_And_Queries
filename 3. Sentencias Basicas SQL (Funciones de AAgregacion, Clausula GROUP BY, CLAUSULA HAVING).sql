-- *Funciones de Agregado* --

-- Funcion SUM(): Sum va a sumar todo lo que pongamos dentro del parentesis y a mostrarno dicha suma como resultado del query

SELECT SUM(duracion) 
FROM episodios;

-- Tambien podemos usar AS para dar un alias, por ejemplo

SELECT SUM(duracion) AS duracion_total
FROM episodios;

-- Funcion MIN(): Este nos dara el valor minimo de lo que coloquemos dentro de los prentesis

SELECT MIN(duracion)
FROM episodios;

-- Funcion MAX(): Este nos dara el valor maximo de lo que coloquemos dentro de los prentesis
SELECT MAX(duracion)
FROM episodios;

-- Funcion COUNT(): Esta cuenta la cantidad de elemntos que hay en un campo
-- En este ejemplo cuenta la cantidad total de filas que en nuestra tabla
SELECT COUNT(*) 
FROM episodios;

SELECT COUNT(*) 
FROM episodios
WHERE serie_id > 5;

-- Funcion AVG(): Este nos brinda el valor promedio del campo que coloquemos entre parentesis

SELECT AVG(duracion) 
FROM episodios
WHERE serie_id = 2;

SELECT AVG(duracion) AS promedio
FROM episodios;

-- ------------------------------------------------------------
-- *CLAUSULA GROUP BY* -- 

SELECT serie_id, AVG(duracion) AS promedio_duracion
FROM episodios
WHERE serie_id IN (1,2)
GROUP BY serie_id;

SELECT serie_id, COUNT(episodio_id) AS Cantidad_Episodios
FROM episodios
GROUP BY serie_id;

SELECT serie_id ,AVG(duracion) AS promedio FROM episodios
WHERE serie_id IN (1,2,3)
GROUP BY serie_id;
-- ----------------------------------------------------------------------------
SELECT serie_id, COUNT(episodio_id) AS numero_episodios
FROM episodios
GROUP BY serie_id
HAVING COUNT(episodio_id) > 10;

SELECT serie_id, COUNT(duracion) AS capitulos_Duracion_mayor_a_1
FROM episodios
GROUP BY serie_id
HAVING COUNT(duracion) >11;
-- ------------------------------------------------------------------------------