CREATE TABLE Biblioteca
(
  Nombre_Biblioteca VARCHAR(50) NOT NULL,
  Numero_Calle INT NOT NULL,
  Calle VARCHAR(50) NOT NULL,
  Codigo_Postal INT NOT NULL,
  Id_Biblioteca INT NOT NULL,
  PRIMARY KEY (Id_Biblioteca)
);

ALTER TABLE Biblioteca
ADD CONSTRAINT chk_Biblioteca_Id_Biblioteca_NonNegative
CHECK (Id_Biblioteca >= 0);

ALTER TABLE Biblioteca
ADD CONSTRAINT Biblioteca_Numero_Calle_Positivo
CHECK (Numero_Calle > 0);

-- Agrega la restricción corregida
ALTER TABLE Biblioteca
ADD CONSTRAINT Biblioteca_Codigo_Postal_5Digitos
CHECK (CHAR_LENGTH(CAST(Codigo_Postal AS VARCHAR)) = 5);


CREATE TABLE Editorial
(
  Nombre_Editorial VARCHAR(50) NOT NULL,
  Id_Editorial INT NOT NULL,
  PRIMARY KEY (Id_Editorial)
);

CREATE TABLE Prestatario
(
  Nombre VARCHAR(25) NOT NULL,
  Apellido_Paterno VARCHAR(25) NOT NULL,
  Apellido_Materno VARCHAR(25) NOT NULL,
  Id_Prestatario INT NOT NULL,
  PRIMARY KEY (Id_Prestatario)
);

CREATE TABLE Libro
(
  Nombre VARCHAR(100) NOT NULL,
  Id_Libro INT NOT NULL,
  Edicion INT NOT NULL,
  Anyo_Publicacion DATE NOT NULL,
  Id_Editorial INT NOT NULL,
  PRIMARY KEY (Id_Libro),
  FOREIGN KEY (Id_Editorial) REFERENCES Editorial(Id_Editorial)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

ALTER TABLE Libro
ADD CONSTRAINT Libro_Id_Libro_NoNegative
CHECK (Id_Libro >= 0);

CREATE TABLE Autor
(
  Nombre VARCHAR(25) NOT NULL,
  Fecha_Nacimiento DATE NOT NULL,
  Apellido_Materno VARCHAR(25) NOT NULL,
  Apellido_Paterno VARCHAR(25) NOT NULL,
  Id_Autor INT NOT NULL,
  Id_Libro INT NOT NULL,
  PRIMARY KEY (Id_Autor),
  FOREIGN KEY (Id_Libro) REFERENCES Libro(Id_Libro)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE Hay_Copias_Libro
(
  No_Copias INT NOT NULL,
  Id_Libro INT NOT NULL,
  Id_Biblioteca INT NOT NULL,
  PRIMARY KEY (Id_Libro, Id_Biblioteca),
  FOREIGN KEY (Id_Libro) REFERENCES Libro(Id_Libro)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (Id_Biblioteca) REFERENCES Biblioteca(Id_Biblioteca)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

ALTER TABLE Hay_Copias_Libro
ADD CONSTRAINT No_Copias_NoNegativo
CHECK (No_Copias >= 0);


CREATE TABLE Prestamo_Libro
(
  Fecha_Salida DATE NOT NULL,
  Fecha_Llegada DATE,
  Id_Libro INT NOT NULL,
  Id_Biblioteca INT NOT NULL,
  Id_Prestatario INT NOT NULL,
  PRIMARY KEY (Id_Libro, Id_Biblioteca, Id_Prestatario),
  FOREIGN KEY (Id_Libro) REFERENCES Libro(Id_Libro)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (Id_Biblioteca) REFERENCES Biblioteca(Id_Biblioteca)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (Id_Prestatario) REFERENCES Prestatario(Id_Prestatario)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);