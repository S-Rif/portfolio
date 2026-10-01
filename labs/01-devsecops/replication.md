# Lab 01 · Rejouer de zéro

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Lab 00 validé (Docker, Git signé, pre-commit).
- Projet GitLab de démonstration créé (pour L01-O7).
- Notions : syntaxe YAML des workflows, images Docker multi-étapes.

## Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/01-devsecops docs/referentiel
pre-commit run --all-files
gh workflow run labs -f lab=01
gh run watch
cosign verify ghcr.io/s-rif/portfolio/supervision@sha256:<digest> \
  --certificate-identity-regexp '^https://github.com/S-Rif/portfolio/' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=01`, puis `gh run watch`.

## Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 8 sur 8 | |
| Nettoyage | plus rien ne tourne | |

## Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Exécution de code inattendue dans la CI | Action tierce compromise via un tag réécrit | Épingler les actions par SHA de commit (cas réel : `tj-actions/changed-files`, mars 2025) |
| L'équipe désactive les contrôles | Faux positifs en série | Exceptions par empreinte, justifiées et datées ; jamais de désactivation globale |
| Pipeline rouge sans action possible | Faille sans correctif disponible | Bloquer CRITICAL **avec** correctif ; signaler le reste |
| Run rouge sans rapport avec le code | Limite de téléchargement de la base Trivy | Mettre la base en cache entre les runs (à vérifier en lab) |
| Un job compromis peut écrire partout | Permissions du jeton trop larges | `permissions:` minimales par job, `contents: read` par défaut |
