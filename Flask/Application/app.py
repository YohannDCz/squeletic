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


######################################################################################################################################
# GROUPE 1
######################################################################################################################################

# 1- Lister le nom et le prénom des musiciens, ordonnées par leur date de naissance
# SELECT first_name. last_name, birthdate FROM artist ORDER BY birthdate ASC
@app.route("/names_and_birthdate")
def names_and_birthdate():
    fields = ['first_name', 'last_name', 'birthdate']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT {','.join(fields)} FROM artist ORDER BY birthdate ASC"))
    response = [data for data in result.all()]
    return render_template('/groupe1/01names_and_birthdate.html', response=response)


# 2. Lister le nom et la capacité des lieux disponibles, ordonnés par capacité croissante
# SELECT name, max_spectators FROM place ORDER BY max_spectators ASC

@app.route("/location")
def location():
    fields = ['name', 'max_spectators']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT {','.join(fields)} FROM place ORDER BY max_spectators ASC"))
    response = [data for data in result.all()]
    return render_template('/groupe1/02location.html', response=response)


# 3. Lister les 5 prochains concerts.
# SELECT id FROM event ORDER BY start_time LIMIT 5;
# Pour un resultat plus précis sans les 'rencontres ' == select id from event where discr = 'concert' order by start_time limit 5 ;


@app.route("/event_id")
def event_id():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT id FROM event ORDER BY start_time LIMIT 5"))
    response = [data for data in result.all()]
    return render_template('/groupe1/03event_id.html', response=response)

######################################################################################################################################
# GROUPE 2
######################################################################################################################################

# 1. Lister les spectateurs originaires de Croatie.
# SELECT first_name,last_name,country FROM spectateur WHERE country = 'croatia';


@app.route("/names_country")
def names_country():
    fields = ['first_name', 'last_name', 'country']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT { ','.join(fields) } FROM spectateur where country = 'croatia'"))
    response = [data for data in result.all()]
    return render_template('/groupe2/01names_country.html',  response=response)


# 2. Lister les musiciens nés entre 1970 et 1990.
# SELECT first_name,last_name,birthdate FROM artist WHERE substring(birthdate,1,4)>= 1970 AND substring(birthdate,1,4) <= 1990;
@app.route("/names_birthdate/")
def names_birthdate():
    fields = ['first_name', 'last_name', 'birthdate']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT {','.join(fields)} FROM artist WHERE substring(birthdate,1,4) >= 1970 and substring(birthdate,1,4) <= 1990"))
    response = [data for data in result.all()]
    return render_template('/groupe2/02names_birthdate.html',  response=response)


# 3. Lister les spectateurs dont le nom commence par B et nés avant 1970 par ordre de date de naissance.
# SELECT last_name FROM spectateur LIKE B WHERE birthdate <1970;

@app.route("/last_name_spectators")
def last_name_spectateurs():
    fields = ['first_name', 'last_name', 'birthdate']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT  {','.join(fields)} FROM spectateur WHERE substring(last_name, 1, 1) = 'b' ORDER BY birthdate ASC"))
    response = [data for data in result.all()]
    return render_template('/groupe2/03last_name_spectators.html',  response=response)


# 4 Lister les concerts (id et date) par ordre chronologique.
# SELECT id,date FROM events ORDER BY date;
@app.route("/concert_by_date")
def id_date():
    fields = ['id', 'date']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT {','.join(fields)} FROM event WHERE discr='concert' ORDER BY date ASC"))
    response = [data for data in result.all()]
    return render_template('/groupe2/04concert_by_date.html',  response=response)

######################################################################################################################################
# GROUPE 3
######################################################################################################################################

# 1. Lister les concerts et  afficher les artistes présent à chacun d’eux.
# SELECT artist.id, artist.first_name, last_name, concert_part.concert_id FROM concert_part INNER JOIN artist ON artist.id = concert_part.artist_id;


