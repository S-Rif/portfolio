# Changelog

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/), versions selon [SemVer](https://semver.org/lang/fr/). Les labs ont leurs propres tags `lab-NN-vX.Y.Z`.

## [0.2.0] - 2026-10-05

### Ajouté

- Lab 08 · Usine de déploiement on-prem : template GitLab CI pour N scripts sur deux environnements, runner self-hosted, quality gate SonarQube, secrets Vault par jeton d'identité, timers systemd, rollback.
- Dossier `demo/` : deux parcours de 10 minutes (Cloud et OT, Usine de déploiement), préparation et plan B.

### Modifié

- Contrat d'un lab ramené à cinq éléments : `README.md`, `objectifs.md` (objectifs et preuves), `guide.md` (préparer, planifier, rejouer), `journal.md`, `adr/`.
- Méthode fusionnée dans `labs/README.md` ; règles de sécurité et de budget écrites une seule fois.
- README racine recentré sur la vitrine ; planning en semaines retiré, remplacé par le nombre de séances par lab.
- « Question de senior » renommée « Question de connaissance ».
- Workflow `labs` autonome (choix `08` ajouté) ; contrôle des preuves sur la colonne Preuve de `objectifs.md`.
- `CONTRIBUTING.md` : branches courtes et pull request, conventions de version et liste des workflows.

### Supprimé

- Fichiers `preparation.md`, `planning.md`, `replication.md`, `compte-rendu.md` et `preuves/README.md` de chaque lab (contenu fusionné, doublons retirés).
- `labs/methode.md` et le workflow `lab-reutilisable.yml`.

## [0.1.0] - 2026-10-01

### Ajouté

- Dépôt `portfolio` repris de zéro : README, licence MIT, contribution, sécurité.
- Fiches des labs 00 à 07 au même contrat (README, objectifs, préparation, planning, réplication, compte-rendu, preuves, ADR), index, méthode et gabarits.
- Référentiel commun : adressage, matrice de flux, valeurs.
- Workflows `qualite`, `labs`, `lab-reutilisable`, `liens-externes` et `release` ; aucun script dans le dépôt.
