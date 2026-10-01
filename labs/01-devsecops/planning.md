# Lab 01 · Planning

Échéance : **S1 (MVP), S2 (complet)**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | gitleaks et pre-commit | Faux secret bloqué en local et en CI | |
| 2 | Semgrep et Checkov | Rouge puis vert, actionlint vert | |
| 3 | Trivy, Syft, Cosign | Signature vérifiée, contre-preuve en échec | |
| 4 | GitLab CI et politique de région | Mêmes contrôles sur GitLab, plan refusé hors région | |

## Détail des séances

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
3. Preuves et compte-rendu.

Point de contrôle : Mêmes contrôles sur GitLab, plan refusé hors région.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-01-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-01): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