@app.route("/concerts_artists")
def concerts_artists():
    fields = ['artist.id', "artist.first_name",
              'last_name', 'concert_part.concert_id']
    with connect(engineer()) as connector:
        result = connector.execute(
            text(f"SELECT artist.id, artist.first_name, last_name, concert_part.concert_id FROM concert_part INNER JOIN artist ON artist.id = concert_part.artist_id"))
    response = [data for data in result.all()]
    return render_template('/groupe3/01concerts_artists.html', response=response)


# 2. Lister les concerts en indiquant le lieu dans lequel ils se déroulent
# SELECT place.id AS place_id, event.id AS event_id FROM event INNER JOIN place ON place.id = event.place_id

@app.route("/place_event")
def place_event():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT place.id AS place_id, event.id AS event_id FROM event INNER JOIN place ON place.id=event.place_id"))
    response = [data for data in result.all()]
    return render_template('/groupe3/02place_event.html', response=response)


# 3. Lister les instruments de chaque groupe
# SELECT artist_group.group_id, artist.instrument FROM artist_group INNER JOIN artist ON artist.id = artist_group.artist_id ORDER BY artist_group.group_id

@app.route("/artist_group_instrument")
def artist_group_instrument():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT artist_group.group_id, artist.instrument FROM artist_group INNER JOIN artist ON artist.id = artist_group.artist_id ORDER BY artist_group.group_id"))
    response = [data for data in result.all()]
    return render_template('/groupe3/03artist_group_instrument.html', response=response)


# 4. Lister les concerts auxquels va assister ** Retha Dookie**, avec la liste des membres du groupe, le lieu et la date/heure
# SELECT spectateur.first_name, spectateur.last_name, spectateur_artist.artist_id AS Artist, event.id AS Concert, event.place_id AS Place, event.start_time FROM spectateur INNER JOIN spectateur_artist ON spectateur.first_name = "retha" AND spectateur.id = spectateur_artist.spectateur_id INNER JOIN event;

@app.route("/rethadooley")
def rethadooley():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT spectateur_artist.artist_id AS Artist, event.id AS Concert, event.place_id AS Place, event.start_time FROM spectateur INNER JOIN spectateur_artist ON spectateur.first_name = 'retha' AND spectateur.id=spectateur_artist.spectateur_id INNER JOIN event"))
    response = [data for data in result.all()]
    return render_template('/groupe3/04rethadooley.html', response=response)


# 5. Calculer le panier moyen des ventes
# SELECT COUNT(ticket.spectator_id), event.start_time FROM ticket INNER JOIN event ON event.id = ticket.concert_id GROUP BY event.start_time;

@app.route("/average_basket")
def average_basket():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT COUNT(ticket.spectator_id), event.start_time FROM ticket INNER JOIN event ON event.id = ticket.concert_id GROUP BY event.start_time"))
    response = [data for data in result.all()]
    return render_template('/groupe3/05average_basket.html', response=response)


# 6. Lister qui est en première et seconde partie de chaque concert(et indiquer s’il n’y a personne).
# SELECT artist.first_name, artist.last_name, concert_part.concert_id, concert_part.status FROM concert_part INNER JOIN artist ON artist.id = concert_part.artist_id;

@app.route("/first_and_second_part")
def first_and_second_part():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT artist.first_name, artist.last_name, concert_part.concert_id, concert_part.status FROM concert_part INNER JOIN artist ON artist.id = concert_part.artist_id"))
    response = [data for data in result.all()]
    return render_template('/groupe3/06first_and_second_part.html', response=response)


# 7. Lister les salles/lieux et les contraintes techniques de chacune.
# SELECT place.id, place.name, technical_constraints.equipment, technical_constraints.description FROM technical_constraints_place INNER JOIN technical_constraints ON technical_constraints.id = technical_constraints_place.technical_constraints_id INNER JOIN place ON place.id = technical_constraints_place.place_id;

