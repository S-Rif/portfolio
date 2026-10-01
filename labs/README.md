# Labs

Huit labs, du poste de travail à l'application en production, tous sur le fil rouge fictif HubLabs. Chaque dossier suit le même contrat : `README.md`, `objectifs.md`, `preparation.md`, `planning.md`, `replication.md`, `compte-rendu.md`, `preuves/README.md`, `adr/ADR-001.md`.

## Tableau de bord

Ordre de réalisation : le 07 passe avant le 05, car il réutilise directement l'état distant du 04.

| # | Lab | Semaine | Coût | S'appuie sur | Statut |
| --- | --- | --- | --- | --- | --- |
| 00 | [Environnement](00-environnement/README.md) | S1 | 0 € | — | À faire |
| 01 | [DevSecOps](01-devsecops/README.md) | S1 (MVP), S2 (complet) | 0 € | 00 (poste, Git signé, pre-commit) | À faire |
| 02 | [Firewall as Code](02-firewall-as-code/README.md) | S2–S3 | 0 € | 01 (`secure-ci`) | À faire |
| 03 | [Segmentation OT/IT](03-segmentation-ot-it/README.md) | S4 | 0 € | 02 (`policy.yml`, rôle `nva`) | À faire |
| 04 | [Landing zone Azure](04-landing-zone-azure/README.md) | S5 | ≤ 15–20 €, à mesurer | 02 (rôle `nva`) | À faire |
| 07 | [IaC multi-cloud](07-iac-multicloud/README.md) | S6–S7 | ≤ 15–20 €, à mesurer | 02 (rôle `nva`), 04 (OIDC, état distant) | À faire |
| 05 | [Kubernetes GitOps](05-kubernetes-gitops/README.md) | S8 | 0 € sur kind, AKS à mesurer | 03 (Loki, Grafana), 04 (spoke prod, état distant) | À faire |
| 06 | [Breach Watch](06-breach-watch/README.md) | S9 | 0 € | 05 (déploiement GitOps ; Docker Compose en solo) | À faire |

Le statut détaillé de chaque objectif vit dans le fichier `objectifs.md` du lab. Le résumé de chaque exécution du workflow `labs` affiche le nombre d'objectifs validés.

## Créer ou compléter un lab

1. Copier [`_gabarits/`](_gabarits/README.md) vers `labs/NN-nom-du-lab/` (minuscules, ASCII, sans accent).
2. Remplir chaque `À REMPLIR`, en commençant par `objectifs.md`.
3. Suivre la [méthode](methode.md) : une séance, un commit, une preuve.
