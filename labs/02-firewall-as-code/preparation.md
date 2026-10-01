# Lab 02 · Préparation

## Contexte

Dans une usine, un pare-feu administré à la souris dérive en quelques mois : règles temporaires jamais retirées, doublons, aucune trace de qui a ouvert quoi. Le jour d'un audit IEC 62443 ou d'un incident, personne ne sait justifier une règle. Ce lab inverse la logique : la matrice de flux est la source de vérité, les règles en sont générées, et tout écart entre le pare-feu et Git est détecté.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Ansible (ansible-core) | Application des règles, rôle `nva` | Libre, 0 € | à figer au démarrage |
| Molecule + pilote Docker | Tests du rôle : converge, idempotence, verify | Libre, 0 € | à figer au démarrage |
| nftables dans un conteneur Debian | Moteur de pare-feu des sites | Libre, 0 € | à figer au démarrage |
| Python + PyYAML | Générateur matrice vers `policy.yml` | Libre, 0 € | à figer au démarrage |
| Docker Engine (WSL) et Compose | Sites et zones simulés | Libre, 0 € | à figer au démarrage |
| FortiGate-VM (bonus) | Même politique poussée sur FortiOS | Licence d'évaluation gratuite à fonctions limitées, conditions à vérifier sur le site Fortinet | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Moteur de pare-feu | nftables en conteneur | FortiGate-VM sous licence complète | nftables ; FortiGate en bonus |
| Exécution | Poste local (WSL) et runner GitHub | VM cloud | Local et CI |
| CI | GitHub Actions et GitLab CI (quotas gratuits) | Runners payants | Gratuit |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

## Prérequis

- Lab 00 validé (poste, Docker, pre-commit).
- Lab 01 : `secure-ci` disponible (sinon, contrôle qualité seul).
- Notions : modèle à états d'un pare-feu, NAT, zones.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| LYO, Usine HubLabs | 10.20.0.0/20 | P |
| LYO IT postes | 10.20.1.0/24 | P |
| LYO iDMZ (bastion, relais) | 10.20.8.0/24 | P |
| LYO OT contrôle (automates) | 10.20.11.0/24 | P |
| CLD, site virtuel | 10.20.48.0/20 | P |
| INT-MA / INT-ES | 10.20.64.0/20 / 10.20.80.0/20 | P |
| Transit des tunnels | 10.20.252.0/24 | P |
| Ports locaux du lab | 18020 à 18029 | P |

## Ressources machine

Environ 1 Go de RAM : quatre à six conteneurs légers.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
