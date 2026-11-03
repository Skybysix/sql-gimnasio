DROP TABLE IF EXISTS monitor_especialidades;
DROP TABLE IF EXISTS especialidades;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS clases;
DROP TABLE IF EXISTS monitores;
DROP TABLE IF EXISTS tarjetas;
DROP TABLE IF EXISTS socios;
DROP TABLE IF EXISTS planes;

/* 1. Crear planes, socios y tarjetas*/
CREATE TABLE planes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    precio_mensual NUMERIC(6,2) NOT NULL CHECK (precio_mensual >= 0)
);

CREATE TABLE socios (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_alta DATE NOT NULL,
    plan_id INTEGER NOT NULL REFERENCES planes(id)
);

CREATE TABLE tarjetas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    activa BOOLEAN NOT NULL,
    socio_id INTEGER UNIQUE NOT NULL REFERENCES socios(id)
);

/* 2. Crear monitores y clases */
CREATE TABLE monitores (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);
CREATE TABLE clases (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actividad VARCHAR(100) NOT NULL,
    sala VARCHAR(50) NOT NULL,
    monitor_id INTEGER NOT NULL REFERENCES monitores(id),
    fecha_hora TIMESTAMP NOT NULL,
    plazas INTEGER NOT NULL CHECK (plazas > 0)
);

/* 3. Crear reservas */
CREATE TABLE reservas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    socio_id INTEGER NOT NULL REFERENCES socios(id),
    clase_id INTEGER NOT NULL REFERENCES clases(id),
    fecha_reserva DATE NOT NULL,
    UNIQUE (socio_id, clase_id)
);
CREATE TABLE especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE monitor_especialidades (
    monitor_id INTEGER NOT NULL REFERENCES monitores(id),
    especialidad_id INTEGER NOT NULL REFERENCES especialidades(id),
    PRIMARY KEY (monitor_id, especialidad_id)
);
