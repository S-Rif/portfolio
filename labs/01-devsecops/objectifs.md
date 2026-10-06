# Lab 01 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L01-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L01-O1 | Un secret introduit est bloqué avant le commit et en CI | Commit refusé par le hook gitleaks ; CI rouge sur le même faux jeton poussé avec `--no-verify` (sortie masquée) | Validé | [P9a](preuves/L01-P9a-hook-local-gitleaks-2026-10-06.png), [P9b](preuves/L01-P9b-pipeline-rouge-2026-10-06.png), [P9c](preuves/L01-P9c-rapport-gitleaks-ci-2026-10-06.json) · ec802c9, d8afed3 |
| L01-O2 | Workflow réutilisable `secure-ci` : permissions minimales, actions épinglées par SHA | Appel depuis un autre lab sans copie, actionlint vert | À faire | |
| L01-O3 | Analyse statique du code et de l'IaC bloquante | Pipeline rouge sur une faille volontaire (Semgrep, Checkov), vert après correction | Validé | [P3a](preuves/L01-P3a-gitlab-pipeline-rouge-semgrep-trivyfs-2026-10-05.png), [P3b](preuves/L01-P3b-semgrep-ci-rouge-2026-10-05.txt), [P3c](preuves/L01-P3c-trivyfs-ci-rouge-2026-10-05.txt) · f2b8f2e ; [P13](preuves/L01-P13-scans-locaux-avant-apres-2026-10-06.txt) · 23f1f5b ; [P4](preuves/L01-P4-diff-corrections-2026-10-05.txt) · 0f42cea ; vert : [P1](preuves/L01-P1-gitlab-historique-pipelines-2026-10-05.png), [P5](preuves/L01-P5-gitlab-graphe-jobs-2026-10-05.png) · e1efc40 ; réserve : rouge Checkov prouvé en local seulement, le job CI avait été annulé |
| L01-O4 | Image scannée sur son digest, blocage sur CRITICAL avec correctif disponible | Rapport Trivy, exceptions justifiées et datées | Validé | [P14](preuves/L01-P14-trivy-image-rapport-2026-10-06.json) · 4014e8a ; blocage prouvé : [P3d](preuves/L01-P3d-trivy-image-ci-rouge-libpcre2-2026-10-05.txt) · f2b8f2e ; correctif : [P4](preuves/L01-P4-diff-corrections-2026-10-05.txt) · 0f42cea ; aucune exception déclarée (pas de .trivyignore) ; la barrière bloque HIGH et CRITICAL, plus strict que le critère |
| L01-O5 | SBOM produit et attestation signée | Fichier SPDX JSON, attestation vérifiable sur le digest | Validé | [P15](preuves/L01-P15-sbom-spdx-extrait-2026-10-06.json) · 4014e8a (SPDX) ; [P16](preuves/L01-P16-signature-attestation-contrepreuve-2026-10-06.txt) · 4014e8a (attestation vérifiée sur le digest) ; [P7](preuves/L01-P7-sbom-2026-10-05.cdx.json) · 307b094 (CycloneDX, complément) |
| L01-O6 | Signature sans clé stockée, vérifiée sur l'identité du workflow | `cosign verify` réussi ; contre-preuve en échec avec une mauvaise identité | Validé | [P16](preuves/L01-P16-signature-attestation-contrepreuve-2026-10-06.txt) · 4014e8a : verify réussi, attestation vérifiée, identité erronée refusée ; [P8](preuves/L01-P8-cosign-verify-2026-10-06.txt) · 307b094 (verify sur le pipeline #2913848718) |
| L01-O7 | Équivalent GitLab CI inclus par un projet consommateur | Pipeline GitLab avec les mêmes contrôles bloquants | Validé | [P1](preuves/L01-P1-gitlab-historique-pipelines-2026-10-05.png), [P5](preuves/L01-P5-gitlab-graphe-jobs-2026-10-05.png) · e1efc40 ; [P3a](preuves/L01-P3a-gitlab-pipeline-rouge-semgrep-trivyfs-2026-10-05.png) · f2b8f2e ; [P9b](preuves/L01-P9b-pipeline-rouge-2026-10-06.png) · ec802c9 ; pipeline #2916825247 vert, 8 jobs ; inclusion locale du gabarit par le hub, voir [ADR-001](adr/ADR-001.md) (addendum) |
| L01-O8 | Règle de région selon `SITE_INTL` | Plan refusé hors région autorisée, accepté dans la bonne région | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Tests dynamiques (DAST) et tests d'intrusion.
- Détection à l'exécution (lab 05, Falco).
- Outils commerciaux (GitHub Advanced Security, SAST payants) : cités comme alternatives client.

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| GitHub Actions : workflows réutilisables, permissions, OIDC | 3 | Workflow expliqué ligne par ligne |
| GitLab CI : templates, composants | 2 | Projet consommateur fonctionnel |
| Sécurité de la chaîne logicielle : SBOM, signature, provenance | 3 | Vérification de signature expliquée |
| Triage de vulnérabilités et faux positifs | 3 | Exception justifiée et datée |

## Question de connaissance

Ta signature passe `cosign verify`. Que vérifies-tu réellement si tu omets `--certificate-identity` et `--certificate-oidc-issuer`, et pourquoi un attaquant pourrait-il alors produire une signature « valide » ?

Réponse rédigée dans le [journal](journal.md).
