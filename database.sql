CREATE DATABASE IF NOT EXISTS Sucursal;

USE Sucursal;

CREATE TABLE IF NOT EXISTS vehiculos (
    id BIGINT NOT NULL AUTO_INCREMENT,
    marca VARCHAR(255),
    modelo VARCHAR(255),
    ano INT,
    color VARCHAR(255),
    tipo_combustible VARCHAR(255),
    PRIMARY KEY (id)
);
