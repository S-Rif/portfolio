# Lab 05 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L05-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L05-O1 | App de supervision sur kind, déployée par Argo CD | Application `Synced` et `Healthy`, aucun apply manuel dans l'historique | À faire | |
| L05-O2 | Politiques réseau : la supervision ne parle qu'à ses dépendances | Connexion refusée depuis un pod hors politique | À faire | |
| L05-O3 | Admission : image non signée refusée | Refus Kyverno sur une image de test non signée | À faire | |
| L05-O4 | Détection à l'exécution | Alerte Falco sur un shell ouvert dans un conteneur (ou limite documentée) | À faire | |
| L05-O5 | Mêmes manifestes sur AKS, puis destroy | Synchronisation réussie sur AKS, ressources supprimées | À faire | |
| L05-O6 | Retour arrière par `git revert` | Version précédente restaurée par Argo CD | À faire | |
| L05-O7 | Overlay `site-int` | Option `site_intl=ma` : configuration du site appliquée, `TZ=UTC` vérifié | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Maillage de services (service mesh).
- Multi-cluster et fédération.
- Haute disponibilité d'AKS en production.

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Kubernetes : objets, réseau, admission | 3 | Diagnostic d'un pod en échec sans aide |
| GitOps avec Argo CD et Kustomize | 3 | Structure base et overlays expliquée |
| Sécurité de la chaîne : signature, admission, exécution | 2 | Refus et alerte reproduits |
| AKS dans une landing zone | 2 | Cluster dans le spoke prod, puis destroy |

## Question de connaissance

Argo CD est en auto-réparation. En pleine panne, un opérateur fait un `kubectl edit` pour sauver la production. Que se passe-t-il quelques minutes après, et comment organises-tu l'accès d'urgence sans tuer le principe GitOps ?

Réponse rédigée dans le [journal](journal.md).
