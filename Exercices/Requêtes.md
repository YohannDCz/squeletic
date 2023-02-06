
# Exercices SQL
 ​
## Révisions :

### Requête simple
* La liste des bureaux (adresse et ville) triés par pays décroissant puis par état

### Variantes de la clause WHERE
* La liste des avions (code et nom) triés par vendeur et par quantité en stock décroissants
* La liste des produits (nom, vendeur et prix de vente) qui sont vendus au moins 132$ triés par nom du produit
* La liste des produits (code, nom, échelle et quantité) qui ont une échelle soit de 1:10, soit de 1:18 triés par quantité en stock décroissante
* La liste des produits (code, nom et prix d’achat) achetés au moins 60$ au plus 90$ triés par prix d’achat

### Colonnes calculées
* La liste des motos (nom, vendeur, quantité et marge) triés par marge décroissante
* La liste des commandes (numéro de commande, date de commande, date d’expédition, écart en jours entre la date de commande et la date d’expédition, statut de la commande) soit qui sont en cours de traitement, soit qui ont été expédiées plus de 10 jours après la date de commande triés par écart décroissant puis par date de commande
* La liste des produits (nom et valeur du stock à la vente) des années 1960

### Jointures
* La liste des employés (nom, prénom et fonction) et des bureaux (adresse et ville) dans lequel ils travaillent
* La liste des clients français ou américains (nom du client, nom, prénom du contact et pays) et de leur commercial dédié (nom et prénom) triés par nom et prénom du contact
* La liste des lignes de commande (numéro de commande, code, nom et ligne de produit) et la remise appliquée aux voitures ou motos commandées triées par numéro de commande puis par remise décroissante

## Autres requêtes

### Agrégations
* Le prix moyen d’un produit vendu par chaque vendeur triés par prix moyen décroissant
* Le nombre de produits pour chaque ligne de produit
* Le total du stock et le total de la valeur du stock à la vente de chaque ligne de produit pour les produits vendus plus de 100$ trié par total de la valeur du stock à la vente
* La quantité du produit le plus en stock de chaque vendeur trié par vendeur
* Le prix de l’avion qui coûte le moins cher à l’achat
* Le crédit des clients qui ont payé plus de 20000$ durant l’année 2004 trié par crédit décroissant

### Requêtes complexes
* Le total des paiements effectués de chaque client (numéro, nom et pays) américain, allemand ou français de plus de 50000$ trié par pays puis par total des paiements décroissant
* Le montant total de chaque commande (numéro et date) des clients New-Yorkais (nom) trié par nom du client puis par date de commande

### Opérations ensemblistes
* Lister les noms et prenoms de toutes les personnes (clients + employés)
* Liste des pays qui sont à la fois dans la table des clients et dans les bureaux
* Lister les pays des clients où il n’y a pas de bureau

### Requêtes imbriquées
* Liste des noms et prénoms de personnes dont le total des commandes est supérieur à la moyenne des commandes
* Histogramme des délais de paiement (répartition en fonction du nombre de jours entre la date d’envoi et le paiement)
* Liste des pays où le délai de paiement est supérieur à la moyenne.
* Tous les clients ont-ils un représentant commercial ? Sinon, lister (nom, prenom + nom du contact, pays) ceux qui n’en ont pas. Et l’inverse ? (modifié)
* Recommandation d"achat : recommander à un acheteur des modèles qu'il pourrait aimer, c'est-à-dire des modèles achetés par des gens qui ont le mêmes goûts que lui.

### Partitionnement
* Le total des paiements effectués de chaque client (numéro, nom et pays) américain, allemand ou français de plus de 50000$ trié par pays puis par total des paiements décroissant _(variante avec partition)_
* Distribution par déciles des délais de paiement
* Délais de paiement par commande et par client avec moyenne globale
* Pays dans lesquels le délai de paiement est en moyenne supérieur à la moyenne globale
* Les trois modèles les plus vendus par catégorie de maquettes triés par ordre décroissant
