-- *Sentencia SELECT* --

-- Importante destacar que con el FROM hacemos alusión acerca de la tabla donde vamos a obtener los campos.

-- Con * seleccionamos todos los campos de la tabla episodios
SELECT * 
FROM episodios;

-- Aqui seleccionamos especificamente un campo de dicha tabla
SELECT 
    titulo
FROM
    episodios;

-- Aqui estamos seleccionando 3 campos de la tabla episodios, separando por una "," cada campo nuevo a seleccionar
SELECT episodio_id, titulo, duracion
FROM episodios;
-- --------------------------------------------------------------------------------------------------

-- *Clsausula DISTINCT* --

-- La clausula DISTICNT solo trae valores unicos es decir que si consulto la tabla series y le pido que me muestre el campo genero este traera consigo todos los generos aun si estan repetidos, con DISTINCT solo me trae valores unicos
SELECT DISTINCT genero
FROM series;

SELECT DISTINCT año_lanzamiento
FROM series;

SELECT DISTINCT fecha_nacimiento
FROM actores;

-- --------------------------------------------------------------------------------------------------

-- *Clausula ORDER BY * --

-- Esta clausula sirve apra organizar los datos obtenidos de la consulta de la forma que deseemos

-- Por ejemplo aqui estara organizado partiendo del campo duracion y por default lo organiza de forma ascendente
SELECT titulo, duracion 
FROM episodios 
ORDER BY duracion;

-- Pese a que por default viene de forma ascendente podemos indicarle especificamente ASC apra que sea ascendente
SELECT titulo, duracion 
FROM episodios 
ORDER BY duracion ASC;

-- Por ejemplo aqui esta organizado de forma descendente indicandole con DESC como vemos en el ejemplo.
SELECT titulo, duracion 
FROM episodios 
ORDER BY duracion DESC;

-- Por otra parte tal como si fuera cadena de tecto podemos indicarle con su pocision a traves de cual campo sera organizado
-- Aqui sera organizado de forma descendente a aprtir del segundo campo del SELECT que seria duracion indicado por el numero 2 luego del ORDER BY
SELECT titulo, duracion 
FROM episodios 
ORDER BY 2 DESC;

-- --------------------------------------------------------------------------------------------------
-- *Clausula LIMIT* --

-- Esta clausula va a limitar los datos resultados del Query dependiendo del numero al lado de la Clausula LIMIT 
SELECT * 
FROM episodios 
LIMIT 10;

SELECT titulo, duracion 
FROM episodios 
ORDER BY 1 DESC 
LIMIT 10;

SELECT *
FROM actores
LIMIT 5;

-- * Clausula Where* --

--  Con esta clausula podemos condicionar que los resultados obtenidos solo sean de un lugar especifico
-- Es decir condicionamos el resultado a lo coloado despues del WHERE. Ejemplos.

-- Por ejemplo aqui pedimos que solo los campos donde su año de lanzamiento sea mayor al 2010.
SELECT * 
FROM series 
WHERE año_lanzamiento > 2010;

-- En este caso estamos llamando estos 4 campos donde serie_id sea mayor a 8
SELECT serie_id, titulo, descripcion, genero
FROM series
WHERE serie_id > 8;

-- Aqui llamamos todos los campos de la tabla series donde el genero sea igual a Comedia, el cual encerramos entre comillas simples.
SELECT * 
FROM Series 
WHERE genero = 'Comedia';
-- ---------------------------------------------------------------------------
