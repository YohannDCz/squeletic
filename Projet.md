# Projet

## Tâches

1. Concevez un schéma de base de données pour cette application. Le schéma devra être rendu sous forme d'export SQL et si possible d'une représentation graphique de ce schéma.
2. Créez une base de données avec le schéma qui sera défini une fois pour toutes après la correction de la phase 1
3. Implémentez avec Flask une interface simple permettant d'accéder aux données
4. Implémentez avec SQLAlchemy les requêtes suivantes et affichez les resultats dans des pages de votre application.
  - Vous devrez créer une route pour chaque requête, naturellement


## Enoncé du projet

Vous avez à gérer l'organisation d'un festival de musique dans ses diverses dimensions. En vue de créer le modèle du domaine, on vous a transmis une liste de cas d'utilisation, que voici :

| Cas 1 |
|---|
| En tant que programmateur |
| Je souhaite savoir comment sont formés les groupes |

| Cas 2 |
|---|
| En tant que spectateur |
| Je souhaite pouvoir réserver des billets |

| Cas 3 |
|---|
| En tant que régisseur |
| Je souhaite pouvoir attribuer une salle adaptée à un groupe |

| Cas 4 |
|---|
| En tant qu'organisateur |
| Je souhaite pouvoir organiser une série de concerts |

| Cas 5 |
|---|
| En tant que musicien |
| Je souhaite pouvoir préciser des contraintes techniques |

| Cas 6 |
|---|
| En tant que programmateur |
| Je souhaite pouvoir éviter les conflits de dates de programmation |

| Cas 7 |
|---|
| En tant qu'organisateur |
| Je souhaite savoir organiser des rencontres/dédicaces avec les fans |

| Cas 8 |
|---|
| En tant que spectateur |
| Je souhaite profiter de tarifs spéciaux |

| Cas 9 |
|---|
| En tant que comptable |
| Je souhaite pouvoir moduler des catégories de prix des billets |

| Cas 10 |
|---|
| En tant que spectateur |
| Je souhaite réserver des places pour plusieurs événements |

| Cas 11 |
|---|
| En tant qu"organisateur |
| Je souhaite recruter des bénévoles pour des tâches d'encadrement des événements |

| Cas 12 |
|---|
| En tant que programmateur |
| Je souhaite composer des concerts en plusieurs parties |

| Cas 13 |
|---|
| En tant que programmateur |
| Je souhaite pouvoir gérer le processus d'engagement des musiciens |

| Cas 14 |
|---|
| En tant que programmateur |
| Je souhaite savoir comment sont formés les groupes |

| Cas 15 |
|---|
| En tant que comptable |
| Je souhaite connaître les rémunérations des musiciens |

| Cas 16 |
|---|
| En tant que bénévole |
| Je souhaite prévenir de mes disponibilités |

| Cas 17 |
|---|
| En tant qu'organisateur |
| Je souhaite savoir si un spectateur a retiré son billet |

| Cas 18 |
|---|
| En tant qu'organisateur |
| Je souhaite pouvoir faire une analyse statistique de la provenance des spectateurs |

| Cas 19 |
|---|
| En tant que programmateur |
| Je souhaite connaître les spécificités des différents lieux du festival  |

| Cas 20 |
|---|
| En tant que spectateur |
| Je souhaite avoir des informations sur les groupes et les musiciens |

| Cas 21 |
|---|
| En tant que programmateur |
| Je souhaite savoir comment sont formés les groupes |

| Cas 22 |
|---|
| En tant que spectateur |
| Je souhaite dire que j'ai aimé la prestation d'un musicien |

| Cas 23 |
|---|
| En tant que spectateur |
| J'aimerais choisir des concerts en fonction de mes style de prédilection |

| Cas 24 |
|---|
| En tant que musicien |
| J'aimerais émettre des exigences techniques pour les concerts |

| Cas 25 |
|---|
| En tant qu'agent d'un groupe |
| J'aimerais valider la participation du groupe au festival |

| Cas 26 |
|---|
| En tant qu'organisateur |
| J'aimerais pouvoir assurer la conformité des salles aux normes de sécurité de jauge |

| Cas 27 |
|---|
| En tant que membre du staff |
| Je souhaite choisir de m'occuper plus particulièrement de certaines tâches |

| Cas 28 |
|---|
| En tant que spectateur |
| J'aimerais connaître l'accessibilité des lieux de concert |


## Requêtes

### Groupe 1 : SELECT

1. Lister les concerts par ordre chronologique
2. Lister le nom et le prénom des musiciens, ordonnées par leur date de naissance
3. Lister

### Groupe 2 : WHERE

1. Lister les spectateurs originaires de la ville de 'Caen'
2. Lister les musiciens nés entre 1950 et 1980
3. Lister les spectateurs originaires d'Allemagne nés avant 1960
4. Lister

### Groupe 3 : JOIN

### Groupe 4 : GROUP BY

### Groupe 5 : Requêtes ensemblistes

### Groupe 6 : Requêtes complexes
