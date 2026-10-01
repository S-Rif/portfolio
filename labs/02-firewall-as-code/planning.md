# Lab 02 · Planning

Échéance : **S2–S3**. 4 séances de 90 minutes maximum, chacune terminée par un commit.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Matrice vers politique | `policy.yml` régénéré identique, `nft -c` sans erreur | |
| 2 | Topologie et tests de flux | F01 à F10 vérifiés, code retour 0 | |
| 3 | Idempotence, dérive, CI | Second passage `changed=0`, dérive détectée | |
| 4 | Site CLD, option internationale, retour arrière | Option `ma` conforme, revert prouvé | |

## Détail des séances

### Séance 1 : Matrice vers politique

1. Écrire le générateur : lecture de `matrice-flux.md`, sortie `policy.yml` triée.
2. Créer le rôle `nva` et son template `nftables.conf.j2` (refus par défaut, suivi de connexion).
3. Valider la syntaxe avec `nft -c -f` dans un conteneur.

Point de contrôle : `policy.yml` régénéré identique, `nft -c` sans erreur.

### Séance 2 : Topologie et tests de flux

1. `compose.yaml` : `lyo-fw01`, poste IT, bastion, automate sur des réseaux Docker distincts.
2. Un test par flux : connexion attendue pour les autorisés, échec pour les interdits.
3. Exposer les tests comme service `tests` du `compose.yaml`, lancé par le workflow `labs`.

Point de contrôle : F01 à F10 vérifiés, code retour 0.

### Séance 3 : Idempotence, dérive, CI

1. Molecule : converge, idempotence, verify.
2. Test de dérive : comparer `nft list ruleset` au rendu attendu.
3. Vérifier le job du workflow `labs` sur un flux volontairement cassé.

Point de contrôle : Second passage `changed=0`, dérive détectée.

### Séance 4 : Site CLD, option internationale, retour arrière

1. Ajouter `cld-fw01` puis `int-ma-fw01` (profil Compose `intl-ma`).
2. Scénario de retour arrière : `git revert`, réapplication, tests.
3. Compléter preuves et compte-rendu.

Point de contrôle : Option `ma` conforme, revert prouvé.

## Définition de « terminé »

- Tous les objectifs de [objectifs.md](objectifs.md) validés sur preuve.
- Workflow `labs` vert pour ce lab sur `main`.
- Rejoué sur un clone propre ([réplication](replication.md)).
- Compte-rendu rempli, question de senior rédigée.
- Tag `lab-02-v1.0.0` poussé : le workflow `release` publie la version.

## Mise à jour

Après chaque séance : remplir la colonne « Fait le », ajouter les preuves, compléter le compte-rendu, puis un commit `docs(lab-02): séance N`.
Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.
