# squeletic

## Objectif

Cours d'initiation à SQL, composé d'exercices et d'un projet d'application web en Python réalisé avec Flask.
Vous trouverez dans ce dépôt :

### Une base de données

Un [fichier SQL](sources/ClassicModels.sql) permettant d'importer une base de données dans un serveur SQL quelconque.

Il s'agit d'un magasin qui vend des modèles réduits (comme grossiste). Le scéma comprend :
- des produits (`products`) et des catégories de produits (`productlines`)
- des employés (`employee`) et des bureaux (`office`)
- des clients (`customers`) avec des commandes (`orders`, `orderlines`) et des paiements ( `payments`)
- et enfin des fournisseurs (`vendors`)

### Des exercices

Dans le dossier exercices, vous trouverezune [liste de questions](Exercices/Requêtes.md) à propos des données de la base ClasicModels.

Les solutions sont données dans le sous-dossier Solutions.

### Une documentation sur Flask

Dans le dossier [Flask](Flask/), vous trouverez toute la documentation pour créer une application Flask minimale (le but étant d'afficher de manière un peu ergonomique les données de la base).

Il existe également une peute base de code pour un serveur Flask d'exemple.

## Ressources globales pour le cours

### Ressources système

Vous pouvez avoir besoin d'installer des outils « système » sur votre machine.
Auquel cas, il peut être utile d'installer un gestionnaire de paquetages (packages) adapté à votre système d'exploitation.
- Linux Debain, Ubuntu et semblables: **apt** (installé avec le système)
- macOS : [Homebrew](https://brew.sh/)
- Windows : [Chocolatey](https://chocolatey.org/) ou [Scoop](https://scoop.sh/)

Si voçus ne l'avez pas fait, installez git sur votre machine.
Et, optionnellement, profitez-en pour créer un compte sur Github dont vous aurez besoin pour le projet.
Gra^ce aux gestionnaire ci-dessus, vous pouvez l'installer en une ligne :
```bash
# apt (Linux)
apt install git

# brew (macOS ou Linux)
brew install git

# Scoop (Windows)
scoop install git
```

### Pour le cours
Les supports de cours sont réalisés avec **Jupyter**, qui est un outil de documentation hybride, combinant texte et code.
Cela étant, une version PDF est dicponible, mais moins flexible, naturellement.

Jupyter s'installe par le biais de `pip` le gestionnaire de paquetages de Python. Cela vous demandera donc d'installer Python.

1. Installer `Python` avec un [installeur officiel](https://www.python.org/downloads/)
2. Installer `pip` via Python :
```bash
# L'option -m exécute un module Python
python -m pip install
```
3. Installer Jupyter via `pip` :
```bash
pip install notebook
```
Vous avez maintenant la pile logicielle minimale pour travailler.

### Pour le projet

Les ressources pour le projet associé au cours sont des modules Python. Ils sont décrits dans la documentation.
Rappelons-les ici :
- Flask
- SQLAlchemy

## Crédits
> **Auteur et contact** : michel.cadennes@sens-commun.fr
