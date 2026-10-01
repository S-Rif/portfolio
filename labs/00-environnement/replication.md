# Lab 00 · Rejouer de zéro

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Windows 11 avec la virtualisation activée.
- Compte GitHub (`S-Rif`) et clé SSH déclarée.
- 8 Go de RAM conseillés si les labs 03 et 05 tournent en local.

## Étapes

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

## Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

## Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| `permission denied` sur `/var/run/docker.sock` | Utilisateur hors du groupe `docker` | `sudo usermod -aG docker $USER`, puis fermer et rouvrir la session WSL |
| Docker arrêté après `wsl --shutdown` | systemd inactif | `[boot]` puis `systemd=true` dans `/etc/wsl.conf`, puis `wsl --shutdown` |
| `git status` lent, scripts non exécutables | Dépôt sous `/mnt/c` (disque Windows partagé) | Travailler sous `~/portfolio` |
| Commits « Unverified » sur GitHub | Clé non déclarée en signature, ou e-mail du commit non rattaché au compte | `gh ssh-key add --type signing`, e-mail noreply |
| WSL consomme toute la mémoire | Aucun plafond | `memory=` dans `.wslconfig`, puis `wsl --shutdown` |
