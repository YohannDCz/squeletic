# Projet SQL Hetic


### Groupe 1 : SELECT (Sans jointures) (0.5/20)

1. Lister le nom et le prénom des musiciens, ordonnées par leur date de naissance
2. Lister le nom et la capacité des lieux disponibles, ordonnés par capacité croissante
3. Lister les 5 prochains concerts

### Groupe 2 : WHERE (0.5/20)

1. Lister les spectateurs originaires de **Croatie**
2. Lister les musiciens nés entre 1970 et 1990
3. Lister les spectateurs dont le nom commence par **B** et nés avant 1970
4. Lister les concerts (id et date) par ordre chronologique

### Groupe 3 : JOIN (1/20)

1. Lister les concerts et  afficher les artistes présent à chacun d’eux
2. Lister les concerts en indiquant le lieu dans lequel ils se déroulent
3. Lister les instruments de chaque groupe
4. Lister les concerts auxquels va assister **Retha Dookie**, avec la liste des membres du groupe, le lieu et la date/heure
5. Calculer le panier moyen des ventes
6. Lister qui est en première et seconde partie de chaque concert (et indiquer s’il n’y a personne)
7. Lister les salles/lieux et les contraintes techniques de chacune.
8. Lister les groupes  et les salles où ils se produisent

### Groupe 4 : GROUP BY (1/20)

1. Lister les groupes et leur nombre de membres.
2. Lister les concerts en indiquant le nombre de places vendues.
3. Lister le total des ventes pour chaque journée de festival (en se basant sur `startTime`)
4. Lister la moyenne du montant des ventes pour chaque concert
5. Lister les concerts qui ont rassemblé plus de 100 spectateurs

### Groupe 5 : Requêtes ensemblistes (3/20)

1. Lister les nom, prénom de ceux qui font le festival : Artistes et Bénévoles.
2. Pour les téméraires : reprenez la requête précédente et ajouter une colonne indiquant le rôle (artiste ou bénévole) de chacun.

### Groupe 6 : Requêtes complexes (3/20)

1. Afficher les groupes qui passent en seconde partie de concert
2. Lister les gens qui ont dépensé plus que la moyenne du panier d’achat
3. Recommandation : Trouver des concerts qui pourraient intéresser un spectateur

    Explications :

    J’ai réservé une place pour un concert

    Trouver les personnes qui ont aussi réservé une place pour ce même concert

    Trouver les autres concerts auxquels ces personnes ont assisté

    Sélectionner les 3 qui ont le meilleur « score »
