# Lab 07 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L07-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L07-O1 | Même interface de module sur Azure et AWS | Deux appels identiques, deux plans propres | À faire | |
| L07-O2 | Régions et plages lues depuis `docs/referentiel/valeurs.env` | Recherche dans le code : aucune valeur en dur | À faire | |
| L07-O3 | OIDC vers Azure et AWS, aucun secret stocké | Pipelines sans clé d'accès, journaux de connexion fédérée | À faire | |
| L07-O4 | Interconnexion Azure et AWS en IPsec | Tunnel établi, ping inter-cloud | À faire | |
| L07-O5 | Étiquettes et coût par lab | Rapports de coût filtrés sur `lab=07` dans les deux clouds | À faire | |
| L07-O6 | Option internationale par région | `SITE_INTL=es` : déploiement en Spain Central et eu-south-2 | À faire | |
| L07-O7 | Destroy complet des deux côtés | Aucune ressource `projet=hublabs` restante | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Services managés équivalents (bases, conteneurs) : seulement le site virtuel réseau.
- Interconnexion privée dédiée (ExpressRoute, Direct Connect).
- Troisième fournisseur.

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Conception de modules Terraform réutilisables | 3 | Interface documentée, versionnée |
| Réseau AWS : VPC, groupes de sécurité, routes | 2 | Chemin d'un paquet expliqué côté AWS |
| OIDC GitHub vers AWS (rôle IAM) | 3 | Condition de confiance expliquée |
| FinOps multi-cloud | 2 | Coût par lab mesuré dans les deux consoles |

## Question de connaissance

Une interface commune pour deux clouds réduit la duplication. À partir de quel moment devient-elle une dette (plus petit dénominateur commun, options qui fuient) ? Donne un exemple concret tiré de ton module où tu as choisi de **ne pas** abstraire.

Réponse rédigée dans le [journal](journal.md).
