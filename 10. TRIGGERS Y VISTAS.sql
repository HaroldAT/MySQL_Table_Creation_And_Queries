-- *VISTAS Y TRIGGERS* --

-- VISTAS

-- Crea una vista llamada VistaEmpleadosTecnologia que almacena una consulta predefinida en MySQL.
-- Selecciona el nombre, apellido y email de los empleados filtrando por depto_id = 1.
-- La vista permite consultar empleados del departamento 1 sin escribir repetidamente la consulta.

CREATE VIEW VistaEmpleadosTecnologia AS
SELECT nombre, apellido, email
FROM empleados
WHERE depto_id = 1;

-- Aqui pordemos consultar la vista que hemos creado

SELECT *
FROM VistaEmpleadosTecnologia;


-- *TRIGGERS* --

-- Un TRIGGER O DISPARADOR son acciones automáticas que se ejecutan tras un evento en una tabla.


-- Cambia el delimitador para permitir definir el trigger sin conflictos con el punto y coma.
-- Crea un trigger llamado RegistrarNuevoEmpleado que se ejecuta después de insertar en empleados.
-- Por cada nueva fila insertada, se activa el código dentro del bloque BEGIN ... END.
-- Inserta en LogEmpleados el empleado_id recién agregado junto con la fecha y hora actuales.
-- Finaliza el trigger correctamente y restablece el delimitador original para futuras consultas.

-- EL DELIMITADOR DEBE SER $$

DELIMITER $$

CREATE TRIGGER RegistrarNuevoEmpleado
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN 
	INSERT INTO logempleados (empleado_id, fecha_registro) VALUES (NEW.empleado_id, NOW()); 
END $$

DELIMITER ;

-- NEW.empleado_id representa el valor de la columna empleado_id de la nueva fila insertada en la tabla empleados.
-- NOW() devuelve la fecha y hora actual del sistema en formato YYYY-MM-DD HH:MM:SS.

-- PODEMOS USAR ESTO PARA VALIDAR EL TRIGGER HAYA SIDO CREADO CORRECTAMENTE
SHOW TRIGGERS;

-- Hacemos prueba insertando valores en la tabla empleados para que salte el TRIGGER que creamos

DELETE FROM empleados
WHERE email = 'miguel25@gmail.com';

INSERT INTO empleados (nombre, apellido, email) VALUES ('Jose','Rodriguez', 'jose25@gmail.com');
INSERT INTO empleados (nombre, apellido, email) VALUES ('Miguel','Hernandez', 'miguel25@gmail.com');
INSERT INTO empleados (nombre, apellido, email) VALUES ('Ana', 'Gomez', 'ana30@gmail.com');
INSERT INTO empleados (nombre, apellido, email) VALUES ('Luis', 'Martinez', 'luis45@gmail.com');

-- Ahora corremos un SELECT sobre la tabla LogEmpleados, para validar el trigger haya realizado el trabajo

SELECT *
FROM LogEmpleados;

-- *PROYECTO* --

-- PARA CREAR VISTAS QUE TENGAN INFORMACION DE MAS DE UNA TABLA NECESITAMOS HACER USO DE LOS JOIN 

CREATE VIEW VistaEmpleadosProyectos AS
SELECT E.nombre AS NombreEmpleado, E.apellido AS ApellidoEmpleado, P.nombre AS NombreProyecto
FROM Empleados E
JOIN AsignacionesDeProyectos A ON E.empleado_id = A.empleado_id
JOIN Proyectos P ON A.proyecto_id = P.proyecto_id;

-- Aqui consultamos la vista

SELECT *
FROM VistaEmpleadosProyectos;
