# Lab 01 · Journal

> Tenu au fil des séances. Rien d'inventé : chaque affirmation renvoie à une preuve de [objectifs.md](objectifs.md).

## Résumé

En trois phrases : ce qui a été construit, ce qui est prouvé, ce qui reste.

## Décisions

| Date | Décision | Raison | Déclencheur de revue |
| --- | --- | --- | --- |
| | Voir [ADR-001](adr/ADR-001.md) | | |

## Écarts avec le référentiel

Valeurs P utilisées, confirmées ou corrigées contre le doc 00.

## Coût et durée

| Séance | Durée réelle | Coût réel | Nettoyage vérifié |
| --- | --- | --- | --- |
| 1 | | | |

## Incidents et leçons

| Symptôme | Cause réelle | Correctif | Leçon |
| --- | --- | --- | --- |
| | | | |

## Réponse à la question de connaissance

À rédiger.

## Ce que je montrerais en entretien

À rédiger.

## Séance 1 · 2026-10-05

Pipeline GitLab CI sécurisé sur `sprint/labs` : 8 jobs sur 8 verts (#2913848718). O1 validé, O3 à O7 en cours, O2 et O8 non commencés.

### Blocages et leçons

- Faux positif gitleaks sur l'empreinte publique de la clé de signature : allowlist ciblée (chemin et motif). Un `.gitleaksignore` non suivi masquait le test local.
- Corrections absentes du clone : relire `git diff --stat` avant de commiter.
- Tag d'image syft inexistant : lire le nom exact de l'image tirée dans le journal du job.
- Test du hook gitleaks avec `--files` invalide : le hook scanne les changements indexés.
- Preuve P8 erronée commitée puis remplacée : relire le contenu d'un fichier de preuve.
- Trois messages de commit ont annoncé plus que leur contenu : relire `git diff --cached --name-only` avant chaque commit.

### Points ouverts

- O2 et O8 : volets GitHub Actions et Terraform, à planifier.
- O5 : critère SPDX et attestation, ou critère à amender.
- O6 : contre-preuve avec une mauvaise identité.
- `signature` ne dépend pas de `sbom` : décision à prendre.

### Question de connaissance

Réponse à rédiger.
