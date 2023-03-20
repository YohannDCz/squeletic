Groupe 1 : SELECT
        1-Lister le nom et le prénom des musiciens, ordonnées par leur date de naissance

                => results = session.query(Person).order_by(Person.birthdate)
                   for r in results : 
                        print(r)
        2-Lister le nom et la capacité des lieux disponibles, ordonnés par capacité croissante 

                => results = session.query(Places).order_by(Places.Capacity)
                   for r in results : 
                        print(r)

        3-Lister les 5 prochains concerts
                => session.query(Events).order_by(Events.Date).limit(5).all()
                   for r in results : 
                        print(r)
Groupe 2 : WHERE
        1- Lister les spectateurs originaires de Croatie
                => session.query(Person).filter(Person.country == "Croatie" or Person.country == "croatie" )
                   for r in results : 
                        print(r) #ou Croatia si c'est en anglais
        2- Lister les musiciens nés entre 1970 et 1990
                => session.query(artist).filter(artist.birthdate >= 1990 , artist.birthdate <= 1995)
                   for r in results : 
                                   print(r)
        3- Lister les spectateurs dont le nom commence par B et nés avant 1970

        4-Lister les concerts (id et date) par ordre chronologique
                => results = session.query(events).filter(events.id,event.date).order_by(event.date.desc())
                   for r in results : 
                        print(f"{events.id} : {event.date}")
Groupe 3 : JOIN 
        1-Lister les concerts et afficher les artistes présent à chacun d’eux
                => results = session.query(events.name,artists.name).filter(event.artists == artists.name)
                for r in results : 
                        print(f"{r.name} | {r.lastname}")
        2-Lister les concerts en indiquant le lieu dans lequel ils se déroulent
                => results = session.query(events.name,places.place).filter(event.Place == places.place)
                for r in results : 
                        print(f"{r.name} | {r.name}")
        3-Lister les instruments de chaque groupe
                => results = session.query(instruments.name,group.name).filter(group.instruments == instruments.name)
                for r in results : 
                        print(f"{r.name} | {r.name}")
        4-Lister les concerts auxquels va assister Retha Dookie, avec la liste des membres du groupe, le lieu et la date/heure
                => results = session.query(Person.firstname,Person.lastname,group.Member,Places.place,event.date,event.Name).filter(event.spectators == "Retha Dookie")
                for r in results : 
                        print(f"{r.firstname} {r.lastname} will attend the {r.name}, {r.date},for the {r.Name} and the group that they will assists has for members {group.members} ")
        5-Calculer le panier moyen des ventes  
                => results = session.query(func.sum(event.sold_tickets)/func.count(Person.ssn))
                for r in results : 
                        print('the avg ;' + str(r) )
   XX   6-Lister qui est en première et seconde partie de chaque concert (et indiquer s’il n’y a personne)
                => #Pas Réussi

        7-Lister les salles/lieux et les contraintes techniques de chacune.       
                => results = session.query(events.name,places.place,events.constraints,places.constraints)
                for r in results : 
                        print(f"{r.name} has {events.constraints} and {places.place} has {places.constraints})
        8-Lister les groupes et les salles où ils se produisent
                => results = session.query(group.name,places.place).filter(places.group == group.name)
                for r in results : 
                        print(f"{r.name} will perform at {r.place}")
Groupe 4 : GROUP BY
        1-Lister les groupes et leur nombre de membres.
                => results = session.query(groups,artists).filter(group.name == artists.group)
                for r in results : 
                        print(f"{r.name} {func}")

        2-Lister les concerts en indiquant le nombre de places vendues.
        
