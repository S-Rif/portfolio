# Lab 06 · Préparation

## Contexte

Quand un service tiers fuit, les comptes des collaborateurs qui l'utilisent deviennent une porte d'entrée, y compris vers l'usine si un mot de passe est réutilisé. Breach Watch suit une liste de services par utilisateur, surveille les fuites publiées et notifie. La contrainte de conception est stricte : l'application ne stocke et ne transmet jamais un mot de passe, ni même son empreinte complète.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Python, FastAPI | API et veille planifiée | Libre, 0 € | à figer au démarrage |
| SQLite puis PostgreSQL | Services suivis et abonnements push | Libre, 0 € | à figer au démarrage |
| API publique de liste des fuites (Have I Been Pwned) | Source de veille | Gratuite sans clé pour la liste des fuites ; conditions d'usage et attribution à vérifier | à figer au démarrage |
| Pwned Passwords (plage par préfixe) | Vérification d'un mot de passe par k-anonymat | Gratuite | à figer au démarrage |
| Web Push (clés VAPID) | Notifications | Gratuit | à figer au démarrage |
| Mailpit | Serveur SMTP de test local | Libre, 0 € | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Notifications | Web Push et e-mail local | SMS par un fournisseur | Push et e-mail ; SMS en backlog |
| Recherche par compte | Non (liste des fuites par service) | API payante par adresse e-mail | Non retenu |
| HTTPS pour le téléphone | Tunnel gratuit ou certificat local (à vérifier) | Domaine et hébergement | Gratuit |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

## Prérequis

- Labs 00 et 01 validés ; lab 05 pour le déploiement GitOps.
- Un iPhone (iOS 16.4 ou plus pour le push d'une PWA) ou un Android pour la preuve d'installation.
- Notions : fonctions de hachage, HTTPS, service worker.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| Domaine fictif | `hublabs.example` | P |
| Domaines du site international | `ma.hublabs.example` / `es.hublabs.example` | P |
| Ports locaux du lab (API, Mailpit) | 18060 à 18069 | P |

## Ressources machine

Moins de 1 Go de RAM en Docker Compose.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
