# Lab NN · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| À REMPLIR | À REMPLIR | À REMPLIR | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| À REMPLIR | À REMPLIR | À REMPLIR | À REMPLIR |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- À REMPLIR

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| À REMPLIR | À REMPLIR | P |

### Ressources machine

À REMPLIR

## Planifier

À REMPLIR séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-NN): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | À REMPLIR | À REMPLIR | |

### Séance 1 : À REMPLIR

1. À REMPLIR

Point de contrôle : À REMPLIR.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/NN-nom-du-lab docs/referentiel
cd labs/NN-nom-du-lab
docker compose up -d --wait                           # montage
docker compose run --rm tests                         # un test par objectif
COMPOSE_PROFILES=intl-ma docker compose up -d --wait  # variante site international
docker compose down -v --remove-orphans               # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=NN`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | À REMPLIR | |
| Objectifs prouvés | 2 sur 2 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| À REMPLIR | À REMPLIR | À REMPLIR |
