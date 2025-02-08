-- 1. Crear la tabla de prueba
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

-- 2. Insertar un registro inicial
INSERT INTO clientes (id, nombre, email) VALUES (1, 'Juan Pérez', 'juan@example.com');

-- 2.1. Intentar insertar un ID duplicado para probar la restricción de clave primaria
PRINT 'Intentando insertar un ID duplicado...'
BEGIN TRY
    INSERT INTO clientes (id, nombre, email) VALUES (1, 'Carlos Gómez', 'carlos@example.com');
END TRY
BEGIN CATCH
    PRINT 'Error: No se puede insertar un ID duplicado.';
    PRINT ERROR_MESSAGE();
END CATCH;

-- 3. Usar MERGE para insertar o actualizar
PRINT 'Ejecutando MERGE...'
MERGE INTO clientes AS target
USING (VALUES (1, 'Luis Casas', 'luis@example.com')) AS source (id, nombre, email)
ON target.id = source.id
WHEN MATCHED THEN 
    UPDATE SET nombre = source.nombre, email = source.email
WHEN NOT MATCHED THEN 
    INSERT (id, nombre, email) VALUES (source.id, source.nombre, source.email);

-- 4. Ver los resultados
PRINT 'Resultados después de MERGE:'
SELECT * FROM clientes;
