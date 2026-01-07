/* =========================================================
   TIFOSI — Schéma MySQL (DDL)
   Fichier : sql/01_create_schema.sql
   Objectif : créer la base + les tables + contraintes
   MySQL 8+ recommandé
========================================================= */

-- Création / réinitialisation de la base
DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Utilisateur MySQL dédié
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi_2026!';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

USE tifosi;

/* =========================
   TABLES PRINCIPALES
========================= */


-- Ingrédients
CREATE TABLE ingredient (
  id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Focaccias
CREATE TABLE focaccia (
  id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL UNIQUE,
  prix DECIMAL(6,2) NOT NULL CHECK (prix >= 0)
) ENGINE=InnoDB;

-- Marques
CREATE TABLE marque (
  id_marque INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Boissons (1 boisson appartient à 1 marque)
CREATE TABLE boisson (
  id_boisson INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(120) NOT NULL,
  id_marque INT NOT NULL,
  CONSTRAINT fk_boisson_marque
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT uq_boisson UNIQUE (nom, id_marque)
) ENGINE=InnoDB;

-- Clients
CREATE TABLE client (
  id_client INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(120) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  code_postal VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

-- Menus (un menu contient exactement 1 focaccia => FK dans menu)
CREATE TABLE menu (
  id_menu INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(120) NOT NULL UNIQUE,
  prix DECIMAL(6,2) NOT NULL CHECK (prix >= 0),
  id_focaccia INT NOT NULL,
  CONSTRAINT fk_menu_focaccia
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

/* =========================
   TABLES D'ASSOCIATION
========================= */

-- Comprend : association focaccia <-> ingredient avec quantite
CREATE TABLE comprend (
  id_focaccia INT NOT NULL,
  id_ingredient INT NOT NULL,
  quantite INT NOT NULL CHECK (quantite > 0),
  PRIMARY KEY (id_focaccia, id_ingredient),
  CONSTRAINT fk_comprend_focaccia
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_comprend_ingredient
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Contient : association menu <-> boisson (un menu peut proposer plusieurs boissons)
CREATE TABLE contient (
  id_menu INT NOT NULL,
  id_boisson INT NOT NULL,
  PRIMARY KEY (id_menu, id_boisson),
  CONSTRAINT fk_contient_menu
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_contient_boisson
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Achete : association client <-> menu avec date_achat
CREATE TABLE achete (
  id_client INT NOT NULL,
  id_menu INT NOT NULL,
  date_achat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_client, id_menu, date_achat),
  CONSTRAINT fk_achete_client
    FOREIGN KEY (id_client) REFERENCES client(id_client)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_achete_menu
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

/* =========================
   INDEX 
========================= */
CREATE INDEX idx_boisson_marque ON boisson(id_marque);
CREATE INDEX idx_menu_focaccia ON menu(id_focaccia);
