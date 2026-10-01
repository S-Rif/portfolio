# Lab 00 · Objectifs

## Mission

Avant le premier lab, le poste doit être prêt, identique d'une séance à l'autre et vérifiable par un tiers.

## Objectifs mesurables

Un objectif passe à « Validé » **uniquement sur preuve**, consignée dans [preuves](preuves/README.md) avec le commit associé. Le workflow `qualite` refuse un objectif « Validé » sans preuve.

| ID | Objectif mesurable | Preuve attendue | Statut |
| --- | --- | --- | --- |
| L00-O1 | WSL2 et Ubuntu 24.04 fonctionnent, systemd est le processus 1 | Sortie de `wsl --version`, `lsb_release -ds`, `ps -p 1 -o comm=` | À faire |
| L00-O2 | Ressources de la VM WSL plafonnées et relevées (RAM, CPU, disque) | `.wslconfig` commenté, sortie de `free -h`, `nproc`, `df -h ~` | À faire |
| L00-O3 | Docker Engine tourne dans WSL et démarre avec la VM | Sortie de `docker version` et `docker run --rm hello-world` sans `sudo` | À faire |
| L00-O4 | Git configuré, accès SSH à GitHub, commits signés « Verified » | Sortie de `ssh -T git@github.com`, capture d'un commit « Verified » | À faire |
| L00-O5 | Chaîne d'outils installée, versions relevées dans un fichier unique | `versions.txt` daté dans `preuves/` | À faire |
| L00-O6 | Un faux secret est bloqué avant le commit | Sortie du commit refusé par le hook gitleaks | À faire |
| L00-O7 | Dépôt `portfolio` cloné sous `~/portfolio`, aucun dépôt sous `/mnt/c`, aucun doublon | Sortie de `ls ~/portfolio` et `git remote get-url origin` | À faire |

Statuts possibles : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Docker Desktop (écarté, voir l'ADR).
- Poste géré par une entreprise (proxy, inspection TLS, MDM) : cité dans les limites.
- Machines virtuelles lourdes (EVE-NG, GNS3).

## Compétences visées

Échelle : 0 aucune notion, 1 a déjà vu, 2 sait faire avec support, 3 sait faire seul et expliquer, 4 sait le défendre devant un client et l'enseigner.

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| WSL2 et administration Linux de base | 3 | Diagnostic d'un service qui ne démarre pas, sans aide |
| Docker Engine : service, groupe, réseau | 3 | Explication du socket et du groupe `docker` |
| Git : identité, signature, hygiène de l'historique | 3 | Commit « Verified » expliqué |
| Filets avant commit (pre-commit, gitleaks) | 2 | Faux secret bloqué et expliqué |

## Question de senior

À préparer pour l'entretien, réponse écrite dans le [compte-rendu](compte-rendu.md) :

Ton commit affiche « Verified ». Qu'est-ce que cela prouve exactement, et qu'est-ce que cela ne prouve pas : qui a écrit le code, sur quelle machine, et que se passe-t-il si ta clé fuit ?
