# Lab 03 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Docker Engine et Compose | Zones Purdue en réseaux isolés | Libre, 0 € | à figer au démarrage |
| Simulateur Modbus (pymodbus) | Automate et client SCADA | Libre, 0 € | à figer au démarrage |
| Suricata | Détection d'intrusion, parseur Modbus | Libre, 0 € | à figer au démarrage |
| Loki, Grafana Alloy, Grafana | Collecte et tableau de bord | Libre, 0 € en auto-hébergé | à figer au démarrage |
| Cisco Packet Tracer (Windows) | Maquette réseau multi-sites | Gratuit avec un compte Cisco Networking Academy | à figer au démarrage |
| Rôle `nva` du lab 02 | Règles du pare-feu `lyo-fw01` | Interne | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Automates | Simulateur pymodbus | Automate physique ou logiciel sous licence | Simulateur |
| Observabilité | Loki et Grafana auto-hébergés | Offre cloud managée | Auto-hébergé |
| Maquette réseau | Packet Tracer | GNS3 ou EVE-NG avec images constructeur | Packet Tracer |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- Labs 00 et 02 validés (le pare-feu de zone vient du lab 02).
- Packet Tracer installé sous Windows.
- Notions : modèle Purdue, ce qu'est un automate et un registre Modbus.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| LYO IT postes / serveurs (niveau 4) | 10.20.1.0/24 / 10.20.2.0/24 | P |
| LYO iDMZ (niveau 3.5) | 10.20.8.0/24 | P |
| LYO OT exploitation (niveau 3) | 10.20.9.0/24 | P |
| LYO OT supervision (niveau 2) | 10.20.10.0/24 | P |
| LYO OT contrôle (niveau 1) | 10.20.11.0/24 | P |
| GRE / DIJ | 10.20.16.0/20 / 10.20.32.0/20 | P |
| CLD / INT-MA / INT-ES | 10.20.48.0/20 / 10.20.64.0/20 / 10.20.80.0/20 | P |
| Ports locaux du lab (Grafana inclus) | 18030 à 18039 | P |

### Ressources machine

3 à 4 Go de RAM avec Suricata, Loki et Grafana. 8 Go conseillés sur le poste ; limiter WSL dans `.wslconfig`.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-03): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Zones Purdue en conteneurs | Inventaire conforme, F06 bloqué | |
| 2 | Modbus, Suricata, Loki, Grafana | Alerte visible dans Grafana | |
| 3 | Maquette Packet Tracer multi-sites | `.pkt` versionné, tests de connectivité capturés | |
| 4 | Option internationale et preuves | Option `es` conforme | |

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
3. Preuves et journal.

Point de contrôle : Option `es` conforme.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/03-segmentation-ot-it docs/referentiel
cd labs/03-segmentation-ot-it
docker compose up -d --wait                           # montage
docker compose run --rm tests                         # un test par objectif
COMPOSE_PROFILES=intl-ma docker compose up -d --wait  # variante site international
docker compose down -v --remove-orphans               # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=03`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 6 sur 6 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Aucune alerte Modbus alors que le trafic passe | Parseur Modbus désactivé par défaut dans `suricata.yaml` | Activer `app-layer.protocols.modbus` et vérifier le port 502 |
| Suricata ne voit rien | Sonde dans son propre espace réseau, sans visibilité sur le trafic | Lancer Suricata avec `network_mode: container:lyo-fw01` (à vérifier en lab) |
| Horodatages incohérents entre sources | Conteneurs dans des fuseaux différents | Imposer `TZ=UTC` partout, convertir uniquement à l'affichage |
| Grafana accessible avec le mot de passe par défaut | Identifiants d'origine conservés | Mot de passe passé par variable d'environnement non versionnée |
| Poste qui rame, WSL tué | Mémoire WSL non bornée | Limiter la mémoire dans `.wslconfig`, ne pas lancer le lab 05 en même temps |
