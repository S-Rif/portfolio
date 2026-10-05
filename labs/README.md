# Labs

Neuf labs, du poste de travail à l'usine de déploiement, tous sur le fil rouge fictif HubLabs. Ce fichier est la porte d'entrée de la partie **Labs** : tableau de bord, contrat commun et méthode. La vitrine est le [README racine](../README.md), la démo vit dans [`demo/`](../demo/README.md).

## Tableau de bord

Ordre de réalisation : le 07 passe avant le 05, car il réutilise l'état distant du 04. Le 08 se fait en dernier : il ne bloque aucun autre lab.

| # | Lab | Séances | Coût | S'appuie sur | Statut |
| --- | --- | --- | --- | --- | --- |
| 00 | [Environnement](00-environnement/README.md) | 4 | 0 € | — | À faire |
| 01 | [DevSecOps](01-devsecops/README.md) | 4 | 0 € | 00 (poste, Git signé, pre-commit) | À faire |
| 02 | [Firewall as Code](02-firewall-as-code/README.md) | 4 | 0 € | 01 (`secure-ci`) | À faire |
| 03 | [Segmentation OT/IT](03-segmentation-ot-it/README.md) | 4 | 0 € | 02 (`policy.yml`, rôle `nva`) | À faire |
| 04 | [Landing zone Azure](04-landing-zone-azure/README.md) | 4 | ≤ 15–20 €, à mesurer | 02 (rôle `nva`) | À faire |
| 07 | [IaC multi-cloud](07-iac-multicloud/README.md) | 4 | ≤ 15–20 €, à mesurer | 02 (rôle `nva`), 04 (OIDC, état distant) | À faire |
| 05 | [Kubernetes GitOps](05-kubernetes-gitops/README.md) | 4 | 0 € sur kind, AKS à mesurer | 03 (Loki, Grafana), 04 (spoke prod, état distant) | À faire |
| 06 | [Breach Watch](06-breach-watch/README.md) | 4 | 0 € | 05 (déploiement GitOps ; Docker Compose en solo) | À faire |
| 08 | [Usine de déploiement on-prem](08-usine-deploiement/README.md) | 4 | 0 € | 01 (contrôles CI), 02 (rôles Ansible) | À faire |

Le statut détaillé de chaque objectif vit dans le fichier `objectifs.md` du lab. Le résumé de chaque exécution du workflow `labs` affiche le nombre d'objectifs validés.

## Contrat d'un lab

Cinq éléments, toujours les mêmes. Le workflow `qualite` refuse un lab incomplet.

| Élément | Contenu | Lu par |
| --- | --- | --- |
| `README.md` | Problème métier, schéma, ce que ça démontre, exécution, scénario de démo | Recruteur, client, relecteur |
| `objectifs.md` | Objectifs mesurables **et** leurs preuves, hors périmètre, compétences, question de connaissance | Moi, relecteur |
| `guide.md` | Préparer (outils, versions, coût), planifier (séances), rejouer (étapes, pannes fréquentes) | Moi, étudiant qui rejoue |
| `journal.md` | Décisions, coûts réels, incidents, réponse à la question de connaissance | Moi, entretien |
| `adr/` | Décisions d'architecture (`ADR-001.md` au minimum) | Relecteur senior |

Les fichiers de preuve vont dans `preuves/`. Le code du lab (`compose.yaml`, `terraform/`, `ansible/`, `gitops/`, `gitlab/`) s'ajoute à côté, au fil des séances.

## Méthode

### Cycle d'un lab

1. **Cadrer** : `objectifs.md` d'abord. Chaque objectif est mesurable et a sa preuve attendue.
2. **Préparer** : moyens, versions, coût, valeurs du référentiel (`guide.md`, section Préparer).
3. **Planifier** : séances de 90 minutes maximum, chacune avec un point de contrôle (section Planifier).
4. **Exécuter** : une séance, un commit. Jamais de nouveau sujet tant que le livrable minimal n'est pas commité.
5. **Prouver** : sortie de commande ou capture dans `preuves/`, liée dans la colonne Preuve de `objectifs.md`.
6. **Raconter** : `journal.md`, incidents en post-mortem sans blâme, réponse à la question de connaissance.
7. **Livrer** : tag `lab-NN-v1.0.0` sur `main`, publié par le workflow `release`.

### Définition de « terminé »

Un lab est terminé quand tous ses objectifs sont validés sur preuve, que le workflow `labs` est vert pour ce lab sur `main`, qu'il a été rejoué sur un clone propre, que les ressources payantes sont détruites, que le journal est rempli et que le tag `lab-NN-v1.0.0` est poussé.

### Après chaque séance

Remplir la colonne « Fait le » du planning, lier les preuves, compléter le journal, puis un commit `docs(lab-NN): séance N`. Si une séance déborde, la suivante commence par le livrable minimal commité, jamais par un nouveau sujet.

### Règles de preuve

- Un objectif passe à « Validé » uniquement si sa colonne Preuve est remplie. Le workflow `qualite` le vérifie, et la vérification des liens internes échoue si le fichier lié n'existe pas.
- Le texte (sortie de commande) est préféré à la capture : il se relit, se cherche et se compare.
- Jamais de secret, de jeton, d'adresse e-mail ni de donnée réelle dans une preuve.

### Niveaux de compétence

| Niveau | Signification |
| --- | --- |
| 0 | Aucune notion |
| 1 | A déjà vu |
| 2 | Sait faire avec support |
| 3 | Sait faire seul et expliquer |
| 4 | Sait le défendre devant un client et l'enseigner |

### Ce que le workflow `labs` exécute

L'automatisation du dépôt passe uniquement par les workflows GitHub Actions. Le workflow `labs` détecte ce qu'un lab contient et l'exécute :

| Élément dans le dossier du lab | Ce que fait le workflow |
| --- | --- |
| `objectifs.md` | Affiche le tableau de bord des objectifs |
| `compose.yaml` | `docker compose config`, montage, service `tests` s'il existe, démontage systématique |
| `terraform/` | `terraform fmt -check`, puis `init -backend=false` et `validate` par module, jamais d'`apply` |
| `ansible/` | `ansible-lint` |
| `gitops/overlays/*/` | Rendu Kustomize de chaque overlay |

L'option site international passe par l'entrée `site_intl` (`aucun`, `ma`, `es`). Elle devient la variable `SITE_INTL` et active le profil Compose `intl-ma` ou `intl-es`.

Le code qu'un lab construit ou déploie (générateur Python du lab 02, scripts de maintenance du lab 08) est un livrable du lab, pas de l'outillage du dépôt : la règle « aucun script d'automatisation » ne s'applique pas à lui.

### Budget

- Plafond global : 100 € pour l'ensemble du parcours.
- Chaque lab a une version gratuite complète ; l'option payante est plafonnée à 15–20 €.
- Un seul lab payant actif à la fois, budget et alerte créés avant le premier déploiement.
- Toute ressource cloud est détruite en fin de séance ; la destruction fait partie des preuves.

### Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC, JWT) pour la CI.
- `pre-commit` actif avant le premier commit du lab.

## Créer un lab

1. Copier [`_gabarit/`](_gabarit/README.md) vers `labs/NN-nom-du-lab/` (minuscules, ASCII, sans accent).
2. Remplir chaque `À REMPLIR`, en commençant par `objectifs.md`.
3. Ajouter la ligne du lab au tableau de bord ci-dessus, au README racine et au choix `lab` du workflow `labs`.
4. Suivre la méthode : une séance, un commit, une preuve.

Conventions de nommage, de commit et de version : [CONTRIBUTING.md](../CONTRIBUTING.md).
