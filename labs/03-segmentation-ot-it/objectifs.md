# Lab 03 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L03-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L03-O1 | Zones LYO conformes au référentiel (niveaux 1 à 4 et iDMZ) | Inventaire des réseaux Docker comparé à `docs/referentiel/adressage.md` | À faire | |
| L03-O2 | Conduit Modbus uniquement entre supervision et automates | Lecture réussie depuis la SCADA, échec depuis l'IT (sortie des deux tests) | À faire | |
| L03-O3 | Détection d'intrusion protocolaire sur l'OT | Alerte Suricata sur une écriture Modbus non autorisée, visible dans Grafana | À faire | |
| L03-O4 | Journaux centralisés et horodatés en UTC | Requête Loki montrant les événements des trois sources | À faire | |
| L03-O5 | Maquette Packet Tracer multi-sites (LYO, GRE, DIJ, CLD, option INT) | Fichier `.pkt` versionné, captures de ping et traceroute | À faire | |
| L03-O6 | Site international confiné | Option `site_intl=es` : Modbus depuis INT bloqué et alerté | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Automates physiques et protocoles autres que Modbus TCP (S7, OPC UA : backlog).
- Diode de données matérielle.
- Certification IEC 62443 (le lab en applique les principes, il ne certifie rien).

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Modèle Purdue, zones et conduits IEC 62443 | 3 | Schéma défendu oralement, chaque conduit justifié |
| Modbus TCP : codes fonction, risques | 2 | Lecture et écriture expliquées sur capture |
| Détection réseau (Suricata) et corrélation (Loki, Grafana) | 2 | Règle écrite, alerte reproduite |
| Maquette réseau multi-sites (Packet Tracer) | 3 | Routage inter-sites fonctionnel |

## Question de connaissance

Modbus n'a aucune authentification. Si un attaquant est déjà dans la zone supervision (niveau 2), que ta segmentation empêche-t-elle encore, et qu'est-ce qu'elle n'empêche plus ? Quelle mesure ajoutes-tu au niveau des codes fonction ?

Réponse rédigée dans le [journal](journal.md).
