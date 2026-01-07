Tifosi — Base de données MySQL

 Description
Ce projet consiste à concevoir et exploiter une base de données relationnelle MySQL
pour le site "Tifosi", à partir d’un modèle de données fourni.

Le projet couvre :
- la création du schéma de la base de données,
- la sécurisation des données (contraintes, intégrité),
- l’insertion de données de test,
- l’exécution de requêtes SQL de validation.



  Prérequis
- MySQL 8 ou supérieur
- Un compte MySQL administrateur (ex : root) pour exécuter le script de création
- Environnement Linux / WSL recommandé



 Structure du projet

 tifosi/
        -README.md
        -sql/
           01_create_schema.sql
           02_insert_test_data.sql
           03_test_queries.sql


 Ordre d’exécution des scripts

1. 01_create_schema.sql  
2. 02_insert_test_data.sql  
3. 03_test_queries.sql