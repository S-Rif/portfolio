# Lab 04 · Préparation

## Contexte

Migrer une application de supervision vers Azure sans socle, c'est empiler des ressources nommées au hasard, ouvertes sur Internet et payées par oubli. Une landing zone fixe les règles avant la première ressource : réseau hub-spoke, régions autorisées, étiquettes obligatoires, budget, et un déploiement qui passe par un pipeline sans secret stocké.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Terraform et fournisseur azurerm | Socle complet en code | Libre, 0 € | à figer au démarrage |
| Azure CLI | Connexion, vérifications | Libre, 0 € | à figer au démarrage |
| GitHub Actions + identité fédérée | Plan et apply sans secret | Quotas gratuits | à figer au démarrage |
| Azure Policy et budgets | Garde-fous | Sans surcoût | à figer au démarrage |
| VM Linux de petite taille (série B) avec strongSwan | NVA du hub et du site CLD | Payant à l'heure, à mesurer | à figer au démarrage |
| Compte de stockage | État Terraform distant | Quelques centimes par mois | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Abonnement | Compte d'essai avec crédit initial (conditions à vérifier) | Paiement à l'usage | Essai puis paiement à l'usage plafonné |
| Interconnexion | NVA Linux (rôle du lab 02) | VPN Gateway Azure, facturée à l'heure | NVA, VPN Gateway seulement chiffrée |
| Pare-feu du hub | NVA nftables | Azure Firewall | NVA |
| Coût d'une séance | — | VM, IP publiques, transfert de peering | À mesurer, destroy chaque soir |

Lab avec partie payante : un seul lab payant actif à la fois, plafond global de 100 €, budget et alerte créés **avant** le premier apply, destroy en fin de chaque séance, contrôle par l'étiquette `projet=hublabs`. Le coût réel d'une séance est mesuré et consigné dans le compte-rendu.

## Prérequis

- Labs 00 et 02 validés.
- Abonnement Azure de lab avec budget créé **avant** le premier apply.
- Un seul lab payant actif à la fois ; plafond global de 100 €.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| Hub | 10.50.0.0/16 | D |
| Spoke dev | 10.10.0.0/16 | D |
| Spoke prod | 10.40.0.0/16 | D |
| CLD, site virtuel | 10.20.48.0/20 | P |
| Région de base / Espagne | francecentral / spaincentral | P |
| Nommage | `rg-hublabs-lab04-frc-01` | P |
| Étiquettes | `projet=hublabs`, `lab=04`, `site`, `env=lab` | P |

## Ressources machine

Rien de lourd sur le poste : Terraform et Azure CLI.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
