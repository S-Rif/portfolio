# Lab 01 · Préparation

## Contexte

Sans socle commun, chaque équipe réinvente sa CI : aucun contrôle de secrets partagé, images ni scannées ni signées, aucune traçabilité de ce qui tourne. Contraintes de la direction : 0 € de licence, aucun secret statique dans les dépôts ni dans la CI, un seul endroit à maintenir, et bloquer plutôt qu'alerter sur les risques majeurs, avec des exceptions tracées.

## Moyens

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

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Secrets | gitleaks | Secret scanning d'une offre entreprise | gitleaks |
| Code | Semgrep CE | Plateformes SAST commerciales | Semgrep CE |
| Images | Trivy | Scanners commerciaux | Trivy |
| Signature | Cosign sans clé, Sigstore public | Notation avec certificats d'entreprise, clé en HSM | Cosign sans clé |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

## Prérequis

- Lab 00 validé (Docker, Git signé, pre-commit).
- Projet GitLab de démonstration créé (pour L01-O7).
- Notions : syntaxe YAML des workflows, images Docker multi-étapes.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| Workflow réutilisable | `.github/workflows/secure-ci.yml` | P |
| Registre d'images | `ghcr.io/s-rif/portfolio` | P |
| Régions autorisées (base / Espagne) | francecentral / spaincentral | P |
| Ports locaux du lab | 18010 à 18019 | P |

## Ressources machine

Moins de 2 Go de RAM : construction d'image et scanners.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
