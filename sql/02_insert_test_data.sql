/* =========================================================
   TIFOSI — Données de test (DML)
   Fichier : sql/02_insert_test_data.sql
   À exécuter après : sql/01_create_schema.sql
========================================================= */

USE tifosi;

-- Rejouable : on vide les tables dans le bon ordre
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE achete;
TRUNCATE TABLE contient;
TRUNCATE TABLE menu;
TRUNCATE TABLE comprend;
TRUNCATE TABLE boisson;
TRUNCATE TABLE client;
TRUNCATE TABLE focaccia;
TRUNCATE TABLE ingredient;
TRUNCATE TABLE marque;
SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

-- Marques
INSERT INTO marque (id_marque, nom) VALUES
  (1, 'Coca-cola'),
  (2, 'Cristalline'),
  (3, 'Monster'),
  (4, 'Pepsico');

-- Ingrédients
INSERT INTO ingredient (id_ingredient, nom) VALUES
  (1, 'Ail'),
  (2, 'Ananas'),
  (3, 'Artichaut'),
  (4, 'Bacon'),
  (5, 'Base tomate'),
  (6, 'Base crème'),
  (7, 'Champignon'),
  (8, 'Chevre'),
  (9, 'Cresson'),
  (10, 'Emmental'),
  (11, 'Gorgonzola'),
  (12, 'Jambon cuit'),
  (13, 'Jambon fumé'),
  (14, 'Oeuf'),
  (15, 'Oignon'),
  (16, 'Olive noire'),
  (17, 'Olive verte'),
  (18, 'Parmesan'),
  (19, 'Piment'),
  (20, 'Poivre'),
  (21, 'Pomme de terre'),
  (22, 'Raclette'),
  (23, 'Salami'),
  (24, 'Tomate cerise'),
  (25, 'Mozarella');

-- Focaccias
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
  (1, 'Mozaccia', 9.8),
  (2, 'Gorgonzollaccia', 10.8),
  (3, 'Raclaccia', 8.9),
  (4, 'Emmentalaccia', 9.8),
  (5, 'Tradizione', 8.9),
  (6, 'Hawaienne', 11.2),
  (7, 'Américaine', 10.8),
  (8, 'Paysanne', 12.8);

-- Boissons
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
  (1, 'Coca-cola zéro', 1),
  (2, 'Coca-cola original', 1),
  (3, 'Fanta citron', 1),
  (4, 'Fanta orange', 1),
  (5, 'Capri-sun', 1),
  (6, 'Pepsi', 4),
  (7, 'Pepsi Max Zéro', 4),
  (8, 'Lipton zéro citron', 4),
  (9, 'Lipton Peach', 4),
  (10, 'Monster energy ultra gold', 3),
  (11, 'Monster energy ultra blue', 3),
  (12, 'Eau de source', 2);

-- Composition des focaccias (focaccia <-> ingredient)
-- Quantités issues du fichier focaccia (section "Ail : 2", "Base tomate : 200", etc.)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
  -- Mozaccia
  (1, 5, 200),
  (1, 25, 50),
  (1, 9, 20),
  (1, 13, 80),
  (1, 24, 40),
  -- Gorgonzollaccia
  (2, 5, 200),
  (2, 11, 50),
  (2, 9, 20),
  (2, 1, 2),
  (2, 7, 80),
  (2, 18, 50),
  (2, 20, 1),
  (2, 16, 10),
  -- Raclaccia
  (3, 5, 200),
  (3, 22, 50),
  (3, 9, 20),
  (3, 1, 2),
  (3, 7, 80),
  (3, 18, 50),
  (3, 20, 1),
  (3, 16, 10),
  -- Emmentalaccia
  (4, 6, 200),
  (4, 10, 50),
  (4, 9, 20),
  (4, 7, 80),
  (4, 18, 50),
  (4, 20, 1),
  (4, 15, 20),
  (4, 16, 10),
  -- Tradizione (les parenthèses dans le fichier sont ignorées, on utilise les quantités standard)
  (5, 5, 200),
  (5, 25, 50),
  (5, 9, 20),
  (5, 12, 80),
  (5, 7, 80),
  (5, 16, 10),
  (5, 17, 10),
  -- Hawaienne
  (6, 5, 200),
  (6, 25, 50),
  (6, 9, 20),
  (6, 4, 80),
  (6, 2, 40),
  (6, 20, 1),
  (6, 19, 2),
  -- Américaine
  (7, 5, 200),
  (7, 25, 50),
  (7, 9, 20),
  (7, 4, 80),
  (7, 21, 80),
  (7, 20, 1),
  (7, 19, 2),
  -- Paysanne
  (8, 6, 200),
  (8, 8, 50),
  (8, 9, 20),
  (8, 21, 80),
  (8, 12, 80),
  (8, 14, 50),
  (8, 15, 20),
  (8, 20, 1);

COMMIT;
