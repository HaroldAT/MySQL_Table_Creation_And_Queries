-- *COMANDO DML Y CRUD* --
-- CRUD: CREATE, READ, UPDATE, DELETE

-- SELECT: Recupera datos de una o más tablas.
-- INSERT INTO: Inserta nuevos registros en una tabla.
-- UPDATE: Actualiza datos existentes en una tabla.
-- DELETE: Elimina registros de una tabla.


-- Ejemplo INSERT INTO: Inserta datos en la tabla 'departamentos', agregando nombre y ubicación específicos.

INSERT INTO departamentos (nombre, ubicacion) VALUES
('Recursos Humanos', 'Edificio B'),
('Marketing', 'Edificio Central');

-- Con esta consulta podemos validar si los datos han sido ingresados
SELECT *
FROM departamentos;

-- UPDATE

-- Error 1175: Modo de actualización segura activado. Evita UPDATE sin WHERE en columna clave.  
-- Solución: Desactiva temporalmente el modo seguro con
-- SET SQL_SAFE_UPDATES = 0;
  
-- Nota: Recuerda reactivar el modo seguro después con 
-- SET SQL_SAFE_UPDATES = 1;  

UPDATE departamentos
SET ubicacion = 'Edificio M'
WHERE nombre = 'Marketing';

-- Aqui validamos que ya ha sido actualizado
SELECT *
FROM departamentos;

-- DELETE

DELETE FROM departamentos
WHERE nombre = 'marketing';

-- Aqui validamos haya sido eliminado, recordar siemrpe colocar un condicionante y FROM ya que de lo contrario borraria todo

SELECT *
FROM departamentos;
