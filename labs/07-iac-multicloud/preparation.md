# Lab 07 · Préparation

## Contexte

Beaucoup de clients sont multi-cloud par héritage, pas par choix : deux équipes, deux outillages, deux façons de nommer. Ce lab montre une discipline commune : une interface de module identique, des régions et des étiquettes issues du même référentiel, une identité fédérée des deux côtés, et une interconnexion IPsec réelle entre les deux clouds.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Terraform, fournisseurs azurerm et aws | Modules et implémentations | Libre, 0 € | à figer au démarrage |
| Ansible, rôle `nva` du lab 02 | Configuration strongSwan des NVA | Libre, 0 € | à figer au démarrage |
| GitHub Actions et GitLab CI | Pipelines plan et apply | Quotas gratuits | à figer au démarrage |
| Azure et AWS | Sites virtuels | Payant à l'heure, à mesurer ; offres gratuites des comptes neufs à vérifier | à figer au démarrage |
| AWS Budgets et budget Azure | Garde-fous de coût | Sans surcoût dans la limite des offres (à vérifier) | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Interconnexion | NVA strongSwan sur petites VM | VPN Gateway Azure + AWS Site-to-Site VPN | NVA |
| Calcul AWS | Offre gratuite des comptes neufs (conditions à vérifier) | Paiement à l'usage | Petite instance, destroy chaque soir |
| Mode de travail | Seul (autonomie) | En équipe (PR, CODEOWNERS) | Question ouverte |

Lab avec partie payante : un seul lab payant actif à la fois, plafond global de 100 €, budget et alerte créés **avant** le premier apply, destroy en fin de chaque séance, contrôle par l'étiquette `projet=hublabs`. Le coût réel d'une séance est mesuré et consigné dans le compte-rendu.

## Prérequis

- Labs 00, 02 et 04 validés (OIDC et état distant).
- Compte AWS de lab avec budget et alerte **avant** le premier apply.
- Un seul lab payant actif à la fois ; le 04 doit être détruit.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| CLD-AZ, site virtuel Azure | 10.20.48.0/20 | P |
| CLD-AWS, site virtuel AWS | Proposition : 10.20.96.0/20 (réserve), à ajouter au référentiel avant usage | P |
| Régions de base | francecentral / eu-west-3 | P |
| Régions Espagne | spaincentral / eu-south-2 | P |
| Transit des tunnels | 10.20.252.0/24 | P |
| Étiquettes | `projet=hublabs`, `lab=07`, `site`, `env=lab` | P |

## Ressources machine

Rien de lourd sur le poste : Terraform, Ansible, CLI Azure et AWS.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
