# Lab 02 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L02-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L02-O1 | Règles générées depuis `matrice-flux.md`, sans saisie manuelle | Diff vide entre la matrice et `policy.yml` régénéré | À faire | |
| L02-O2 | Syntaxe validée avant application | `nft -c -f` sans erreur dans la CI | À faire | |
| L02-O3 | Tests de flux automatisés, autorisés et interdits (F01 à F10) | Étape « Compose · tests » du workflow `labs` : 10 flux vérifiés | À faire | |
| L02-O4 | Application idempotente | Second passage Ansible : `changed=0` | À faire | |
| L02-O5 | Détection de dérive | Règle ajoutée à la main signalée par le test, puis supprimée par réapplication | À faire | |
| L02-O6 | Site international optionnel | Option `site_intl=ma` : F07 passe, F08 bloqué | À faire | |
| L02-O7 | Retour arrière prouvé | `git revert` puis réapplication : état précédent restauré et testé | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Haute disponibilité des pare-feu (vue dans le domaine FortiGate de la formation).
- Inspection TLS, IPS et filtrage applicatif.
- IPsec réel entre sites (lab 04).

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Modéliser une politique de filtrage (zones, flux, refus par défaut) | 3 | Matrice et `policy.yml` relus |
| nftables : tables, chaînes, suivi de connexion | 3 | Règles écrites et expliquées sans support |
| Ansible : rôle, template Jinja2, idempotence | 3 | `changed=0` et rôle testé par Molecule |
| Tests d'infrastructure en CI | 2 | Pipeline rouge puis vert sur un flux cassé |

## Question de connaissance

Ta matrice dit « tout ce qui n'est pas listé est interdit ». Comment prouves-tu qu'un flux interdit est bloqué par le pare-feu, et pas simplement parce que le service cible n'écoute pas ? Que change la différence entre un rejet (`reject`) et un abandon silencieux (`drop`) pour tes tests et pour un attaquant ?

Réponse rédigée dans le [journal](journal.md).
