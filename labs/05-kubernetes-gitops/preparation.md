# Lab 05 · Préparation

## Contexte

Un cluster administré à la main devient vite un état que personne ne sait reconstruire. Le GitOps fait de Git l'unique source : le cluster converge vers ce qui est fusionné, un retour arrière est un `git revert`, et chaque changement est relu. Ce lab ajoute les garde-fous qu'attend un client sensible : politiques réseau, refus des images non signées, détection d'exécution anormale.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| kind, kubectl, Kustomize, Helm | Cluster local et manifestes | Libre, 0 € | à figer au démarrage |
| Argo CD | Synchronisation GitOps | Libre, 0 € | à figer au démarrage |
| Cilium | Réseau du cluster et politiques | Libre, 0 € | à figer au démarrage |
| Kyverno | Politiques d'admission, vérification de signature | Libre, 0 € | à figer au démarrage |
| Falco | Détection à l'exécution | Libre, 0 € ; compatibilité du noyau WSL2 à vérifier | à figer au démarrage |
| AKS | Cluster managé | Plan de contrôle gratuit (niveau Free), nœuds facturés à l'heure | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Cluster | kind en local | AKS (nœuds facturés) | kind, AKS en fin de lab seulement |
| Registre d'images | Registre GitHub (quotas gratuits) | Azure Container Registry | Registre GitHub |
| Observabilité | Loki et Grafana du lab 03 | Azure Monitor | Lab 03 |

Lab avec partie payante : un seul lab payant actif à la fois, plafond global de 100 €, budget et alerte créés **avant** le premier apply, destroy en fin de chaque séance, contrôle par l'étiquette `projet=hublabs`. Le coût réel d'une séance est mesuré et consigné dans le compte-rendu.

## Prérequis

- Labs 00, 01 (image signée), 03 et 04 validés.
- 8 Go de RAM sur le poste conseillés.
- Notions : pods, services, déploiements, espaces de noms.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| Spoke prod (AKS) | 10.40.0.0/16 | D |
| Nom du cluster kind | `hublabs-05` | P |
| Domaine fictif | `hublabs.example` | P |
| Ports locaux du lab | 18050 à 18059 | P |

## Ressources machine

4 à 6 Go de RAM pour kind avec Argo CD, Cilium, Kyverno et Falco. Ne pas lancer le lab 03 complet en parallèle.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
