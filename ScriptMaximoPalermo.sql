CREATE DATABASE IF NOT EXISTS streamwave;
USE streamwave;

-- Tabla: usuarios
CREATE TABLE usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL,
    tipo_suscripcion ENUM('Free', 'Premium') DEFAULT 'Free',
    fecha_nacimiento DATE,
    pais VARCHAR(50)
);

-- Tabla: artistas
CREATE TABLE artistas (
    artista_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais_origen VARCHAR(50),
    fecha_inicio YEAR
);

-- Tabla: albumes
CREATE TABLE albumes (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    fecha_lanzamiento DATE,
    artista_id INT,
    FOREIGN KEY (artista_id) REFERENCES artistas(artista_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabla: canciones
CREATE TABLE canciones (
    cancion_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME,
    genero VARCHAR(50),
    album_id INT,
    artista_id INT,
    fecha_lanzamiento DATE,
    FOREIGN KEY (album_id) REFERENCES albumes(album_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (artista_id) REFERENCES artistas(artista_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabla: listas_reproduccion
CREATE TABLE listas_reproduccion (
    lista_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    usuario_id INT,
    fecha_creacion DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla: canciones_por_lista (tabla intermedia)
CREATE TABLE canciones_por_lista (
    lista_id INT,
    cancion_id INT,
    orden INT,
    PRIMARY KEY (lista_id, cancion_id),
    FOREIGN KEY (lista_id) REFERENCES listas_reproduccion(lista_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (cancion_id) REFERENCES canciones(cancion_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabla: reproducciones
CREATE TABLE reproducciones (
    reproduccion_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    cancion_id INT,
    fecha_hora DATETIME,
    duracion_escuchada INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (cancion_id) REFERENCES canciones(cancion_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
