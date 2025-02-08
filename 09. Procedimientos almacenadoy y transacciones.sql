-- *PROCEDIMIENTOS ALMACENADOS* --

-- Un procedimiento almacenado es un conjunto de instrucciones SQL guardadas y ejecutables en MySQL.

-- *EXPLICACION CODIGO SQL PARA CREAR UN STORE PROCEDURE* --

-- DELIMITER // cambia el delimitador de ; a // para definir el procedimiento.
-- CREATE PROCEDURE AgregarEmpleado crea un procedimiento almacenado llamado AgregarEmpleado en MySQL.
-- Los parámetros de entrada _nombre, _apellido, _email y _depto_id reciben valores al ejecutarlo.
-- La instrucción INSERT INTO Empleados agrega un nuevo empleado con los datos proporcionados.
-- DELIMITER ; restablece el delimitador a ;, permitiendo ejecutar comandos SQL normalmente.

DELIMITER //
CREATE PROCEDURE AgregarEmpleado(IN _nombre VARCHAR(255), IN _apellido VARCHAR(255), IN _email VARCHAR(255), IN _depto_id INT)
BEGIN
	INSERT INTO Empleados(nombre, apellido, email, depto_id) VALUES (_nombre, _apellido, _email, _depto_id);
END //

DELIMITER ;

CALL AgregarEmpleado('Harold','Aracena','aracenaharol007@gmail.com', 1);

-- Este es el codigo para eliminar un procedimiento de asi desearlo
-- DROP PROCEDURE IF EXISTS nombre_del_procedimiento;
DROP PROCEDURE IF EXISTS AgregarEmpleado;

-- Al consultar la tabla de empleados podemos observar que el nuevo empleado fue agregado exitosamente.
SELECT *
FROM empleados;

-- *TRANSACCIONES* --

-- *PRINCIPIOS ACID* --

-- Atomicidad (Atomicity): La transacción se ejecuta completamente o no se ejecuta nada.
-- Consistencia (Consistency): La base de datos pasa de un estado válido a otro válido.
-- Aislamiento (Isolation): Las transacciones no interfieren entre sí mientras se ejecutan.
-- Durabilidad (Durability): Los cambios confirmados permanecen en la base de datos incluso ante fallos.

-- *COMANDOS DE TRANSACCIONES* --

-- BEGIN TRANSACTION: Inicia una transacción para agrupar múltiples operaciones.
-- COMMIT: Guarda permanentemente los cambios realizados en la transacción.
-- ROLLBACK: Revierte todos los cambios realizados desde BEGIN TRANSACTION.

BEGIN; 
SAVEPOINT PreValidacion;

INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) VALUES (5,1,10);
INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) VALUES (5,2,15);
INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) VALUES (5,3,20);
INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) VALUES (5,4,12);
INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) VALUES (5,5,18);
INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) VALUES (5,6,25);
-- Aquí iría el código para validar el total de horas
SELECT SUM(horas_asignadas) AS total_horas FROM AsignacionesDeProyectos WHERE proyecto_id = 5;
-- Si el total excede, podemos revertir a nuestro SAVEPOINT
ROLLBACK TO PreValidacion;
-- Si todo está bien, se confirma la transacción
COMMIT;

-- *PRACTICA*--

DELIMITER //

CREATE PROCEDURE AsignarHorasAProyecto(IN proyectoId INT, IN empleadoId INT, IN horasAsignadas INT)
BEGIN
    DECLARE horasTotales INT DEFAULT 0;
    DECLARE horasMaximas INT DEFAULT 100;
    
    -- Iniciar una transacción
    START TRANSACTION;
    
    -- Establecer un punto de guardado
    SAVEPOINT PreValidacion;
    
    -- Calcular el total actual de horas asignadas al proyecto
    SELECT SUM(horas_asignadas) INTO horasTotales 
    FROM AsignacionesDeProyectos 
    WHERE proyecto_id = proyectoId;
    
    -- Asumiendo que SUM() puede devolver NULL si no hay filas, lo convertimos a 0
    SET horasTotales = IFNULL(horasTotales, 0) + horasAsignadas;
    
    -- Verificar si el total excede las horas máximas permitidas
    IF horasTotales > horasMaximas THEN
        -- Revertir a SAVEPOINT si se excede el total de horas
        ROLLBACK TO PreValidacion;
        -- Aunque el ROLLBACK TO SAVEPOINT mantiene la transacción activa, decidimos terminar la operación con un mensaje de error.
        SELECT 'Error: La asignación excede el total de horas permitidas para el proyecto.' AS mensaje;
    ELSE
        -- Insertar la nueva asignación si el total está dentro del límite
        INSERT INTO AsignacionesDeProyectos (proyecto_id, empleado_id, horas_asignadas) 
        VALUES (proyectoId, empleadoId, horasAsignadas);
        
        -- Confirmar la transacción si todas las operaciones fueron exitosas
        COMMIT;
    END IF;
END //

DELIMITER ;

-- Ahora invocamos este procedimiento

CALL AsignarHorasAProyecto (1,1,50)

-- Al momento de exceder las 100 horas nos mostrara el emnsaje de error configurado anteriormente y volvera al savepoint

-- *PROYECTO* --

-- Crear un procedimiento almacenado llamado AgregarDepartamento
-- Debe aceptar de entrada dos parametros (nombre y ubicacion del departamento)

DELIMITER //

CREATE PROCEDURE AgregarDepartamento (IN _nombre VARCHAR(255),IN _ubicacion VARCHAR(255))
BEGIN
	INSERT INTO departamentos(nombre, ubicacion) VALUES (_nombre, _ubicacion);
END //

DELIMITER ;

-- Llamamos el procedimiento e insertamos los datos a la tabla
CALL AgregarDepartamento ('Sistemas', 'Edificio C');
CALL AgregarDepartamento ('RRHH', 'Edificio D');

-- Hacemos una consulta para validar hayan sido agregados con exito a traves del Procedure
SELECT * 
FROM departamentos;
