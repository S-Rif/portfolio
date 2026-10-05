# Lab 02 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Ansible (ansible-core) | Application des règles, rôle `nva` | Libre, 0 € | à figer au démarrage |
| Molecule + pilote Docker | Tests du rôle : converge, idempotence, verify | Libre, 0 € | à figer au démarrage |
| nftables dans un conteneur Debian | Moteur de pare-feu des sites | Libre, 0 € | à figer au démarrage |
| Python + PyYAML | Générateur matrice vers `policy.yml` | Libre, 0 € | à figer au démarrage |
| Docker Engine (WSL) et Compose | Sites et zones simulés | Libre, 0 € | à figer au démarrage |
| FortiGate-VM (bonus) | Même politique poussée sur FortiOS | Licence d'évaluation gratuite à fonctions limitées, conditions à vérifier sur le site Fortinet | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Moteur de pare-feu | nftables en conteneur | FortiGate-VM sous licence complète | nftables ; FortiGate en bonus |
| Exécution | Poste local (WSL) et runner GitHub | VM cloud | Local et CI |
| CI | GitHub Actions et GitLab CI (quotas gratuits) | Runners payants | Gratuit |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- Lab 00 validé (poste, Docker, pre-commit).
- Lab 01 : `secure-ci` disponible (sinon, contrôle qualité seul).
- Notions : modèle à états d'un pare-feu, NAT, zones.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| LYO, Usine HubLabs | 10.20.0.0/20 | P |
| LYO IT postes | 10.20.1.0/24 | P |
| LYO iDMZ (bastion, relais) | 10.20.8.0/24 | P |
| LYO OT contrôle (automates) | 10.20.11.0/24 | P |
| CLD, site virtuel | 10.20.48.0/20 | P |
| INT-MA / INT-ES | 10.20.64.0/20 / 10.20.80.0/20 | P |
| Transit des tunnels | 10.20.252.0/24 | P |
| Ports locaux du lab | 18020 à 18029 | P |

### Ressources machine

Environ 1 Go de RAM : quatre à six conteneurs légers.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-02): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | Matrice vers politique | `policy.yml` régénéré identique, `nft -c` sans erreur | |
| 2 | Topologie et tests de flux | F01 à F10 vérifiés, code retour 0 | |
| 3 | Idempotence, dérive, CI | Second passage `changed=0`, dérive détectée | |
| 4 | Site CLD, option internationale, retour arrière | Option `ma` conforme, revert prouvé | |

### Séance 1 : Matrice vers politique

1. Écrire le générateur : lecture de `matrice-flux.md`, sortie `policy.yml` triée.
2. Créer le rôle `nva` et son template `nftables.conf.j2` (refus par défaut, suivi de connexion).
3. Valider la syntaxe avec `nft -c -f` dans un conteneur.

Point de contrôle : `policy.yml` régénéré identique, `nft -c` sans erreur.

### Séance 2 : Topologie et tests de flux

1. `compose.yaml` : `lyo-fw01`, poste IT, bastion, automate sur des réseaux Docker distincts.
2. Un test par flux : connexion attendue pour les autorisés, échec pour les interdits.
3. Exposer les tests comme service `tests` du `compose.yaml`, lancé par le workflow `labs`.

Point de contrôle : F01 à F10 vérifiés, code retour 0.

### Séance 3 : Idempotence, dérive, CI

1. Molecule : converge, idempotence, verify.
2. Test de dérive : comparer `nft list ruleset` au rendu attendu.
3. Vérifier le job du workflow `labs` sur un flux volontairement cassé.

Point de contrôle : Second passage `changed=0`, dérive détectée.

### Séance 4 : Site CLD, option internationale, retour arrière

1. Ajouter `cld-fw01` puis `int-ma-fw01` (profil Compose `intl-ma`).
2. Scénario de retour arrière : `git revert`, réapplication, tests.
3. Compléter preuves et journal.

Point de contrôle : Option `ma` conforme, revert prouvé.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/02-firewall-as-code docs/referentiel
cd labs/02-firewall-as-code
docker compose up -d --wait                           # montage
docker compose run --rm tests                         # un test par objectif
COMPOSE_PROFILES=intl-ma docker compose up -d --wait  # variante site international
docker compose down -v --remove-orphans               # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=02`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 7 sur 7 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| `Operation not permitted` au chargement des règles | Conteneur lancé sans la capacité `NET_ADMIN` | Ajouter `cap_add: [NET_ADMIN]` au conteneur pare-feu, jamais `privileged` |
| Docker n'a plus de réseau sur le poste | Règles nftables appliquées sur l'hôte WSL au lieu du conteneur | N'appliquer les règles que dans l'espace réseau du conteneur ; redémarrer Docker pour restaurer ses règles |
| Les flux autorisés échouent dans un seul sens | Retour de trafic bloqué : pas de règle `ct state established,related accept` | Placer cette règle en tête de chaque chaîne filtrante |
| Ansible annonce `changed` à chaque passage | Ordre de rendu non déterministe dans le template | Trier les flux dans le générateur et dans le template |
| Un flux interdit « passe » le test | Le test confond refus du pare-feu et service absent | Démarrer un service à l'écoute sur la cible : seul le pare-feu doit expliquer l'échec |
