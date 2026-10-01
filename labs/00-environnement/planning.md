# Lab 00 · Planning

Échéance : **S1**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | WSL et ressources | `free -h` reflète le plafond choisi | |
| 2 | Docker Engine et outils | `hello-world` sans `sudo`, chaque outil répond à `--version` | |
| 3 | Git signé et filets | Commit « Verified », faux secret refusé | |
| 4 | Dépôt et essai à froid | Aucun doublon, essai à froid chronométré | |

## Détail des séances

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
2. Rejouer [réplication](replication.md) sur une distribution WSL de test.
3. Compléter preuves et compte-rendu.

Point de contrôle : Aucun doublon, essai à froid chronométré.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-00-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-00): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
