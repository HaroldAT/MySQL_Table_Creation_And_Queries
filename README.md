# Normalización en SQL: 1NF, 2NF y 3NF

La normalización es un proceso para organizar datos en una base de datos, reducir redundancia y mejorar la integridad de los datos. Aquí está un resumen de las tres primeras formas normales:

## 1. Primera Forma Normal (1NF)
- Elimina valores repetidos y asegura que cada columna tenga valores atómicos.

## 2. Segunda Forma Normal (2NF)
- Elimina dependencias parciales dividiendo tablas para que todos los atributos no clave dependan completamente de la clave primaria.

## 3. Tercera Forma Normal (3NF)
- Elimina dependencias transitivas asegurando que los atributos no clave dependan solo de la clave primaria.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Primera Forma Normal (1NF)
Definición: Una tabla está en 1NF si:

Cada columna contiene valores atómicos (indivisibles).

Cada columna contiene valores del mismo tipo.

Cada fila es única (sin duplicados).

El orden de las filas y columnas no importa.

Ejemplo:

Antes de 1NF:

| StudentID | Nombre     | Cursos                 |
|-----------|------------|------------------------|
| 1         | Juan Pérez | Matemáticas, Ciencias  |
| 2         | Ana López  | Historia, Inglés, Arte |
Después de 1NF:

| StudentID | Nombre     | Curso        |
|-----------|------------|--------------|
| 1         | Juan Pérez | Matemáticas  |
| 1         | Juan Pérez | Ciencias     |
| 2         | Ana López  | Historia     |
| 2         | Ana López  | Inglés       |
| 2         | Ana López  | Arte         |


2. Segunda Forma Normal (2NF)
Definición: Una tabla está en 2NF si:

Ya está en 1NF.

Todos los atributos no clave dependen completamente de la clave primaria (sin dependencias parciales).

Ejemplo:

Antes de 2NF:


| OrderID | ProductID | ProductName | Cantidad |
|---------|-----------|-------------|----------|
| 1       | 101       | Laptop      | 2        |
| 1       | 102       | Mouse       | 5        |
| 2       | 101       | Laptop      | 1        |
Después de 2NF:


| OrderID | ProductID | Cantidad |
|---------|-----------|----------|
| 1       | 101       | 2        |
| 1       | 102       | 5        |
| 2       | 101       | 1        |

| ProductID | ProductName |
|-----------|-------------|
| 101       | Laptop      |
| 102       | Mouse       |

3. Tercera Forma Normal (3NF)
Definición: Una tabla está en 3NF si:

Ya está en 2NF.

No hay dependencias transitivas (los atributos no clave dependen solo de la clave primaria, no de otros atributos no clave).

Ejemplo:

Antes de 3NF:

| StudentID | Nombre     | Departamento | JefeDepartamento |
|-----------|------------|--------------|------------------|
| 1         | Juan Pérez | CS           | Dr. Smith        |
| 2         | Ana López  | Matemáticas  | Dr. Brown        |
Después de 3NF:

| StudentID | Nombre     | Departamento |
|-----------|------------|--------------|
| 1         | Juan Pérez | CS           |
| 2         | Ana López  | Matemáticas  |

| Departamento | JefeDepartamento |
|--------------|------------------|
| CS           | Dr. Smith        |
| Matemáticas  | Dr. Brown        |
