# Méthode des labs

## Cycle d'un lab

1. **Cadrer** : `objectifs.md` d'abord. Chaque objectif est mesurable et a sa preuve attendue.
2. **Préparer** : moyens, versions, coût, valeurs du référentiel (`preparation.md`).
3. **Planifier** : séances de 90 minutes maximum, chacune avec un point de contrôle (`planning.md`).
4. **Exécuter** : une séance, un commit. Jamais de nouveau sujet tant que le livrable minimal n'est pas commité.
5. **Prouver** : sortie de commande ou capture dans `preuves/`, référencée dans `preuves/README.md`.
6. **Raconter** : `compte-rendu.md`, incidents en post-mortem sans blâme, réponse à la question de senior.
7. **Livrer** : tag `lab-NN-vX.Y.Z` sur `main`, publié par le workflow `release`.

## Définition de « terminé »

Un lab est terminé quand tous ses objectifs sont validés sur preuve, que le workflow `labs` est vert pour ce lab, qu'il a été rejoué sur un clone propre, que les ressources payantes sont détruites et que le compte-rendu est rempli.

## Règles de preuve

- Un objectif passe à « Validé » uniquement si sa ligne dans `preuves/README.md` contient une preuve. Le workflow `qualite` le vérifie.
- Le texte (sortie de commande) est préféré à la capture : il se relit, se cherche et se compare.
- Jamais de secret, de jeton, d'adresse e-mail ni de donnée réelle dans une preuve.

## Niveaux de compétence

| Niveau | Signification |
| --- | --- |
| 0 | Aucune notion |
| 1 | A déjà vu |
| 2 | Sait faire avec support |
| 3 | Sait faire seul et expliquer |
| 4 | Sait le défendre devant un client et l'enseigner |

## Contrat d'implémentation

Il n'y a aucun script dans ce dépôt : l'automatisation passe par les workflows GitHub Actions. Le workflow `labs` détecte ce qu'un lab contient et l'exécute :

| Élément dans le dossier du lab | Ce que fait le workflow |
| --- | --- |
| Fichiers du contrat | Vérifie leur présence, affiche le tableau de bord des objectifs |
| `compose.yaml` | `docker compose config`, montage, service `tests` s'il existe, démontage systématique |
| `terraform/` | `terraform fmt -check`, puis `init -backend=false` et `validate` par module, jamais d'`apply` |
| `ansible/` | `ansible-lint` |
| `gitops/overlays/*/` | Rendu Kustomize de chaque overlay |

L'option site international passe par l'entrée `site_intl` (`aucun`, `ma`, `es`). Elle devient la variable `SITE_INTL` et active le profil Compose `intl-ma` ou `intl-es`.

## Budget

- Plafond global : 100 € pour l'ensemble du parcours.
- Chaque lab a une version gratuite complète ; l'option payante est plafonnée à 15–20 €.
- Un seul lab payant actif à la fois, budget et alerte créés avant le premier déploiement.
- Toute ressource cloud est détruite en fin de séance ; la destruction fait partie des preuves.

## Nommage

- Dossiers et fichiers en minuscules ASCII, sans accent ni espace : `labs/02-firewall-as-code/`.
- Commits au format Conventional Commits : `docs(lab-02): séance 1`, `feat(lab-02): générateur de politique`, `ci(hub): ...`.
- Tags : `lab-NN-vX.Y.Z` pour un lab, `hub-vX.Y.Z` pour le portfolio.
