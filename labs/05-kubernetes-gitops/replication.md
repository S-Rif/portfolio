# Lab 05 · Rejouer de zéro

> **Lab avec partie payante.** Vérifie le budget et l'alerte **avant** tout déploiement, et termine toujours par un destroy contrôlé par l'étiquette `projet=hublabs`.

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

## Prérequis

- Labs 00, 01 (image signée), 03 et 04 validés.
- 8 Go de RAM sur le poste conseillés.
- Notions : pods, services, déploiements, espaces de noms.

## Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/05-kubernetes-gitops docs/referentiel
kind create cluster --name hublabs-05 --config labs/05-kubernetes-gitops/kind.yaml
kubectl kustomize labs/05-kubernetes-gitops/gitops/overlays/kind | kubectl apply -f -   # amorçage d'Argo CD uniquement
kind delete cluster --name hublabs-05                            # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=05`, puis `gh run watch`.

## Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € sur kind, AKS à mesurer | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

## Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Pods bloqués en `ContainerCreating` sur kind | CNI par défaut désactivé sans Cilium installé | Installer Cilium juste après la création du cluster |
| Falco ne démarre pas | Noyau WSL2 sans les fonctions attendues par le pilote eBPF | Tester le pilote eBPF moderne ; sinon documenter la limite et prouver sur AKS |
| Argo CD n'accède pas au dépôt privé | Pas d'identifiant de lecture | Clé de déploiement en lecture seule, stockée hors Git |
| Une modification manuelle disparaît | Auto-réparation d'Argo CD : comportement voulu | Passer par Git, ou suspendre la synchronisation en urgence et le tracer |
| Toutes les images refusées | Politique Kyverno appliquée aux espaces système | Exclure `kube-system` et l'espace d'Argo CD de la politique |
