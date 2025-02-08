# 🚀 Implementación de MERGE en SQL Server

Este proyecto demuestra cómo utilizar la instrucción `MERGE` en **SQL Server** para insertar o actualizar registros de manera eficiente, evitando errores de clave primaria y optimizando el manejo de datos.

## 📌 Descripción
El script incluido realiza las siguientes acciones:
1. **Crea la tabla `clientes`** con una clave primaria en la columna `id`.
2. **Inserta un registro inicial** para simular datos existentes.
3. **Valida la restricción de clave primaria**, intentando insertar un ID duplicado y capturando el error.
4. **Utiliza `MERGE` para actualizar si el ID existe o insertar si no existe.**
5. **Muestra los resultados** finales de la tabla para verificar la ejecución.

## 🛠️ Tecnologías utilizadas
- **SQL Server** (Microsoft SQL Server Management Studio o Azure SQL Database)

## 📜 Código principal
```sql
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
```

## 🎯 Beneficios del uso de `MERGE`
✅ **Evita la necesidad de hacer múltiples consultas (`IF EXISTS` + `UPDATE` + `INSERT`)**
✅ **Mejora el rendimiento en cargas masivas de datos**
✅ **Garantiza integridad y evita errores de duplicados**

## 🚀 Cómo ejecutar el script
1. **Abrir SQL Server Management Studio (SSMS)**
2. **Ejecutar el código SQL en una base de datos de prueba**
3. **Observar la salida** para ver cómo `MERGE` maneja los datos

## 📢 Contribuciones
Si deseas mejorar este script o agregar nuevas funcionalidades, ¡siéntete libre de hacer un fork y contribuir! 😃

📌 **Autor:** Luis Ángel Casas Ballestas

