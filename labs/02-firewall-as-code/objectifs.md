# Lab 02 · Objectifs

## Mission

Les pare-feu de l'Usine HubLabs sont décrits en code depuis la matrice de flux du référentiel. Une règle n'existe que si elle est dans Git, relue, testée, puis appliquée.

## Objectifs mesurables

Un objectif passe à « Validé » **uniquement sur preuve**, consignée dans [preuves](preuves/README.md) avec le commit associé. Le workflow `qualite` refuse un objectif « Validé » sans preuve.

| ID | Objectif mesurable | Preuve attendue | Statut |
| --- | --- | --- | --- |
| L02-O1 | Règles générées depuis `matrice-flux.md`, sans saisie manuelle | Diff vide entre la matrice et `policy.yml` régénéré | À faire |
| L02-O2 | Syntaxe validée avant application | `nft -c -f` sans erreur dans la CI | À faire |
| L02-O3 | Tests de flux automatisés, autorisés et interdits (F01 à F10) | Étape « Compose · tests » du workflow `labs` : 10 flux vérifiés | À faire |
| L02-O4 | Application idempotente | Second passage Ansible : `changed=0` | À faire |
| L02-O5 | Détection de dérive | Règle ajoutée à la main signalée par le test, puis supprimée par réapplication | À faire |
| L02-O6 | Site international optionnel | Option `site_intl=ma` : F07 passe, F08 bloqué | À faire |
| L02-O7 | Retour arrière prouvé | `git revert` puis réapplication : état précédent restauré et testé | À faire |

Statuts possibles : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Haute disponibilité des pare-feu (vue dans le domaine FortiGate de la formation).
- Inspection TLS, IPS et filtrage applicatif.
- IPsec réel entre sites (lab 04).

## Compétences visées

Échelle : 0 aucune notion, 1 a déjà vu, 2 sait faire avec support, 3 sait faire seul et expliquer, 4 sait le défendre devant un client et l'enseigner.

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Modéliser une politique de filtrage (zones, flux, refus par défaut) | 3 | Matrice et `policy.yml` relus |
| nftables : tables, chaînes, suivi de connexion | 3 | Règles écrites et expliquées sans support |
| Ansible : rôle, template Jinja2, idempotence | 3 | `changed=0` et rôle testé par Molecule |
| Tests d'infrastructure en CI | 2 | Pipeline rouge puis vert sur un flux cassé |

## Question de senior

À préparer pour l'entretien, réponse écrite dans le [compte-rendu](compte-rendu.md) :

Ta matrice dit « tout ce qui n'est pas listé est interdit ». Comment prouves-tu qu'un flux interdit est bloqué par le pare-feu, et pas simplement parce que le service cible n'écoute pas ? Que change la différence entre un rejet (`reject`) et un abandon silencieux (`drop`) pour tes tests et pour un attaquant ?
