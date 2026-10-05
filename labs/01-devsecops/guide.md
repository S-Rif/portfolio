# Lab 01 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| GitHub Actions | CI principale | Gratuit en public ; quota mensuel en privé (à vérifier) | à figer au démarrage |
| GitLab CI (GitLab.com) | CI secondaire | Offre gratuite avec quota de minutes (à vérifier) | à figer au démarrage |
| gitleaks | Détection de secrets | MIT, gratuit | à figer au démarrage |
| Semgrep Community Edition | Analyse statique du code | Moteur libre ; licence des jeux de règles à vérifier | à figer au démarrage |
| Checkov | Analyse de l'IaC | Apache 2.0, gratuit | à figer au démarrage |
| Trivy | Vulnérabilités de l'image | Apache 2.0, gratuit | à figer au démarrage |
| Syft | SBOM | Apache 2.0, gratuit | à figer au démarrage |
| Cosign (Sigstore) | Signature et attestation sans clé | Apache 2.0, instance publique gratuite | à figer au démarrage |
| GHCR | Registre d'images | Gratuit pour les images publiques | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Secrets | gitleaks | Secret scanning d'une offre entreprise | gitleaks |
| Code | Semgrep CE | Plateformes SAST commerciales | Semgrep CE |
| Images | Trivy | Scanners commerciaux | Trivy |
| Signature | Cosign sans clé, Sigstore public | Notation avec certificats d'entreprise, clé en HSM | Cosign sans clé |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- Lab 00 validé (Docker, Git signé, pre-commit).
- Projet GitLab de démonstration créé (pour L01-O7).
- Notions : syntaxe YAML des workflows, images Docker multi-étapes.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| Workflow réutilisable | `.github/workflows/secure-ci.yml` | P |
| Registre d'images | `ghcr.io/s-rif/portfolio` | P |
| Régions autorisées (base / Espagne) | francecentral / spaincentral | P |
| Ports locaux du lab | 18010 à 18019 | P |

### Ressources machine

Moins de 2 Go de RAM : construction d'image et scanners.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-01): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | gitleaks et pre-commit | Faux secret bloqué en local et en CI | |
| 2 | Semgrep et Checkov | Rouge puis vert, actionlint vert | |
| 3 | Trivy, Syft, Cosign | Signature vérifiée, contre-preuve en échec | |
| 4 | GitLab CI et politique de région | Mêmes contrôles sur GitLab, plan refusé hors région | |

### Séance 1 : gitleaks et pre-commit

1. Hook gitleaks local et scénario du faux secret.
2. Même contrôle en CI sur tout l'historique.
3. Exceptions par empreinte, justifiées.

Point de contrôle : Faux secret bloqué en local et en CI.

### Séance 2 : Semgrep et Checkov

1. Workflow réutilisable `secure-ci` (`on: workflow_call`), permissions minimales.
2. Faille volontaire dans le code et dans l'IaC.
3. Correction et retour au vert.

Point de contrôle : Rouge puis vert, actionlint vert.

### Séance 3 : Trivy, Syft, Cosign

1. Image de démonstration construite et scannée sur son digest.
2. SBOM SPDX JSON et attestation.
3. Signature sans clé, `cosign verify` et contre-preuve.

Point de contrôle : Signature vérifiée, contre-preuve en échec.

### Séance 4 : GitLab CI et politique de région

1. Template GitLab inclus par un projet consommateur.
2. Règle Checkov ou OPA sur les régions selon `SITE_INTL`.
3. Preuves et journal.

Point de contrôle : Mêmes contrôles sur GitLab, plan refusé hors région.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

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

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 8 sur 8 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Exécution de code inattendue dans la CI | Action tierce compromise via un tag réécrit | Épingler les actions par SHA de commit (cas réel : `tj-actions/changed-files`, mars 2025) |
| L'équipe désactive les contrôles | Faux positifs en série | Exceptions par empreinte, justifiées et datées ; jamais de désactivation globale |
| Pipeline rouge sans action possible | Faille sans correctif disponible | Bloquer CRITICAL **avec** correctif ; signaler le reste |
| Run rouge sans rapport avec le code | Limite de téléchargement de la base Trivy | Mettre la base en cache entre les runs (à vérifier en lab) |
| Un job compromis peut écrire partout | Permissions du jeton trop larges | `permissions:` minimales par job, `contents: read` par défaut |
