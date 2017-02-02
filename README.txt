********************************
# ios_randomuser
Cotillard Sebastien

********************************

Simple application montrant l'utilisation d'un XML transformé en NSDictionnary, avec utilisation et Gestion de NSException personnalisé (Ligne d'erreur, Nom de la méthode).

Un prototype (au plus vite) pour montrer plusieurs cas possible.

- Utilisation IPhone 6 et 4s
- Utiliser un code Exterieur (Library)
- Le dev préfere coder que d'utiliser la souris, parce que chercher un case à cocher c'est trop long ...
- Utiliser le Storyboard pour placer une image plutot que [UIimage imageWithName] ou NSData avec une url, puis [UIImage imageWithData]
- Acces style Objective-C 1.X et 2.X
- Gestion des Exceptions (Centralisé, Local, ...) ... Dommage que la macro NSDuring ne soit pas present sur IOS
- Preferer utiliser NSEmeerator que FastEnumeration
- Utilisation d'un XMl (https://randomuser.me/api/?results=50&format=xml) comme "Base de données", puis conversion en XML pour Stockage
- Extension de classe avec le CATEGORY Objective-C
- Mettre du commentaire et des reperes #Pragma Mark (DatabaseDelegate)
- Eviter d'utiliser le 'objectAtIndexedSubscript' obj["cle"] ou obj[1], bref obj[index]
- utilisation d'une Vue Personnalisé UI	TableCell'

Les données sont présenté comme une liste de contacts dans de belles couleurs bien voyante.

NSdata est utilisé pour récuperer les données XML de départ via HTTP

Une Librairie va transformer ou Parser le fichier XML et le disposer en NSDictionnary

Codé pendant deux sessions entre 13H et 16H avant de gerer d'autres demandes (RCS) et prise de Régie