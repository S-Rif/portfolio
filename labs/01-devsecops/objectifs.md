# Lab 01 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L01-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L01-O1 | Un secret introduit est bloqué avant le commit et en CI | Commit refusé par le hook gitleaks ; CI rouge sur le même faux jeton poussé avec `--no-verify` (sortie masquée) | À faire | |
| L01-O2 | Workflow réutilisable `secure-ci` : permissions minimales, actions épinglées par SHA | Appel depuis un autre lab sans copie, actionlint vert | À faire | |
| L01-O3 | Analyse statique du code et de l'IaC bloquante | Pipeline rouge sur une faille volontaire (Semgrep, Checkov), vert après correction | À faire | |
| L01-O4 | Image scannée sur son digest, blocage sur CRITICAL avec correctif disponible | Rapport Trivy, exceptions justifiées et datées | À faire | |
| L01-O5 | SBOM produit et attestation signée | Fichier SPDX JSON, attestation vérifiable sur le digest | À faire | |
| L01-O6 | Signature sans clé stockée, vérifiée sur l'identité du workflow | `cosign verify` réussi ; contre-preuve en échec avec une mauvaise identité | À faire | |
| L01-O7 | Équivalent GitLab CI inclus par un projet consommateur | Pipeline GitLab avec les mêmes contrôles bloquants | À faire | |
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
