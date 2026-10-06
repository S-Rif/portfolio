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

Sans --certificate-identity ni --certificate-oidc-issuer, cosign verify vérifie seulement que la signature est valide et que le certificat vient de Fulcio. Il ne vérifie pas qui a signé. Or n'importe qui peut obtenir un certificat Fulcio valide pour sa propre identité GitLab ou GitHub : un attaquant signe sa propre image et la vérification réussit quand même. En imposant l'identité (mon projet, mon fichier .gitlab-ci.yml, ma branche) et l'émetteur (gitlab.com), seule une signature produite par mon pipeline est acceptée. Ma contre-preuve le montre : avec une mauvaise identité, cosign refuse (« none of the expected identities »).

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

Sans `--certificate-identity` ni `--certificate-oidc-issuer`, `cosign verify` vérifie seulement que la signature est valide
et que le certificat vient de Fulcio. Il ne vérifie pas qui a signé. N'importe qui peut obtenir un certificat Fulcio valide
pour sa propre identité GitLab ou GitHub : un attaquant signe sa propre image et la vérification réussit quand même.
En imposant l'identité (mon projet, mon fichier `.gitlab-ci.yml`, ma branche) et l'émetteur (`gitlab.com`), seule une signature
produite par mon pipeline est acceptée. Ma contre-preuve le montre : avec une mauvaise identité, cosign refuse
(« none of the expected identities »).

## Séance 2 · 2026-10-06

### Résultats

O3 validé (réserve : rouge Checkov prouvé en local, P13). O4 à O7 validés par le pipeline #2916825247 (commit 5ae0745) : `signature` dépend de `sbom`, SPDX et attestation vérifiée, identité erronée refusée, rapport Trivy en artefact. O7 : inclusion locale du gabarit, voir ADR-001.

### Blocages et leçons

- Logs enregistrés comme pages web : prendre le texte brut ou une capture recadrée.
- Un script qui ouvre un fichier en écriture avant de le lire le vide : lire en mémoire, puis écrire.
- Un bloc collé avec des espaces avant le terminateur reste en attente : coller sans indentation.
- Gitleaks a signalé la valeur `GPG_KEY` de l'image de base dans le rapport Trivy : valeur masquée dans la copie versée.

### Reste à faire

- O2 : workflow GitHub `devsecops` (étape 01-8, P10) et workflow réutilisable.
- O8 : règle `SITE_INTL`.
