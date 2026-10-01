# Lab 06 · Rejouer de zéro

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Labs 00 et 01 validés ; lab 05 pour le déploiement GitOps.
- Un iPhone (iOS 16.4 ou plus pour le push d'une PWA) ou un Android pour la preuve d'installation.
- Notions : fonctions de hachage, HTTPS, service worker.

## Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/06-breach-watch docs/referentiel
cd labs/06-breach-watch
docker compose up -d --wait                           # montage
docker compose run --rm tests                         # un test par objectif
COMPOSE_PROFILES=intl-ma docker compose up -d --wait  # variante site international
docker compose down -v --remove-orphans               # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=06`, puis `gh run watch`.

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
| Aucune réponse de l'API de fuites | En-tête `User-Agent` absent, exigé par l'API | Ajouter un `User-Agent` identifiant l'application |
| Pas de notification sur iPhone | PWA ouverte dans Safari sans être installée, ou iOS trop ancien | Ajouter à l'écran d'accueil, puis demander la permission |
| Permission de notification refusée d'office | Demande lancée sans action de l'utilisateur | Déclencher la demande sur un clic |
| Ancienne version affichée après déploiement | Service worker qui sert le cache | Versionner le cache et gérer la mise à jour du service worker |
| Préfixe non trouvé alors que le mot de passe est connu | Empreinte en minuscules ou mal découpée | SHA-1 en hexadécimal majuscule, 5 caractères envoyés, 35 comparés localement |
