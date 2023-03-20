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
# 4-select spectateur.first_name, spectateur.last_name, spectateur_artist.artist_id as Artist, event.id as Concert, event.place_id as Place, event.start_time from spectateur inner join spectateur_artist on spectateur.first_name = "retha" and spectateur.id = spectateur_artist.spectateur_id inner join event
# 5. Calculer le panier moyen des ventes
# 5-select count(ticket.spectator_id), event.start_time from ticket inner join event on event.id = ticket.concert_id group by event.start_time
# 6. Lister qui est en première et seconde partie de chaque concert(et indiquer s’il n’y a personne)
# 6-select artist.first_name, artist.last_name, concert_part.concert_id, concert_part.status from concert_part inner join artist on artist.id = concert_part.artist_id
# 7. Lister les salles/lieux et les contraintes techniques de chacune.
# 7-select place.id, place.name, technical_constraints.equipment from technical_constraints_place inner join technical_constraints on technical_constraints.id = technical_constraints_place.technical_constraints_id inner join place on place.id = technical_constraints_place.place_id
# # Or
# 7 2.0 - select place.id, place.name, technical_constraints.equipment, technical_constraints.description from technical_constraints_place inner join technical_constraints on technical_constraints.id = technical_constraints_place.technical_constraints_id inner join place on place.id = technical_constraints_place.place_id
# 8. Lister les groupes  et les salles où ils se produisent
# 8-select group.id as group_id, group.name as group_name, event.place_id, place.name as place_name from event inner join concert_part on event.id = concert_part.concert_id inner join `group` on group.id = concert_part.artist_id inner join place


# G4
# 1-select count(artist_id), group_id from artist_group group by group_id
# 2-select count(spectator_id), concert_id from ticket group by concert_id
