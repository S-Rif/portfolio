# Lab 07 · Planning

Échéance : **S6–S7**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Interface de module commune | Interface documentée, plan Azure propre | |
| 2 | Implémentation AWS et OIDC | Plan AWS par le pipeline, aucune clé | |
| 3 | Interconnexion IPsec | Ping inter-cloud capturé | |
| 4 | Option internationale, coûts, destroy | Coût consigné, aucune ressource restante | |

## Détail des séances

### Séance 1 : Interface de module commune

1. Définir les entrées (nom, plage, région, étiquettes) et les sorties (réseau, IP publique de la NVA).
2. Implémentation Azure en réutilisant le lab 04.
3. Plan Azure propre.

Point de contrôle : Interface documentée, plan Azure propre.

### Séance 2 : Implémentation AWS et OIDC

1. Rôle IAM avec confiance OIDC limitée au dépôt et à la branche.
2. VPC, sous-réseau, groupe de sécurité, NVA.
3. Plan AWS propre via le pipeline.

Point de contrôle : Plan AWS par le pipeline, aucune clé.

### Séance 3 : Interconnexion IPsec

1. Rôle `nva` du lab 02 appliqué des deux côtés.
2. Désactiver le contrôle source/destination côté AWS, transfert IP côté Azure.
3. Ping inter-cloud, puis destroy.

Point de contrôle : Ping inter-cloud capturé.

### Séance 4 : Option internationale, coûts, destroy

1. `SITE_INTL=es` : régions espagnoles.
2. Rapports de coût par étiquette.
3. Destroy complet et contrôle des deux côtés.

Point de contrôle : Coût consigné, aucune ressource restante.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Destroy vérifié en fin de chaque séance (aucune ressource `projet=hublabs` restante).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-07-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-07): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
