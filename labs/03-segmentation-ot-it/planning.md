# Lab 03 · Planning

Échéance : **S4**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Zones Purdue en conteneurs | Inventaire conforme, F06 bloqué | |
| 2 | Modbus, Suricata, Loki, Grafana | Alerte visible dans Grafana | |
| 3 | Maquette Packet Tracer multi-sites | `.pkt` versionné, tests de connectivité capturés | |
| 4 | Option internationale et preuves | Option `es` conforme | |

## Détail des séances

### Séance 1 : Zones Purdue en conteneurs

1. Un réseau Docker par zone, plages du référentiel.
2. Pare-feu `lyo-fw01` avec les règles du lab 02.
3. Inventaire automatique des réseaux comparé au référentiel.

Point de contrôle : Inventaire conforme, F06 bloqué.

### Séance 2 : Modbus, Suricata, Loki, Grafana

1. Automate et SCADA pymodbus, lecture de registres.
2. Suricata dans l'espace réseau du pare-feu, parseur Modbus activé.
3. Collecte des journaux vers Loki, tableau de bord Grafana.

Point de contrôle : Alerte visible dans Grafana.

### Séance 3 : Maquette Packet Tracer multi-sites

1. Sites LYO, GRE, DIJ, CLD et hub, adressage du référentiel.
2. Routage inter-sites et listes de contrôle d'accès cohérentes avec la matrice.
3. Captures de ping et traceroute.

Point de contrôle : `.pkt` versionné, tests de connectivité capturés.

### Séance 4 : Option internationale et preuves

1. Site INT dans la maquette et conteneur technicien distant (profil `intl-es`).
2. Scénario F07 autorisé, F08 bloqué et alerté.
3. Preuves et compte-rendu.

Point de contrôle : Option `es` conforme.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-03-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-03): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
