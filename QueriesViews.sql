--Consulta 1
SELECT Libro.Nombre AS Nombre_Libro, 
       Prestamo_Libro.Fecha_Salida,
       CONCAT(Prestatario.Nombre, ' ', Prestatario.Apellido_Paterno, ' ', Prestatario.Apellido_Materno) AS Nombre_Prestatario
FROM Prestamo_Libro
JOIN Libro ON Prestamo_Libro.Id_Libro = Libro.Id_Libro
JOIN Biblioteca ON Prestamo_Libro.Id_Biblioteca = Biblioteca.Id_Biblioteca
JOIN Prestatario ON Prestamo_Libro.Id_Prestatario = Prestatario.Id_Prestatario
WHERE Biblioteca.Calle = 'Calle del Saber';

--Consulta 2
SELECT Hay_Copias_Libro.No_Copias
FROM Hay_Copias_Libro
JOIN Libro ON Hay_Copias_Libro.Id_Libro = Libro.Id_Libro
JOIN Biblioteca ON Hay_Copias_Libro.Id_Biblioteca = Biblioteca.Id_Biblioteca
WHERE Libro.Nombre = 'Whispers of the Stars'
  AND Biblioteca.Nombre_Biblioteca = 'Biblioteca Central';

--Consulta 3
SELECT
  Hay_Copias_Libro.No_Copias AS Numero_de_Copias,
  Libro.Edicion AS Numero_de_Edicion,
  Biblioteca.Nombre_Biblioteca,
  Biblioteca.Numero_Calle,
  Biblioteca.Calle,
  Biblioteca.Codigo_Postal
FROM
  Libro
JOIN
  Hay_Copias_Libro ON Libro.Id_Libro = Hay_Copias_Libro.Id_Libro
JOIN
  Biblioteca ON Hay_Copias_Libro.Id_Biblioteca = Biblioteca.Id_Biblioteca
WHERE
  Libro.Nombre = 'Ecos del Pasado';

--Vista no. 1
CREATE VIEW Vista_LibrosConAutores AS
SELECT
    L.Nombre AS Nombre_Libro,
    E.Nombre_Editorial,
    A.Nombre AS Nombre_Autor,
    A.Apellido_Paterno AS Apellido_Autor_Paterno,
    A.Apellido_Materno AS Apellido_Autor_Materno
FROM
    Libro L
    JOIN Editorial E ON L.Id_Editorial = E.Id_Editorial
    JOIN Autor A ON L.Id_Libro = A.Id_Libro;

--Vista no. 2
CREATE VIEW Vista_LibrosDisponibles AS
SELECT L.Nombre AS Nombre_Libro, B.Nombre_Biblioteca, B.Calle, B.Codigo_Postal
FROM Libro L
JOIN Hay_Copias_Libro HCL ON L.Id_Libro = HCL.Id_Libro
JOIN Biblioteca B ON HCL.Id_Biblioteca = B.Id_Biblioteca
WHERE HCL.No_Copias > 0;

--Vista no. 3
CREATE VIEW Vista_PrestamosPrestatario AS
SELECT 
    PL.Fecha_Salida,
    PL.Fecha_Llegada,
    L.Nombre AS Nombre_Libro,
    B.Nombre_Biblioteca,
    P.Nombre AS Nombre_Prestatario
FROM Prestamo_Libro PL
JOIN Libro L ON PL.Id_Libro = L.Id_Libro
JOIN Biblioteca B ON PL.Id_Biblioteca = B.Id_Biblioteca
JOIN Prestatario P ON PL.Id_Prestatario = P.Id_Prestatario;


