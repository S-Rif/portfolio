# Lab 00 · Préparation

## Contexte

Sans poste maîtrisé, chaque lab commence par une heure de dépannage et chaque résultat dépend d'un état de machine que personne ne connaît. Ce lab fixe un environnement documenté, versionné et vérifiable : n'importe quel étudiant obtient le même poste en moins d'une heure, et chaque outil a sa version relevée en preuve.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| WSL2 + Ubuntu 24.04 | Système Linux du poste | Gratuit | à figer au démarrage |
| Docker Engine | Conteneurs des labs | Libre, 0 € | à figer au démarrage |
| Git et GitHub CLI (`gh`) | Versionnage, dépôt, workflows | Libre, 0 € | à figer au démarrage |
| pre-commit et gitleaks | Filets avant commit | Libre, 0 € | à figer au démarrage |
| VS Code et extension WSL | Éditeur | Gratuit | à figer au démarrage |
| Terraform, Ansible, kubectl, kind, Azure CLI, AWS CLI | Outils des labs suivants | Libres, 0 € | à figer au démarrage |
| Cisco Packet Tracer (Windows) | Maquettes réseau (lab 03) | Gratuit avec un compte Cisco Networking Academy | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Conteneurs | Docker Engine dans WSL | Docker Desktop (licence payante en entreprise au-delà d'un seuil, à vérifier) | Docker Engine |
| Signature des commits | Clé SSH existante | Clé GPG sur support matériel | SSH |
| Éditeur | VS Code | IDE commerciaux | VS Code |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

## Prérequis

- Windows 11 avec la virtualisation activée.
- Compte GitHub (`S-Rif`) et clé SSH déclarée.
- 8 Go de RAM conseillés si les labs 03 et 05 tournent en local.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| Dossier des dépôts | `~/portfolio` | P |
| Dépôt | `S-Rif/portfolio` | P |
| Identité Git | adresse noreply GitHub uniquement | P |
| Domaine fictif | `hublabs.example` | P |

## Ressources machine

Plafond WSL conseillé : 6 à 8 Go de RAM et 4 cœurs dans `.wslconfig`.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
