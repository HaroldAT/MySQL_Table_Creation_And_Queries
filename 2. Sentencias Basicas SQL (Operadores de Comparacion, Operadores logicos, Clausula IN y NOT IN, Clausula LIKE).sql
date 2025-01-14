-- *Operadores de Comparación* --
-- AND O &&, NOT, OR
-- *AND o && *En este caso estamos seleccionando todos los campos de la tabla series donde su año de lanzamiento sea mayor a 2015 y menor a 2018
SELECT * 
FROM series 
WHERE año_lanzamiento > 2015 && año_lanzamiento <2018;

-- *OR* En este ejemplo usamos el operador OR para indicar que puede ser tanto un genero como otro, es decir la condicion es uno u otro
SELECT * FROM series
WHERE (genero = 'Comedia' OR genero = 'Animación');

--  *NOT*  Este es la negacion, se usa con WHERE para incluir solo las filas donde una condicion no es verdadera
-- Aqui selecionamos todos lso campos donde el genero no sea comedia
SELECT * 
FROM series
WHERE NOT genero = 'Comedia';

-- ---------------------------------------------------------------------
 -- *Operadores de comparacion* (<>, >=, <=, <, >)
-- Los operadores de comparacion se utilizan para comparar los valores en una consulta
-- *<>* Este se conoce como diferente de y tambien puede ser utilzado como el NOT, explicare el mismo ejemplo anterior

SELECT * FROM series
WHERE genero <> 'Comedia';

-- <, >, >= , <= Estos serian mayor que, menor que, mayor o igual que, menor o igual que y como indican condicionan wl WHERE ssegun la condición dada

-- Ejemplos
SELECT *
FROM series
WHERE año_lanzamiento < 2014;

SELECT *
FROM series
WHERE año_lanzamiento <= 2014;

SELECT *
FROM series
WHERE año_lanzamiento > 2008;

SELECT *
FROM series
WHERE año_lanzamiento >= 2008;
-- ---------------------------------------------------------------------
-- *Clausula IN / NOT IN

-- Aqui estamos haciendo uso del IN dodne dentro de los parentesis y dentro de comillas simples le decimos que traiga las filas donde el genero sea comedia
SELECT * 
FROM Series
WHERE genero IN ('Comedia');

-- En este otro ejemplo le indicamos que por favor NO nos traiga las filas donde el genero sea comedia y drama
SELECT * 
FROM series
WHERE genero NOT IN ('Comedia', 'Drama');

-- --------------------------------------------------------------------------------
-- *Clausula LIKE*
-- La cláusula LIKE  en SQL se utiliza para buscar patrones específicos en columnas de texto mediante caracteres comodín.

-- A traves de esta consulta buscamos en la tabla series todas las filas que contengan la palabra "The" en su titulo
SELECT * 
FROM series
WHERE titulo LIKE '%The%';

-- Colocando el signo de porcentaje solo al final lo que porovocamos es que solo nos traiga las filas donde la palabra "The" este al principio
SELECT * 
FROM Series
WHERE titulo LIKE 'The%';

-- Por otra parte si colocamos el signo de procentaje al principio este buscara la palabra "The" solo al final
SELECT * 
FROM Series
WHERE titulo LIKE 'The%';

-- Haciendo incapie en el NOT, podemos hacer uso de este de la siguiente forma, de manera que traera titulos donde la palabra "The" no este
SELECT *
FROM series
WHERE titulo NOT LIKE '%The%';
-- --------------------------------------------------------------------------------
