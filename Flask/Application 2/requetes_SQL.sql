from flask import Flask, render_template, request
from sqlalchemy import text
from database import engineer, connect, serialize
import json

app = Flask(__name__)


@app.route('/hello')
@app.route("/hello/<name>")
def hello(name=None):
    name = name or "Mr Cadennes"
    return render_template('hello.html', user=name, name='yohann')
    # return f"<p>Hello, {name}</p>"


-------------------------------------------------------------------------------------------------------------------------------------
-- GROUPE 1
-------------------------------------------------------------------------------------------------------------------------------------

-- 1. Lister le nom et le prénom des musiciens, ordonnées par leur date de naissance
SELECT first_name, last_name, birthdate FROM artist ORDER BY birthdate ASC
-- 200 resultats

-- 2. Lister le nom et la capacité des lieux disponibles, ordonnés par capacité croissante
SELECT name, max_spectators FROM place ORDER BY max_spectators ASC
-- 5 resultats


-- 3. Lister les 5 prochains concerts.
SELECT id FROM event ORDER BY start_time LIMIT 5;
-- 5 resultats
-- Pour un resultat plus précis sans les 'rencontres ' == select id from event where discr = 'concert' order by start_time limit 5 ;




-------------------------------------------------------------------------------------------------------------------------------------
-- GROUPE 2
-------------------------------------------------------------------------------------------------------------------------------------

-- 1. Lister les spectateurs originaires de Croatie.
SELECT first_name,last_name,country FROM spectateur WHERE country = 'croatia';
-- 7 resultats

-- 2. Lister les musiciens nés entre 1970 et 1990.
SELECT first_name,last_name,birthdate FROM artist WHERE substring(birthdate,1,4)>= 1970 AND substring(birthdate,1,4) <= 1990;
-- 113 resultats

-- 3. Lister les spectateurs dont le nom commence par B et nés avant 1970 par ordre de date de naissance.
SELECT  first_name, last_name, birthdate FROM spectateur WHERE substring(last_name, 1, 1) = 'b' ORDER BY birthdate ASC
-- 42 resultats

-- 4. Lister les concerts (id et date) par ordre chronologique.
SELECT id, date FROM event WHERE discr='concert' ORDER BY date ASC
-- 10 resultats




-------------------------------------------------------------------------------------------------------------------------------------
-- GROUPE 3
-------------------------------------------------------------------------------------------------------------------------------------

-- 1. Lister les concerts et  afficher les artistes présent à chacun d’eux.
SELECT artist.id, artist.first_name, last_name, concert_part.concert_id FROM concert_part INNER JOIN artist ON artist.id = concert_part.artist_id;
-- 15 resultats

-- 2. Lister les concerts en indiquant le lieu dans lequel ils se déroulent
SELECT place.id AS place_id, event.id AS event_id FROM event INNER JOIN place ON place.id = event.place_id
-- 14 resulats

-- 3. Lister les instruments de chaque groupe
SELECT artist_group.group_id, artist.instrument FROM artist_group INNER JOIN artist ON artist.id = artist_group.artist_id ORDER BY artist_group.group_id
-- 236 resultats


-- 4. Lister les concerts auxquels va assister ** Retha Dookie**, avec la liste des membres du groupe, le lieu et la date/heure
SELECT spectateur.first_name, spectateur.last_name, spectateur_artist.artist_id AS Artist, event.id AS Concert, event.place_id AS Place, event.start_time FROM spectateur INNER JOIN spectateur_artist ON spectateur.first_name = "retha" AND spectateur.id = spectateur_artist.spectateur_id INNER JOIN event;
-- 70 resultats

-- 5. Calculer le panier moyen des ventes
SELECT COUNT(ticket.spectator_id), event.start_time FROM ticket INNER JOIN event ON event.id = ticket.concert_id GROUP BY event.start_time;
-- 10 resultats

-- 6. Lister qui est en première et seconde partie de chaque concert(et indiquer s’il n’y a personne).
SELECT artist.first_name, artist.last_name, concert_part.concert_id, concert_part.status FROM concert_part INNER JOIN artist ON artist.id = concert_part.artist_id;
-- 15 resultats

-- 7. Lister les salles/lieux et les contraintes techniques de chacune.
SELECT place.id, place.name, technical_constraints.equipment, technical_constraints.description FROM technical_constraints_place INNER JOIN technical_constraints ON technical_constraints.id = technical_constraints_place.technical_constraints_id INNER JOIN place ON place.id = technical_constraints_place.place_id;
-- 10 resultats

-- 8. Lister les groupes  et les salles où ils se produisent
SELECT group.id as group_id, group.name AS group_name, event.place_id, place.name AS place_name FROM event INNER JOIN concert_part ON event.id = concert_part.concert_id INNER JOIN `group` ON group.id = concert_part.artist_id INNER JOIN place;
-- 75 resultats




-------------------------------------------------------------------------------------------------------------------------------------
-- GROUPE 4
-------------------------------------------------------------------------------------------------------------------------------------

-- 1. Lister les groupes et leur nombre de membres.
SELECT COUNT(artist_id), group_id FROM artist_group GROUP BY group_id
-- 60 resultats

-- 2. Lister les concerts en indiquant le nombre de places vendues.
SELECT COUNT(spectator_id), concert_id FROM ticket GROUP BY concert_id
-- 10 resultats

-- 3. Lister le total des ventes pour chaque journée de festival(en se basant sur `startTime`).
-- 4. Lister la moyenne du montant des ventes pour chaque concert.
-- 5. Lister les concerts qui ont rassemblé plus de 100 spectateurs.


-------------------------------------------------------------------------------------------------------------------------------------
-- GROUPE 4
-------------------------------------------------------------------------------------------------------------------------------------

-- 1. Lister les nom, prénom de ceux qui font le festival : Artistes et Bénévoles.
SELECT first_name, last_name FROM artist
UNION ALL
SELECT first_name, last_name FROM staff;
-- 210 resultats

-- 2. Pour les téméraires : reprenez la requête précédente et ajouter une colonne indiquant le rôle (artiste ou bénévole) de chacun.
SELECT first_name, last_name, 'artiste' AS role FROM artist
UNION ALL
SELECT first_name, last_name, 'benevoles' AS role FROM staff;
-- 210 resultats

