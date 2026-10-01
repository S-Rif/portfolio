# Lab 05 · Planning

Échéance : **S8**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | kind et Argo CD | Application `Synced` et `Healthy` | |
| 2 | Politiques et garde-fous | Refus et alerte reproduits | |
| 3 | Overlay international et retour arrière | Revert restauré par Argo CD | |
| 4 | Bascule vers AKS puis destroy | Synchronisation sur AKS, aucune ressource restante | |

## Détail des séances

### Séance 1 : kind et Argo CD

1. Cluster kind sans CNI par défaut, puis Cilium.
2. Argo CD et une application pointant sur `gitops/overlays/kind`.
3. Déployer l'application de supervision par commit.

Point de contrôle : Application `Synced` et `Healthy`.

### Séance 2 : Politiques et garde-fous

1. Politiques réseau Cilium : autoriser seulement les dépendances.
2. Kyverno : signature requise, identité du workflow du lab 01.
3. Falco : règle shell dans un conteneur.

Point de contrôle : Refus et alerte reproduits.

### Séance 3 : Overlay international et retour arrière

1. Overlay `site-int` (TZ, langue, configuration).
2. Changement de version puis `git revert`.
3. Preuves.

Point de contrôle : Revert restauré par Argo CD.

### Séance 4 : Bascule vers AKS puis destroy

1. AKS dans le spoke prod (module du lab 04), budget vérifié.
2. Overlay `aks`, synchronisation.
3. Destroy et contrôle par étiquette.

Point de contrôle : Synchronisation sur AKS, aucune ressource restante.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Destroy vérifié en fin de chaque séance (aucune ressource `projet=hublabs` restante).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-05-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-05): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
