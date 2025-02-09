-- *COMANDOS DDL, CONSTRAINT, TIPOS DE DATOS* -- 

-- CREATE: Define nuevos objetos como tablas.
-- ALTER: Modifica estructuras existentes en la base.
-- DROP: Elimina objetos de la base permanentemente.
-- TRUNCATE: Vacía una tabla sin eliminarla.
-- RENAME: Cambia el nombre de un objeto.

-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS EmpresaDB;

-- Recordad que luego de crear una base de datos si vamos a trabajar con ella misma o insertar tablas etc. Es importante usar lo siguiente

    USE EmpresaDB;

-- Indicando asi que vamos a estar trabajando con esta tabla, puesto que SQL no asume estaremos trabajando con dicha base de datos

-- CONSTRAINT
-- Constraints en SQL: Reglas que limitan el tipo de datos en tablas para mantener integridad.

-- Tipos de datos en SQL: Enteros, cadenas, fechas, decimales, booleanos, entre otros.

-- Primary Key: Identificador único de cada fila en una tabla, no se repite.

-- Foreign Key: Referencia a una primary key en otra tabla para relación.

-- NOT NULL: Restricción que asegura que una columna no tenga valores nulos.

-- UNIQUE: Garantiza que todos los valores en una columna sean distintos.

-- AUTOINCREMENT: Incrementa automáticamente el valor de una columna al insertar datos.

-- TIPOS DE DATOS

-- INT: Tipo de dato para números enteros, con o sin signo, de longitud fija.

-- VARCHAR: Almacena cadenas de longitud variable, con un máximo definido entre paréntesis.

-- CHAR: Almacena cadenas de longitud fija, rellenando con espacios si es necesario.

-- TEXT: Almacena cadenas de texto largas, sin límite de longitud predefinido.

-- DATE: Almacena fechas en formato 'YYYY-MM-DD', sin incluir hora.

-- DATETIME: Almacena fecha y hora en formato 'YYYY-MM-DD HH:MM:SS '.

-- TIMESTAMP: Similar a DATETIME, pero con ajuste automático según zona horaria.

-- FLOAT: Almacena números decimales de precisión simple, con punto flotante.

-- DOUBLE: Almacena números decimales de precisión doble, con mayor rango que FLOAT.

-- DECIMAL: Almacena números decimales exactos, con precisión y escala definidas.

-- BOOLEAN: Almacena valores booleanos, representados como 0 (falso) o 1 (verdadero).

-- Creación de la tabla Departamentos
CREATE TABLE IF NOT EXISTS Departamentos (
    depto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    ubicacion VARCHAR(255)
);

-- Creación de la tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    depto_id INT,
    FOREIGN KEY (depto_id) REFERENCES Departamentos(depto_id)
    ON DELETE SET NULL
);

-- Creación de la tabla Proyectos
CREATE TABLE IF NOT EXISTS Proyectos (
    proyecto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE
);

-- Creación de la tabla AsignacionesDeProyectos
CREATE TABLE IF NOT EXISTS AsignacionesDeProyectos (
    asignacion_id INT AUTO_INCREMENT PRIMARY KEY,
    proyecto_id INT,
    empleado_id INT,
    horas_asignadas INT NOT NULL,
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(proyecto_id),
    FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)
);

-- Creación de la tabla LogEmpelados
CREATE TABLE IF NOT EXISTS LogEmpleados (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    fecha_registro DATETIME,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)
);

-- Ejmeplo comando ALTER

ALTER TABLE Departamentos ADD COLUMN email_jefe VARCHAR(255);

-- Ejemplo comando DROP 

DROP TABLE asignacionesdeproyectos;

-- Ejemplo comando RENAME 

RENAME TABLE logempleados TO log;

RENAME TABLE log TO logempleados;

-- Ejemplo TRUNCATE

-- Las tablas aun no tienen datos pero ya sabemos que DROP elimina la tabla en su totalidad mientras que 
-- TRUNCATE solo elimina los datos de la tabla en caso de tener pero mantiene la estructura de la tabla
-- Es decir las columnas, tipos de datos y CONSTRAINTS

-- Aqui aun no hay datos pero de haberlos solo eliminaria lo ya mencionado mas no la tabla
TRUNCATE TABLE proyectos;
