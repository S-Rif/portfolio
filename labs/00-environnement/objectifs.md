# Lab 00 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L00-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L00-O1 | WSL2 et Ubuntu 24.04 fonctionnent, systemd est le processus 1 | Sortie de `wsl --version`, `lsb_release -ds`, `ps -p 1 -o comm=` | À faire | |
| L00-O2 | Ressources de la VM WSL plafonnées et relevées (RAM, CPU, disque) | `.wslconfig` commenté, sortie de `free -h`, `nproc`, `df -h ~` | À faire | |
| L00-O3 | Docker Engine tourne dans WSL et démarre avec la VM | Sortie de `docker version` et `docker run --rm hello-world` sans `sudo` | À faire | |
| L00-O4 | Git configuré, accès SSH à GitHub, commits signés « Verified » | Sortie de `ssh -T git@github.com`, capture d'un commit « Verified » | À faire | |
| L00-O5 | Chaîne d'outils installée, versions relevées dans un fichier unique | `versions.txt` daté dans `preuves/` | À faire | |
| L00-O6 | Un faux secret est bloqué avant le commit | Sortie du commit refusé par le hook gitleaks | À faire | |
| L00-O7 | Dépôt `portfolio` cloné sous `~/portfolio`, aucun dépôt sous `/mnt/c`, aucun doublon | Sortie de `ls ~/portfolio` et `git remote get-url origin` | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Docker Desktop (écarté, voir l'ADR).
- Poste géré par une entreprise (proxy, inspection TLS, MDM) : cité dans les limites.
- Machines virtuelles lourdes (EVE-NG, GNS3).

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| WSL2 et administration Linux de base | 3 | Diagnostic d'un service qui ne démarre pas, sans aide |
| Docker Engine : service, groupe, réseau | 3 | Explication du socket et du groupe `docker` |
| Git : identité, signature, hygiène de l'historique | 3 | Commit « Verified » expliqué |
| Filets avant commit (pre-commit, gitleaks) | 2 | Faux secret bloqué et expliqué |

## Question de connaissance

Ton commit affiche « Verified ». Qu'est-ce que cela prouve exactement, et qu'est-ce que cela ne prouve pas : qui a écrit le code, sur quelle machine, et que se passe-t-il si ta clé fuit ?

Réponse rédigée dans le [journal](journal.md).
