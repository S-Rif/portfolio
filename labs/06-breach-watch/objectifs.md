# Lab 06 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L06-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L06-O1 | Aucun mot de passe ni empreinte complète stocké ou transmis | Test automatisé : la requête sortante ne contient que 5 caractères hexadécimaux | À faire | |
| L06-O2 | Détection d'une fuite sur un service suivi | Alerte générée sur un jeu de données fictif | À faire | |
| L06-O3 | Notifications push et e-mail | Notification reçue sur la PWA, e-mail visible dans Mailpit | À faire | |
| L06-O4 | Application installable sur iPhone et Android | PWA installée, capture de l'écran d'accueil | À faire | |
| L06-O5 | Secrets hors Git (clés VAPID, SMTP) | Analyse gitleaks verte, secrets fournis par l'environnement | À faire | |
| L06-O6 | Option internationale : langue et domaine du site | Option `site_intl=es` : notification en espagnol, horodatage UTC | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Notifications SMS (payantes) : backlog.
- Recherche de fuites par adresse e-mail réelle (API payante, données personnelles).
- Coffre-fort de mots de passe.

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Conception respectueuse de la vie privée (k-anonymat) | 3 | Flux de données expliqué sur schéma |
| API Python (FastAPI) et tests | 2 | Couverture des cas d'alerte |
| PWA : service worker, Web Push, installation | 2 | Installation et push reproduits sur deux plateformes |
| Gestion des secrets applicatifs | 3 | Aucun secret dans l'historique Git |

## Question de connaissance

Breach Watch stocke la liste des services utilisés par chaque collaborateur. En quoi cette liste est-elle elle-même une donnée sensible pour HubLabs, et que se passe-t-il si la base de Breach Watch fuit ? Qu'est-ce que tu changes dans le modèle de données ?

Réponse rédigée dans le [journal](journal.md).
