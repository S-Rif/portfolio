# Lab 04 · Rejouer de zéro

> **Lab avec partie payante.** Vérifie le budget et l'alerte **avant** tout déploiement, et termine toujours par un destroy contrôlé par l'étiquette `projet=hublabs`.

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Labs 00 et 02 validés.
- Abonnement Azure de lab avec budget créé **avant** le premier apply.
- Un seul lab payant actif à la fois ; plafond global de 100 €.

## Étapes

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

## Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | ≤ 15–20 €, à mesurer | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

## Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| `AADSTS70021` à la connexion OIDC | Revendication `subject` différente de celle déclarée (branche, PR, environnement) | Aligner l'identité fédérée sur le contexte exact du job |
| Le fournisseur azurerm refuse de démarrer | Identifiant d'abonnement absent (obligatoire en version 4) | Le passer par variable d'environnement, jamais en dur |
| Trafic qui part vers le spoke mais ne revient pas | Routage asymétrique ou transfert IP désactivé sur la NVA | Activer le transfert IP (carte et système), vérifier les routes des deux côtés |
| Le destroy échoue | Verrou de ressource ou policy qui bloque la suppression | Retirer le verrou, relancer ; vérifier ensuite le balayage par étiquette |
| Facture inattendue | Ressources oubliées, IP publiques facturées à l'heure | Destroy chaque soir et contrôle par l'étiquette `projet=hublabs` |
