# Lab 08 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Terraform + provider `kreuzwerker/docker` | Réseau, runner, SonarQube, Vault, cibles, nginx | Libre, 0 € | à figer au démarrage |
| Terraform + provider `hashicorp/vault` | Authentification JWT, rôle et politique, en code | Libre, 0 € | à figer au démarrage |
| Ansible (ansible-core) | Utilisateur de service, venv, unités systemd, nginx | Libre, 0 € | à figer au démarrage |
| GitLab Runner (exécuteur Docker) | Exécute les jobs qui doivent voir le réseau de l'usine | Libre, 0 € | à figer au démarrage |
| GitLab.com (offre gratuite) | Projet, pipelines, jeton d'identité des jobs | 0 € dans les quotas gratuits | — |
| SonarQube Community | Analyse et quality gate | Libre, 0 € | à figer au démarrage |
| Vault (mode serveur de lab) | Secrets lus au moment du job | Libre, 0 € | à figer au démarrage |
| Cibles Ubuntu avec systemd (conteneurs) | `lyo-appdev01`, `lyo-appprd01` | Libre, 0 € | image à vérifier en lab |
| Node.js + Vue, nginx | Portail construit puis servi | Libre, 0 € | à figer au démarrage |
| MongoDB, PowerShell (`pwsh`) en conteneur | Bonus L08-O10 | Libre, 0 € | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Serveurs cibles | Conteneurs systemd dans WSL | VM on-prem ou cloud | Conteneurs |
| Secrets dans le pipeline | `id_tokens` + appel Vault dans le script du job | Mot-clé `secrets:` de GitLab (offre payante, à vérifier) | Gratuit |
| Qualité | SonarQube Community | Éditions Developer et au-delà | Community |
| Windows | `pwsh` en conteneur Linux | Windows Server sous licence | `pwsh` ; Windows Server hors périmètre |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- Lab 00 validé (poste, Docker, pre-commit).
- Lab 01 : contrôles GitLab CI disponibles (sinon, pipeline sans `secure-ci`).
- Lab 02 : rôles Ansible réutilisables (sinon, rôle autonome dans ce lab).
- Projet GitLab du hub et droit d'y créer un runner de projet.
- Notions : cycle de vie d'une unité systemd, authentification par jeton signé (JWT).

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| LYO IT serveurs (cibles, runner, outils) | 10.20.2.0/24 | P |
| INT-MA / INT-ES (option) | 10.20.64.0/20 / 10.20.80.0/20 | P |
| Équipements | `lyo-run01`, `lyo-sonar01`, `lyo-vault01`, `lyo-appdev01`, `lyo-appprd01` | P |
| Domaine du portail | `portail.lyo.hublabs.example` | P |
| Ports locaux du lab | 18080 à 18089 | P |

### Ressources machine

Environ 5 à 6 Go de RAM, dont 2 Go pour SonarQube. Ne pas faire tourner les labs 03 ou 05 en même temps. SonarQube exige `vm.max_map_count` à 524288 au moins dans la VM WSL.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-08): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Socle Terraform et runner | Destroy puis apply sans écart, runner « online » | |
| 2 | Template, matrice et quality gate | Pipeline de 20 jobs, gate rouge puis verte | |
| 3 | Vault et cibles systemd | Secret lu sans variable CI, `changed=0`, timers actifs | |
| 4 | Portail, rollback, ADR et clôture | Portail en 200, rollback N-1 prouvé, ADR accepté | |

### Séance 1 : Socle Terraform et runner

1. `terraform/socle` : réseau Docker, `lyo-run01`, `lyo-sonar01`, `lyo-vault01`, deux cibles, nginx.
2. Créer le runner de projet dans GitLab ; passer son jeton par variable d'environnement, jamais dans un fichier versionné.
3. `apply`, `destroy`, `apply`, puis `plan` : aucun changement.

Point de contrôle : Destroy puis apply sans écart, runner « online ».

### Séance 2 : Template, matrice et quality gate

1. `gitlab/deploiement.yml` : template de job, `include` depuis `.gitlab-ci.yml`, `parallel:matrix` sur `SCRIPT` et `ENV`, `tags` du runner local.
2. Dix scripts Python de démonstration, chacun avec ses tests.
3. Étape SonarQube avec attente du résultat de la gate ; défaut volontaire, puis correction.

Point de contrôle : Pipeline de 20 jobs, gate rouge puis verte.

### Séance 3 : Vault et cibles systemd

1. `terraform/vault` (second état) : authentification JWT liée au projet GitLab, rôle et politique en lecture seule.
2. Job : `id_tokens`, connexion à Vault, lecture du secret, valeur masquée.
3. Rôle Ansible : utilisateur de service, venv, unité `hublabs-<script>.service` et son `.timer`.

Point de contrôle : Secret lu sans variable CI, `changed=0`, timers actifs.

### Séance 4 : Portail, rollback, ADR et clôture

1. Construire le portail Vue dans le pipeline, le publier sur nginx dev puis prd.
2. Job de rollback : redéployer la version N-1 d'un script.
3. ADR-001 accepté, preuves et journal, puis bonus L08-O10 si le temps le permet.

Point de contrôle : Portail en 200, rollback N-1 prouvé, ADR accepté.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/08-usine-deploiement labs/02-firewall-as-code docs/referentiel
cd labs/08-usine-deploiement
sudo sysctl -w vm.max_map_count=524288                # exigé par SonarQube
read -rsp "Jeton du runner : " TF_VAR_runner_token && export TF_VAR_runner_token   # hors historique, jamais commité
terraform -chdir=terraform/socle init && terraform -chdir=terraform/socle apply
terraform -chdir=terraform/vault init && terraform -chdir=terraform/vault apply
# pousser vers GitLab : le pipeline tourne sur lyo-run01
terraform -chdir=terraform/vault destroy && terraform -chdir=terraform/socle destroy   # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=08`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Durée d'un pipeline complet (20 jobs) | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 9 sur 9 (+ bonus) | |
| Nettoyage | plus rien ne tourne, runner supprimé de GitLab | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| SonarQube s'arrête au démarrage : `vm.max_map_count [65530] is too low` | Limite du noyau de la VM WSL trop basse pour son moteur de recherche | `sudo sysctl -w vm.max_map_count=524288`, persistant via `/etc/sysctl.d/` |
| Le job ne joint ni Vault ni les cibles | Il tourne sur un runner partagé de gitlab.com | Ajouter les `tags` du runner local au template de job |
| Mot-clé `secrets:` refusé par GitLab | Fonction réservée à une offre payante (à vérifier) | `id_tokens` puis connexion JWT à Vault dans le script du job |
| Premier `apply` en échec sur le provider Vault | Vault n'existe pas encore quand le provider se configure | Deux états séparés : `socle` puis `vault` |
| systemd ne démarre pas dans la cible | Conteneur sans cgroups ni `/run` en tmpfs (à vérifier en lab) | Options cgroup et tmpfs de l'image systemd retenue, jamais `privileged` par défaut |
| Timer actif mais script jamais lancé | `OnCalendar` invalide ou timer non activé | `systemd-analyze calendar '<expr>'`, `systemctl enable --now <timer>` |
