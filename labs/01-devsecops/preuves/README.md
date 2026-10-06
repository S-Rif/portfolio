# Lab 01 · Registre des preuves

Séance du 2026-10-05 au 2026-10-06, branche `sprint/labs`. Image de référence des preuves P1, P5, P6, P7 et P8 : digest `a6d910e5`, pipeline GitLab #2913848718, commit `7feb8c7a`.

## Preuves fournies

| ID | Preuve | Fichier | Objectif | Commit |
| --- | --- | --- | --- | --- |
| P1 | Ligne du pipeline vert, 2 min 06 | `L01-P1-gitlab-historique-pipelines-2026-10-05.png` | O3, O7 | e1efc40 |
| P3a | Pipeline #2913518528 : analyse rouge, stages suivants non lancés | `L01-P3a-gitlab-pipeline-rouge-semgrep-trivyfs-2026-10-05.png` | O3 | f2b8f2e |
| P3b | Journal brut du job semgrep rouge | `L01-P3b-semgrep-ci-rouge-2026-10-05.txt` | O3 | f2b8f2e |
| P3c | Journal brut du job trivy-fs rouge (CVE-2020-14343) | `L01-P3c-trivyfs-ci-rouge-2026-10-05.txt` | O3, O4 | f2b8f2e |
| P3d | Journal brut du job trivy-image rouge (libpcre2) | `L01-P3d-trivy-image-ci-rouge-libpcre2-2026-10-05.txt` | O4 | f2b8f2e |
| P4 | Diff des quatre commits de correction | `L01-P4-diff-corrections-2026-10-05.txt` | O3, O4 | 0f42cea |
| P5 | Graphe des 8 jobs dans 5 stages | `L01-P5-gitlab-graphe-jobs-2026-10-05.png` | O3, O7 | e1efc40 |
| P6 | Image au registre, tag `7feb8c7a`, digest `a6d910e` | `L01-P6-gitlab-registre-image-digest-2026-10-05.png` | O4, O6 | e1efc40 |
| P7 | SBOM CycloneDX 1.7 généré par syft 1.54.0 | `L01-P7-sbom-2026-10-05.cdx.json` | O5 | 307b094 |
| P8 | `cosign verify` réussi, identité du workflow | `L01-P8-cosign-verify-2026-10-06.txt` | O6 | 307b094 |
| P9a | Hook gitleaks en échec sur le faux secret | `L01-P9a-hook-local-gitleaks-2026-10-06.png` | O1 | ec802c9 |
| P9b | Pipeline rouge, stages suivants non lancés | `L01-P9b-pipeline-rouge-2026-10-06.png` | O1 | ec802c9 |
| P9c | Rapport gitleaks de la CI, adresse masquée | `L01-P9c-rapport-gitleaks-ci-2026-10-06.json` | O1 | d8afed3 |
| P13 | Rejeu local des scanners avant (1b326ba) et après correction | `L01-P13-scans-locaux-avant-apres-2026-10-06.txt` | O3 | 23f1f5b |
| P14 | Rapport Trivy JSON de l'image, digest scanné, aucun HIGH ni CRITICAL corrigeable (pipeline #2916825247) | `L01-P14-trivy-image-rapport-2026-10-06.json` | O4 | 4014e8a |
| P15 | Extrait du SPDX de l'image ; le fichier complet est l'artefact du pipeline, expiré après 30 jours | `L01-P15-sbom-spdx-extrait-2026-10-06.json` | O5 | 4014e8a |
| P16 | Journal du job signature : signature, vérification, attestation SPDX vérifiée, identité erronée refusée (digest c5634ab3) | `L01-P16-signature-attestation-contrepreuve-2026-10-06.txt` | O5, O6 | 4014e8a |

## Preuves non obtenues

| ID | Preuve attendue | Statut |
| --- | --- | --- |
| P2 | Rejeu local des trois scanners en code 1 | Couverte par P13 |
| P3 | Pipeline rouge Semgrep, Checkov et Trivy | Partielle : Semgrep et Trivy-fs rouges en CI (P3a à P3c) ; Checkov rouge en local seulement (P13), son job CI avait été annulé |
| P10 | Rejeu GitHub du contrôle DevSecOps | Non obtenue : aucun workflow dédié |

## Historique à connaître

- Le commit `20ed416` contenait un faux P8 (message d'erreur), remplacé par `307b094`.
- Le message de `28f6d9d` annonce P9 mais ne contient que le changement de mode du SBOM.
- Le message de `0f42cea` annonce P1, P5, P6 et P9c mais ne contient que P4.
- Le pipeline #2916825247 (commit 5ae0745) ajoute SPDX, attestation et contre-preuve d'identité ; `signature` dépend désormais de `sbom` (BLO-E corrigé ; la cause exacte sur #2913784605 reste une déduction).
- P14 : les valeurs `GPG_KEY` de l'image de base (empreinte publique d'une clé de signature) sont masquées dans la copie versée, faux positif de gitleaks sur le rapport Trivy.
