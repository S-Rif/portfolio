# Lab 04 · Planning

Échéance : **S5**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Hub-spoke et état distant | Plan propre, plages conformes | |
| 2 | Site CLD et IPsec | Ping traversant le tunnel | |
| 3 | OIDC et pipeline | Apply réussi par le pipeline, aucun secret | |
| 4 | Garde-fous, destroy, option internationale | Refus de policy, alerte, plans identiques | |

## Détail des séances

### Séance 1 : Hub-spoke et état distant

1. Compte de stockage pour l'état, verrouillage par bail.
2. Modules réseau : hub, spokes, peerings dans les deux sens.
3. `terraform plan` local en lecture seule.

Point de contrôle : Plan propre, plages conformes.

### Séance 2 : Site CLD et IPsec

1. VNet CLD et deux NVA (rôle `nva` du lab 02 + strongSwan).
2. Routage utilisateur et transfert IP activé sur les cartes réseau.
3. Tunnel et ping CLD vers prod, puis destroy.

Point de contrôle : Ping traversant le tunnel.

### Séance 3 : OIDC et pipeline

1. Application Entra et identité fédérée limitée à `main` ou à un environnement protégé.
2. Workflow dédié : plan, puis apply avec approbation (environnement GitHub).
3. Supprimer tout secret de la CI.

Point de contrôle : Apply réussi par le pipeline, aucun secret.

### Séance 4 : Garde-fous, destroy, option internationale

1. Policies : régions, étiquettes ; budget et alerte.
2. Destroy puis apply, comparaison des plans.
3. Chiffrer l'option INT et la consigner.

Point de contrôle : Refus de policy, alerte, plans identiques.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Destroy vérifié en fin de chaque séance (aucune ressource `projet=hublabs` restante).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-04-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-04): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
