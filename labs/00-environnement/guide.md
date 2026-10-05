# Lab 00 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| WSL2 + Ubuntu 24.04 | Système Linux du poste | Gratuit | à figer au démarrage |
| Docker Engine | Conteneurs des labs | Libre, 0 € | à figer au démarrage |
| Git et GitHub CLI (`gh`) | Versionnage, dépôt, workflows | Libre, 0 € | à figer au démarrage |
| pre-commit et gitleaks | Filets avant commit | Libre, 0 € | à figer au démarrage |
| VS Code et extension WSL | Éditeur | Gratuit | à figer au démarrage |
| Terraform, Ansible, kubectl, kind, Azure CLI, AWS CLI | Outils des labs suivants | Libres, 0 € | à figer au démarrage |
| Cisco Packet Tracer (Windows) | Maquettes réseau (lab 03) | Gratuit avec un compte Cisco Networking Academy | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Conteneurs | Docker Engine dans WSL | Docker Desktop (licence payante en entreprise au-delà d'un seuil, à vérifier) | Docker Engine |
| Signature des commits | Clé SSH existante | Clé GPG sur support matériel | SSH |
| Éditeur | VS Code | IDE commerciaux | VS Code |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- Windows 11 avec la virtualisation activée.
- Compte GitHub (`S-Rif`) et clé SSH déclarée.
- 8 Go de RAM conseillés si les labs 03 et 05 tournent en local.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| Dossier des dépôts | `~/portfolio` | P |
| Dépôt | `S-Rif/portfolio` | P |
| Identité Git | adresse noreply GitHub uniquement | P |
| Domaine fictif | `hublabs.example` | P |

### Ressources machine

Plafond WSL conseillé : 6 à 8 Go de RAM et 4 cœurs dans `.wslconfig`.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-00): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | WSL et ressources | `free -h` reflète le plafond choisi | |
| 2 | Docker Engine et outils | `hello-world` sans `sudo`, chaque outil répond à `--version` | |
| 3 | Git signé et filets | Commit « Verified », faux secret refusé | |
| 4 | Dépôt et essai à froid | Aucun doublon, essai à froid chronométré | |

### Séance 1 : WSL et ressources

1. Vérifier WSL2, Ubuntu 24.04 et systemd en processus 1.
2. Écrire `.wslconfig` (mémoire, processeurs), puis `wsl --shutdown`.
3. Relever `free -h`, `nproc`, `df -h ~`.

Point de contrôle : `free -h` reflète le plafond choisi.

### Séance 2 : Docker Engine et outils

1. Installer Docker Engine depuis le dépôt officiel Docker.
2. Ajouter l'utilisateur au groupe `docker`, vérifier le démarrage avec la VM.
3. Installer la chaîne d'outils et écrire `versions.txt`.

Point de contrôle : `hello-world` sans `sudo`, chaque outil répond à `--version`.

### Séance 3 : Git signé et filets

1. Identité noreply, signature SSH des commits et des tags.
2. `pre-commit install` dans le dépôt.
3. Scénario du faux secret, puis suppression du fichier.

Point de contrôle : Commit « Verified », faux secret refusé.

### Séance 4 : Dépôt et essai à froid

1. Cloner `portfolio` sous `~/portfolio`.
2. Suivre la section [Rejouer](#rejouer) sur une distribution WSL de test.
3. Compléter preuves et journal.

Point de contrôle : Aucun doublon, essai à froid chronométré.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/00-environnement docs/referentiel
wsl --version                       # dans PowerShell
lsb_release -ds && ps -p 1 -o comm=
docker run --rm hello-world
ssh -T git@github.com
git log --show-signature -1
pre-commit run --all-files
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=00`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| `permission denied` sur `/var/run/docker.sock` | Utilisateur hors du groupe `docker` | `sudo usermod -aG docker $USER`, puis fermer et rouvrir la session WSL |
| Docker arrêté après `wsl --shutdown` | systemd inactif | `[boot]` puis `systemd=true` dans `/etc/wsl.conf`, puis `wsl --shutdown` |
| `git status` lent, scripts non exécutables | Dépôt sous `/mnt/c` (disque Windows partagé) | Travailler sous `~/portfolio` |
| Commits « Unverified » sur GitHub | Clé non déclarée en signature, ou e-mail du commit non rattaché au compte | `gh ssh-key add --type signing`, e-mail noreply |
| WSL consomme toute la mémoire | Aucun plafond | `memory=` dans `.wslconfig`, puis `wsl --shutdown` |
