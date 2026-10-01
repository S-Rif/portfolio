# Lab 06 · Planning

Échéance : **S9**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | API et modèle de données | Test k-anonymat vert | |
| 2 | Veille et notifications | Alerte reçue sur fuite simulée | |
| 3 | PWA installable | PWA installée, notification reçue | |
| 4 | Option internationale et GitOps | Option `es` conforme, déploiement synchronisé | |

## Détail des séances

### Séance 1 : API et modèle de données

1. Modèle : utilisateur fictif, services suivis, abonnements push.
2. Vérification de mot de passe côté navigateur (SHA-1, préfixe de 5 caractères).
3. Test automatisé du contenu de la requête sortante (service `tests`).

Point de contrôle : Test k-anonymat vert.

### Séance 2 : Veille et notifications

1. Tâche planifiée qui lit la liste des fuites et compare aux services suivis.
2. Clés VAPID générées localement, hors Git.
3. Envoi push et e-mail vers Mailpit.

Point de contrôle : Alerte reçue sur fuite simulée.

### Séance 3 : PWA installable

1. Manifeste, service worker, icônes.
2. HTTPS pour le téléphone.
3. Installation sur iPhone et Android, preuve de push.

Point de contrôle : PWA installée, notification reçue.

### Séance 4 : Option internationale et GitOps

1. Libellés traduits, horodatage UTC (profil `intl-es`).
2. Manifestes dans le dossier GitOps du lab 05.
3. Preuves et compte-rendu.

Point de contrôle : Option `es` conforme, déploiement synchronisé.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-06-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-06): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
