# Lab 07 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Terraform, fournisseurs azurerm et aws | Modules et implémentations | Libre, 0 € | à figer au démarrage |
| Ansible, rôle `nva` du lab 02 | Configuration strongSwan des NVA | Libre, 0 € | à figer au démarrage |
| GitHub Actions et GitLab CI | Pipelines plan et apply | Quotas gratuits | à figer au démarrage |
| Azure et AWS | Sites virtuels | Payant à l'heure, à mesurer ; offres gratuites des comptes neufs à vérifier | à figer au démarrage |
| AWS Budgets et budget Azure | Garde-fous de coût | Sans surcoût dans la limite des offres (à vérifier) | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Interconnexion | NVA strongSwan sur petites VM | VPN Gateway Azure + AWS Site-to-Site VPN | NVA |
| Calcul AWS | Offre gratuite des comptes neufs (conditions à vérifier) | Paiement à l'usage | Petite instance, destroy chaque soir |
| Mode de travail | Seul (autonomie) | En équipe (PR, CODEOWNERS) | Question ouverte |

Lab avec partie payante : un seul lab payant actif à la fois, plafond global de 100 €, budget et alerte créés **avant** le premier apply, destroy en fin de chaque séance, contrôle par l'étiquette `projet=hublabs`. Le coût réel d'une séance est mesuré et consigné dans le journal.

### Prérequis

- Labs 00, 02 et 04 validés (OIDC et état distant).
- Compte AWS de lab avec budget et alerte **avant** le premier apply.
- Un seul lab payant actif à la fois ; le 04 doit être détruit.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| CLD-AZ, site virtuel Azure | 10.20.48.0/20 | P |
| CLD-AWS, site virtuel AWS | Proposition : 10.20.96.0/20 (réserve), à ajouter au référentiel avant usage | P |
| Régions de base | francecentral / eu-west-3 | P |
| Régions Espagne | spaincentral / eu-south-2 | P |
| Transit des tunnels | 10.20.252.0/24 | P |
| Étiquettes | `projet=hublabs`, `lab=07`, `site`, `env=lab` | P |

### Ressources machine

Rien de lourd sur le poste : Terraform, Ansible, CLI Azure et AWS.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-07): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Interface de module commune | Interface documentée, plan Azure propre | |
| 2 | Implémentation AWS et OIDC | Plan AWS par le pipeline, aucune clé | |
| 3 | Interconnexion IPsec | Ping inter-cloud capturé | |
| 4 | Option internationale, coûts, destroy | Coût consigné, aucune ressource restante | |

### Séance 1 : Interface de module commune

1. Définir les entrées (nom, plage, région, étiquettes) et les sorties (réseau, IP publique de la NVA).
2. Implémentation Azure en réutilisant le lab 04.
3. Plan Azure propre.

Point de contrôle : Interface documentée, plan Azure propre.

### Séance 2 : Implémentation AWS et OIDC

1. Rôle IAM avec confiance OIDC limitée au dépôt et à la branche.
2. VPC, sous-réseau, groupe de sécurité, NVA.
3. Plan AWS propre via le pipeline.

Point de contrôle : Plan AWS par le pipeline, aucune clé.

### Séance 3 : Interconnexion IPsec

1. Rôle `nva` du lab 02 appliqué des deux côtés.
2. Désactiver le contrôle source/destination côté AWS, transfert IP côté Azure.
3. Ping inter-cloud, puis destroy.

Point de contrôle : Ping inter-cloud capturé.

### Séance 4 : Option internationale, coûts, destroy

1. `SITE_INTL=es` : régions espagnoles.
2. Rapports de coût par étiquette.
3. Destroy complet et contrôle des deux côtés.

Point de contrôle : Coût consigné, aucune ressource restante.

## Rejouer

> **Lab avec partie payante.** Vérifie le budget et l'alerte **avant** tout déploiement, et termine toujours par un destroy contrôlé par l'étiquette `projet=hublabs`.

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/07-iac-multicloud docs/referentiel
cd labs/07-iac-multicloud/terraform
terraform init
terraform plan -out=plan.tfplan
terraform apply plan.tfplan        # seulement après budget et alerte créés
terraform destroy                  # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=07`, puis `gh run watch`.

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
| Le tunnel monte mais aucun paquet ne passe côté AWS | Contrôle source/destination actif sur l'instance NVA | Le désactiver sur l'interface de la NVA |
| Négociation IKE qui échoue | UDP 500 et 4500 non ouverts, ou NAT-T non pris en compte | Ouvrir les deux ports et ESP, activer NAT-T |
| Déploiement refusé en eu-south-2 | Région non activée dans le compte AWS | Activer la région (opt-in) avant le premier plan |
| Abstraction qui gonfle | Options propres à un cloud ajoutées à l'interface commune | Garder l'interface minimale, les spécificités dans l'implémentation |
| États Terraform qui se marchent dessus | Même état pour les deux clouds | Un état par fournisseur et par environnement |
