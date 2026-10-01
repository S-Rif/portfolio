# Lab 03 · Rejouer de zéro

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Labs 00 et 02 validés (le pare-feu de zone vient du lab 02).
- Packet Tracer installé sous Windows.
- Notions : modèle Purdue, ce qu'est un automate et un registre Modbus.

## Étapes

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

## Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 6 sur 6 | |
| Nettoyage | plus rien ne tourne | |

## Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Aucune alerte Modbus alors que le trafic passe | Parseur Modbus désactivé par défaut dans `suricata.yaml` | Activer `app-layer.protocols.modbus` et vérifier le port 502 |
| Suricata ne voit rien | Sonde dans son propre espace réseau, sans visibilité sur le trafic | Lancer Suricata avec `network_mode: container:lyo-fw01` (à vérifier en lab) |
| Horodatages incohérents entre sources | Conteneurs dans des fuseaux différents | Imposer `TZ=UTC` partout, convertir uniquement à l'affichage |
| Grafana accessible avec le mot de passe par défaut | Identifiants d'origine conservés | Mot de passe passé par variable d'environnement non versionnée |
| Poste qui rame, WSL tué | Mémoire WSL non bornée | Limiter la mémoire dans `.wslconfig`, ne pas lancer le lab 05 en même temps |
