# Lab 05 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| kind, kubectl, Kustomize, Helm | Cluster local et manifestes | Libre, 0 € | à figer au démarrage |
| Argo CD | Synchronisation GitOps | Libre, 0 € | à figer au démarrage |
| Cilium | Réseau du cluster et politiques | Libre, 0 € | à figer au démarrage |
| Kyverno | Politiques d'admission, vérification de signature | Libre, 0 € | à figer au démarrage |
| Falco | Détection à l'exécution | Libre, 0 € ; compatibilité du noyau WSL2 à vérifier | à figer au démarrage |
| AKS | Cluster managé | Plan de contrôle gratuit (niveau Free), nœuds facturés à l'heure | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Cluster | kind en local | AKS (nœuds facturés) | kind, AKS en fin de lab seulement |
| Registre d'images | Registre GitHub (quotas gratuits) | Azure Container Registry | Registre GitHub |
| Observabilité | Loki et Grafana du lab 03 | Azure Monitor | Lab 03 |

Lab avec partie payante : un seul lab payant actif à la fois, plafond global de 100 €, budget et alerte créés **avant** le premier apply, destroy en fin de chaque séance, contrôle par l'étiquette `projet=hublabs`. Le coût réel d'une séance est mesuré et consigné dans le journal.

### Prérequis

- Labs 00, 01 (image signée), 03 et 04 validés.
- 8 Go de RAM sur le poste conseillés.
- Notions : pods, services, déploiements, espaces de noms.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| Spoke prod (AKS) | 10.40.0.0/16 | D |
| Nom du cluster kind | `hublabs-05` | P |
| Domaine fictif | `hublabs.example` | P |
| Ports locaux du lab | 18050 à 18059 | P |

### Ressources machine

4 à 6 Go de RAM pour kind avec Argo CD, Cilium, Kyverno et Falco. Ne pas lancer le lab 03 complet en parallèle.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-05): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | kind et Argo CD | Application `Synced` et `Healthy` | |
| 2 | Politiques et garde-fous | Refus et alerte reproduits | |
| 3 | Overlay international et retour arrière | Revert restauré par Argo CD | |
| 4 | Bascule vers AKS puis destroy | Synchronisation sur AKS, aucune ressource restante | |

### Séance 1 : kind et Argo CD

1. Cluster kind sans CNI par défaut, puis Cilium.
2. Argo CD et une application pointant sur `gitops/overlays/kind`.
3. Déployer l'application de supervision par commit.

Point de contrôle : Application `Synced` et `Healthy`.

### Séance 2 : Politiques et garde-fous

1. Politiques réseau Cilium : autoriser seulement les dépendances.
2. Kyverno : signature requise, identité du workflow du lab 01.
3. Falco : règle shell dans un conteneur.

Point de contrôle : Refus et alerte reproduits.

### Séance 3 : Overlay international et retour arrière

1. Overlay `site-int` (TZ, langue, configuration).
2. Changement de version puis `git revert`.
3. Preuves.

Point de contrôle : Revert restauré par Argo CD.

### Séance 4 : Bascule vers AKS puis destroy

1. AKS dans le spoke prod (module du lab 04), budget vérifié.
2. Overlay `aks`, synchronisation.
3. Destroy et contrôle par étiquette.

Point de contrôle : Synchronisation sur AKS, aucune ressource restante.

## Rejouer

> **Lab avec partie payante.** Vérifie le budget et l'alerte **avant** tout déploiement, et termine toujours par un destroy contrôlé par l'étiquette `projet=hublabs`.

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/05-kubernetes-gitops docs/referentiel
kind create cluster --name hublabs-05 --config labs/05-kubernetes-gitops/kind.yaml
kubectl kustomize labs/05-kubernetes-gitops/gitops/overlays/kind | kubectl apply -f -   # amorçage d'Argo CD uniquement
kind delete cluster --name hublabs-05                            # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=05`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € sur kind, AKS à mesurer | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Pods bloqués en `ContainerCreating` sur kind | CNI par défaut désactivé sans Cilium installé | Installer Cilium juste après la création du cluster |
| Falco ne démarre pas | Noyau WSL2 sans les fonctions attendues par le pilote eBPF | Tester le pilote eBPF moderne ; sinon documenter la limite et prouver sur AKS |
| Argo CD n'accède pas au dépôt privé | Pas d'identifiant de lecture | Clé de déploiement en lecture seule, stockée hors Git |
| Une modification manuelle disparaît | Auto-réparation d'Argo CD : comportement voulu | Passer par Git, ou suspendre la synchronisation en urgence et le tracer |
| Toutes les images refusées | Politique Kyverno appliquée aux espaces système | Exclure `kube-system` et l'espace d'Argo CD de la politique |
