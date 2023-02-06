# Guide d'exercices SQLAlchemy


**[A]** Installation

- Installez SQLAlchemy
- Vérifiez que vous avez un SGBDR disponible sur votre système
- Importe la base `ClassicModels` dans votre SGBDR

**[B]** Connexion

- Ecrivez un script qui connecte votre programme à votre base de données
- Ouvrez une session

**[C]** Modèle

- Ecrivez les classes d'entité Python qui correspondent au schéma de la base `ClassisModels`

**[D]** Requêtes

- Ecrivez avec l'API `Query` les requêtes suivantes :
  1. La liste des bureaux (adresse et ville) triés par pays décroissant puis par état
  2. La liste des avions (code et nom) triés par vendeur et par quantité en stock décroissants
  3. La liste des produits (code, nom, échelle et quantité) qui ont une échelle soit de 1:10, soit de 1:18
  4. La liste des produits (code, nom et prix d'achat) des produits achetés au moins 60$ au plus 90$
  5. La liste des commandes (numéro, date de commande, date d'expédition, écart en jours entre les deux dates et statut) qui sont en cours de traitement ou qui ont été expédiées et ont un écart de plus de 10j
  6. La liste des employés (nom, prénom et fonction) et des bureaux (adresse et ville) dans lequel ils travaillent
  7. La liste des lignes de commande (numéro de commande, code, nom et ligne de produit) et la remise appliquée aux voitures ou motos commandées
  8. Le prix moyen d'un produit vendu par chaque vendeur triés par prix moyen décroissant
  9. La quantité du produit le plus en stock de chaque vendeur trié par vendeur
  10. Le crédit des clients qui ont payé plus de 20000$ durant l'année 2004 trié par crédit décroissant
  11. Le total des paiements effectués de chaque client (numéro, nom et pays) américain, allemand ou français de plus de 50000$ trié par pays puis par total des paiements décroissant
  12. Le montant total de chaque commande (numéro et date) des clients New-Yorkais (nom) trié par nom du client puis par date de commande

**[E]** CRUD

- Ecrivez un programme qui implémente un CRUD en ligne de commande pour l'entité `order`
  - Une commande interactive/itérative permet à l'utilisateur de saisir une nouvelle commande
  - Une commande qui accepte en option l'id d'une commande doit permettre de mettre à jour la valeur d'une colonne dans une lignede commande (`orderline`)
  - Une commande qui accepte en option l'id d'une commande efface celle-ci
  - Une commande affiche les données d'une commande
