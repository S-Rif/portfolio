# Lab 02 · Rejouer de zéro

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Lab 00 validé (poste, Docker, pre-commit).
- Lab 01 : `secure-ci` disponible (sinon, contrôle qualité seul).
- Notions : modèle à états d'un pare-feu, NAT, zones.

## Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/02-firewall-as-code docs/referentiel
cd labs/02-firewall-as-code
docker compose up -d --wait                           # montage
docker compose run --rm tests                         # un test par objectif
COMPOSE_PROFILES=intl-ma docker compose up -d --wait  # variante site international
docker compose down -v --remove-orphans               # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=02`, puis `gh run watch`.

## Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

## Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| `Operation not permitted` au chargement des règles | Conteneur lancé sans la capacité `NET_ADMIN` | Ajouter `cap_add: [NET_ADMIN]` au conteneur pare-feu, jamais `privileged` |
| Docker n'a plus de réseau sur le poste | Règles nftables appliquées sur l'hôte WSL au lieu du conteneur | N'appliquer les règles que dans l'espace réseau du conteneur ; redémarrer Docker pour restaurer ses règles |
| Les flux autorisés échouent dans un seul sens | Retour de trafic bloqué : pas de règle `ct state established,related accept` | Placer cette règle en tête de chaque chaîne filtrante |
| Ansible annonce `changed` à chaque passage | Ordre de rendu non déterministe dans le template | Trier les flux dans le générateur et dans le template |
| Un flux interdit « passe » le test | Le test confond refus du pare-feu et service absent | Démarrer un service à l'écoute sur la cible : seul le pare-feu doit expliquer l'échec |