@app.route("/hall_and_location")
def hall_and_location():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT place.id, place.name, technical_constraints.equipment, technical_constraints.description FROM technical_constraints_place INNER JOIN technical_constraints ON technical_constraints.id = technical_constraints_place.technical_constraints_id INNER JOIN place ON place.id = technical_constraints_place.place_id"))
    response = [data for data in result.all()]
    return render_template('/groupe3/07hall_and_location.html', response=response)


# 8. Lister les groupes  et les salles où ils se produisent
# SELECT group.id as group_id, group.name AS group_name, event.place_id, place.name AS place_name FROM event INNER JOIN concert_part ON event.id = concert_part.concert_id INNER JOIN `group` ON group.id = concert_part.artist_id INNER JOIN place;

@app.route("/groups_and_location")
def groups_and_location():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT group.id as group_id, group.name AS group_name, event.place_id, place.name AS place_name FROM event INNER JOIN concert_part ON event.id = concert_part.concert_id INNER JOIN `group` ON group.id = concert_part.artist_id INNER JOIN place"))
    response = [data for data in result.all()]
    return render_template('/groupe3/08groups_and_location.html', response=response)


######################################################################################################################################
# GROUPE 4
######################################################################################################################################

# 1. Lister les groupes et leur nombre de membres.
# SELECT COUNT(artist_id), group_id FROM artist_group GROUP BY group_id

@app.route("/groups")
def groups():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT COUNT(artist_id), group_id FROM artist_group GROUP BY group_id"))
    response = [data for data in result.all()]
    return render_template('/groupe4/01groups.html', response=response)


# 2. Lister les concerts en indiquant le nombre de places vendues.
# SELECT COUNT(spectator_id), concert_id FROM ticket GROUP BY concert_id

@app.route("/ticket_number")
def ticket_number():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT COUNT(spectator_id), concert_id FROM ticket GROUP BY concert_id"))
    response = [data for data in result.all()]
    return render_template('/groupe4/02ticket_number.html', response=response)


# 3. Lister le total des ventes pour chaque journée de festival(en se basant sur `startTime`)
# 4. Lister la moyenne du montant des ventes pour chaque concert
# 5. Lister les concerts qui ont rassemblé plus de 100 spectateurs


######################################################################################################################################
# GROUPE 5
######################################################################################################################################

# 1. Lister les nom, prénom de ceux qui font le festival : Artistes et Bénévoles.
# SELECT first_name, last_name FROM artist
# UNION ALL
# SELECT first_name, last_name FROM staff;

@app.route("/artists_and_volunteers")
def artist_and_volunteers():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT first_name, last_name FROM artist UNION ALL SELECT first_name, last_name FROM staff"))
    response = [data for data in result.all()]
    return render_template('/groupe5/01artists_and_volunteers.html', response=response)


# 2. Pour les téméraires: reprenez la requête précédente et ajouter une colonne indiquant le rôle(artiste ou bénévole) de chacun.
# SELECT first_name, last_name, 'artiste' AS role FROM artist
# UNION ALL
# SELECT first_name, last_name, 'benevoles' AS role FROM staff;

@app.route("/artists_and_volunteers2")
def artists_and_volunteers2():
    with connect(engineer()) as connector:
        result = connector.execute(
            text("SELECT first_name, last_name, 'artiste' AS role FROM artist UNION ALL SELECT first_name, last_name, 'benevoles' AS role FROM staff"))
    response = [data for data in result.all()]
    return render_template('/groupe5/02artists_and_volunteers.html', response=response)


######################################################################################################################################
# GROUPE 6
######################################################################################################################################

# 1. Afficher les groupes qui passent en seconde partie de concert.
# 2. Lister les gens qui ont dépensé plus que la moyenne du panier d’achat.
# 3. Recommandation: Trouver des concerts qui pourraient intéresser un spectateur.

######################################################################################################################################
