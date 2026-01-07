/* =========================================================
   TIFOSI — Requêtes de test
   Fichier : sql/03_test_queries.sql
   À exécuter après :
     - sql/01_create_schema.sql
     - sql/02_insert_test_data.sql
========================================================= */

USE tifosi;

/* =========================================================
   Requête 1
   But : Afficher la liste des focaccias par ordre alphabétique.
   Résultat attendu : 8 lignes (les focaccias triées par nom).
   Résultat obtenu : 8 focaccias affichées par ordre alphabétique avec leur prix :
    Américaine (10.80), Emmentalaccia (9.80), Gorgonzollaccia (10.80),
    Hawaienne (11.20), Mozaccia (9.80), Paysanne (12.80),
    Raclaccia (8.90), Tradizione (8.90). 
   Commentaire : Le tri est effectué par ordre alphabétique
========================================================= */
SELECT nom, prix
FROM focaccia
ORDER BY nom ASC;


/* =========================================================
   Requête 2
   But : Afficher le nombre total d’ingrédients.
   Résultat attendu : 25 ingrédients.
   Résultat obtenu : 25 ingrédients.
   Commentaire : La requête renvoie le nombre total d’ingrédients présents dans le tableau
========================================================= */
SELECT COUNT(*) AS total_ingredients
FROM ingredient;


/* =========================================================
   Requête 3
   But : Afficher le prix moyen des focaccias.
   Résultat attendu : une valeur moyenne (décimale).
   Résultat obtenu : Le prix moyen des focaccias est de 10.38
   Commentaire : La valeur correspond à la moyenne des prix de toutes les focaccias présentes dans la base de données

========================================================= */
SELECT ROUND(AVG(prix), 2) AS prix_moyen_focaccias
FROM focaccia;


/* =========================================================
   Requête 4
   But : Afficher la liste des boissons avec leur marque,
         triées par nom de boisson.
   Résultat attendu : 12 lignes avec (boisson, marque).
   Résultat obtenu :
    Capri-sun                  Coca-cola   
    Coca-cola original         Coca-cola   
    Coca-cola zéro             Coca-cola   
    Eau de source              Cristalline 
    Fanta citron               Coca-cola   
    Fanta orange               Coca-cola   
    Lipton Peach               Pepsico     
    Lipton zéro citron         Pepsico     
    Monster energy ultra blue  Monster     
    Monster energy ultra gold  Monster     
    Pepsi                      Pepsico     
    Pepsi Max Zéro             Pepsico 
   Commentaire : Le tri est effectué par ordre alphabétique, il s'affiche en ajoutant le nom de la marque
========================================================= */
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom ASC;


/* =========================================================
   Requête 5
   But : Afficher la liste des ingrédients pour une focaccia donnée (Raclaccia).
   Résultat attendu : la liste des ingrédients de "Raclaccia" + quantités.
   Résultat obtenu :La focaccia "Raclaccia" est composée de 8 ingrédients avec leurs quantités :
    Ail (2), Base tomate (200), Champignon (80), Cresson (20),
    Olive noire (10), Parmesan (50), Poivre (1), Raclette (50)
   Commentaire : a requête utilise les tables de liaison pour afficher les ingrédients
associés à une focaccia spécifique ainsi que leurs quantités
========================================================= */
SELECT f.nom AS focaccia, i.nom AS ingredient, c.quantite
FROM comprend c
JOIN focaccia f ON f.id_focaccia = c.id_focaccia
JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;


/* =========================================================
   Requête 6
   But : Afficher le nom des focaccias et le nombre d’ingrédients associés à chacune.
   Résultat attendu : 8 lignes, avec le nombre d’ingrédients par focaccia.
   Résultat obtenu :8 focaccias affichées avec leur nombre d’ingrédients :
    Mozaccia (5), Américaine (7), Hawaienne (7), Tradizione (7),
    Emmentalaccia (8), Gorgonzollaccia (8), Paysanne (8), Raclaccia (8).
   Commentaire : La requête utilise un regroupement (GROUP BY) afin de compter
    le nombre d’ingrédients associés à chaque focaccia
========================================================= */
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM focaccia f
LEFT JOIN comprend c ON c.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;


/* =========================================================
   Requête 7
   But : Afficher la focaccia qui possède le plus grand nombre d’ingrédients.
   Résultat attendu : 1 ligne (la focaccia avec le max d’ingrédients).
   Résultat obtenu : La focaccia "Emmentalaccia" est affichée avec 8 ingrédients.
   Commentaire : Plusieurs focaccias possèdent le nombre maximal de 8 ingrédients.
    La clause LIMIT 1 permet d’en afficher une seule (ici Emmentalaccia).
========================================================= */
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM focaccia f
JOIN comprend c ON c.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;


/* =========================================================
   Requête 8
   But : Afficher la liste des focaccias contenant de l’ail.
   Résultat attendu : les focaccias où ingredient = "Ail".
   Résultat obtenu : 2 focaccias contiennent de l’ail : Gorgonzollaccia et Raclaccia.
   Commentaire : La requête filtre les focaccias associées à l’ingrédient "Ail"
    via la table de liaison "comprend".
========================================================= */
SELECT DISTINCT f.nom AS focaccia
FROM focaccia f
JOIN comprend c ON c.id_focaccia = f.id_focaccia
JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;


/* =========================================================
   Requête 9
   But : Afficher la liste des ingrédients non utilisés dans aucune focaccia.
   Résultat attendu : ingrédients absents de la table "comprend".
   Résultat obtenu : 2 ingrédients ne sont utilisés dans aucune focaccia : Artichaut et Salami.
   Commentaire : Les ingrédients affichés ne possèdent aucune association
    avec une focaccia dans la table "comprend".
========================================================= */
SELECT i.nom AS ingredient
FROM ingredient i
LEFT JOIN comprend c ON c.id_ingredient = i.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom ASC;


/* =========================================================
   Requête 10
   But : Afficher la liste des focaccias ne contenant pas de champignons.
   Résultat attendu : focaccias qui n'ont pas l'ingrédient "Champignon".
   Résultat obtenu : 4 focaccias ne contiennent pas de champignons :
    Américaine, Hawaienne, Mozaccia et Paysanne.
   Commentaire : La requête utilise une sous-requête avec NOT EXISTS afin de vérifier
    l’absence de l’ingrédient "Champignon" pour chaque focaccia.
========================================================= */
SELECT f.nom AS focaccia
FROM focaccia f
WHERE NOT EXISTS (
  SELECT 1
  FROM comprend c
  JOIN ingredient i ON i.id_ingredient = c.id_ingredient
  WHERE c.id_focaccia = f.id_focaccia
    AND i.nom = 'Champignon'
)
ORDER BY f.nom ASC;
