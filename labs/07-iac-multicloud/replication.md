# Lab 07 · Rejouer de zéro

> **Lab avec partie payante.** Vérifie le budget et l'alerte **avant** tout déploiement, et termine toujours par un destroy contrôlé par l'étiquette `projet=hublabs`.

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Labs 00, 02 et 04 validés (OIDC et état distant).
- Compte AWS de lab avec budget et alerte **avant** le premier apply.
- Un seul lab payant actif à la fois ; le 04 doit être détruit.

## Étapes

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
| Le tunnel monte mais aucun paquet ne passe côté AWS | Contrôle source/destination actif sur l'instance NVA | Le désactiver sur l'interface de la NVA |
| Négociation IKE qui échoue | UDP 500 et 4500 non ouverts, ou NAT-T non pris en compte | Ouvrir les deux ports et ESP, activer NAT-T |
| Déploiement refusé en eu-south-2 | Région non activée dans le compte AWS | Activer la région (opt-in) avant le premier plan |
| Abstraction qui gonfle | Options propres à un cloud ajoutées à l'interface commune | Garder l'interface minimale, les spécificités dans l'implémentation |
| États Terraform qui se marchent dessus | Même état pour les deux clouds | Un état par fournisseur et par environnement |
