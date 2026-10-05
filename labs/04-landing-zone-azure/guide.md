# Lab 04 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Terraform et fournisseur azurerm | Socle complet en code | Libre, 0 € | à figer au démarrage |
| Azure CLI | Connexion, vérifications | Libre, 0 € | à figer au démarrage |
| GitHub Actions + identité fédérée | Plan et apply sans secret | Quotas gratuits | à figer au démarrage |
| Azure Policy et budgets | Garde-fous | Sans surcoût | à figer au démarrage |
| VM Linux de petite taille (série B) avec strongSwan | NVA du hub et du site CLD | Payant à l'heure, à mesurer | à figer au démarrage |
| Compte de stockage | État Terraform distant | Quelques centimes par mois | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Abonnement | Compte d'essai avec crédit initial (conditions à vérifier) | Paiement à l'usage | Essai puis paiement à l'usage plafonné |
| Interconnexion | NVA Linux (rôle du lab 02) | VPN Gateway Azure, facturée à l'heure | NVA, VPN Gateway seulement chiffrée |
| Pare-feu du hub | NVA nftables | Azure Firewall | NVA |
| Coût d'une séance | — | VM, IP publiques, transfert de peering | À mesurer, destroy chaque soir |

Lab avec partie payante : un seul lab payant actif à la fois, plafond global de 100 €, budget et alerte créés **avant** le premier apply, destroy en fin de chaque séance, contrôle par l'étiquette `projet=hublabs`. Le coût réel d'une séance est mesuré et consigné dans le journal.

### Prérequis

- Labs 00 et 02 validés.
- Abonnement Azure de lab avec budget créé **avant** le premier apply.
- Un seul lab payant actif à la fois ; plafond global de 100 €.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| Hub | 10.50.0.0/16 | D |
| Spoke dev | 10.10.0.0/16 | D |
| Spoke prod | 10.40.0.0/16 | D |
| CLD, site virtuel | 10.20.48.0/20 | P |
| Région de base / Espagne | francecentral / spaincentral | P |
| Nommage | `rg-hublabs-lab04-frc-01` | P |
| Étiquettes | `projet=hublabs`, `lab=04`, `site`, `env=lab` | P |

### Ressources machine

Rien de lourd sur le poste : Terraform et Azure CLI.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-04): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Hub-spoke et état distant | Plan propre, plages conformes | |
| 2 | Site CLD et IPsec | Ping traversant le tunnel | |
| 3 | OIDC et pipeline | Apply réussi par le pipeline, aucun secret | |
| 4 | Garde-fous, destroy, option internationale | Refus de policy, alerte, plans identiques | |

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

## Rejouer

> **Lab avec partie payante.** Vérifie le budget et l'alerte **avant** tout déploiement, et termine toujours par un destroy contrôlé par l'étiquette `projet=hublabs`.

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/04-landing-zone-azure docs/referentiel
cd labs/04-landing-zone-azure/terraform
terraform init
terraform plan -out=plan.tfplan
terraform apply plan.tfplan        # seulement après budget et alerte créés
terraform destroy                  # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=04`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | ≤ 15–20 €, à mesurer | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| `AADSTS70021` à la connexion OIDC | Revendication `subject` différente de celle déclarée (branche, PR, environnement) | Aligner l'identité fédérée sur le contexte exact du job |
| Le fournisseur azurerm refuse de démarrer | Identifiant d'abonnement absent (obligatoire en version 4) | Le passer par variable d'environnement, jamais en dur |
| Trafic qui part vers le spoke mais ne revient pas | Routage asymétrique ou transfert IP désactivé sur la NVA | Activer le transfert IP (carte et système), vérifier les routes des deux côtés |
| Le destroy échoue | Verrou de ressource ou policy qui bloque la suppression | Retirer le verrou, relancer ; vérifier ensuite le balayage par étiquette |
| Facture inattendue | Ressources oubliées, IP publiques facturées à l'heure | Destroy chaque soir et contrôle par l'étiquette `projet=hublabs` |
