# Lab 06 · Guide

Préparer, planifier, rejouer. Le contexte métier est dans le [README](README.md), les objectifs dans [objectifs.md](objectifs.md).

## Préparer

### Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Python, FastAPI | API et veille planifiée | Libre, 0 € | à figer au démarrage |
| SQLite puis PostgreSQL | Services suivis et abonnements push | Libre, 0 € | à figer au démarrage |
| API publique de liste des fuites (Have I Been Pwned) | Source de veille | Gratuite sans clé pour la liste des fuites ; conditions d'usage et attribution à vérifier | à figer au démarrage |
| Pwned Passwords (plage par préfixe) | Vérification d'un mot de passe par k-anonymat | Gratuite | à figer au démarrage |
| Web Push (clés VAPID) | Notifications | Gratuit | à figer au démarrage |
| Mailpit | Serveur SMTP de test local | Libre, 0 € | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

### Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Notifications | Web Push et e-mail local | SMS par un fournisseur | Push et e-mail ; SMS en backlog |
| Recherche par compte | Non (liste des fuites par service) | API payante par adresse e-mail | Non retenu |
| HTTPS pour le téléphone | Tunnel gratuit ou certificat local (à vérifier) | Domaine et hébergement | Gratuit |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

### Prérequis

- Labs 00 et 01 validés ; lab 05 pour le déploiement GitOps.
- Un iPhone (iOS 16.4 ou plus pour le push d'une PWA) ou un Android pour la preuve d'installation.
- Notions : fonctions de hachage, HTTPS, service worker.

### Valeurs du référentiel utilisées

Statuts D et P : voir le [référentiel](../../docs/referentiel/README.md#statuts).

| Élément | Valeur | Statut |
| --- | --- | --- |
| Domaine fictif | `hublabs.example` | P |
| Domaines du site international | `ma.hublabs.example` / `es.hublabs.example` | P |
| Ports locaux du lab (API, Mailpit) | 18060 à 18069 | P |

### Ressources machine

Moins de 1 Go de RAM en Docker Compose.

## Planifier

4 séances de 90 minutes maximum. Chacune se termine par un commit `docs(lab-06): séance N` et un point de contrôle vert.

| Séance | Contenu | Point de contrôle | Fait le |
| --- | --- | --- | --- |
| 1 | API et modèle de données | Test k-anonymat vert | |
| 2 | Veille et notifications | Alerte reçue sur fuite simulée | |
| 3 | PWA installable | PWA installée, notification reçue | |
| 4 | Option internationale et GitOps | Option `es` conforme, déploiement synchronisé | |

### Séance 1 : API et modèle de données

1. Modèle : utilisateur fictif, services suivis, abonnements push.
2. Vérification de mot de passe côté navigateur (SHA-1, préfixe de 5 caractères).
3. Test automatisé du contenu de la requête sortante (service `tests`).

Point de contrôle : Test k-anonymat vert.

### Séance 2 : Veille et notifications

1. Tâche planifiée qui lit la liste des fuites et compare aux services suivis.
2. Clés VAPID générées localement, hors Git.
3. Envoi push et e-mail vers Mailpit.

Point de contrôle : Alerte reçue sur fuite simulée.

### Séance 3 : PWA installable

1. Manifeste, service worker, icônes.
2. HTTPS pour le téléphone.
3. Installation sur iPhone et Android, preuve de push.

Point de contrôle : PWA installée, notification reçue.

### Séance 4 : Option internationale et GitOps

1. Libellés traduits, horodatage UTC (profil `intl-es`).
2. Manifestes dans le dossier GitOps du lab 05.
3. Preuves et journal.

Point de contrôle : Option `es` conforme, déploiement synchronisé.

## Rejouer

Objectif : un étudiant ou un relecteur rejoue ce lab sur un poste neuf, sans aide, à partir de ce seul dossier.

### Étapes

```bash
git clone --filter=blob:none --sparse git@github.com:S-Rif/portfolio.git && cd portfolio
git sparse-checkout set labs/06-breach-watch docs/referentiel
cd labs/06-breach-watch
docker compose up -d --wait                           # montage
docker compose run --rm tests                         # un test par objectif
COMPOSE_PROFILES=intl-ma docker compose up -d --wait  # variante site international
docker compose down -v --remove-orphans               # toujours en fin de séance
```

Contrôle en CI, sans rien installer : `gh workflow run labs -f lab=06`, puis `gh run watch`.

### Mesures

| Mesure | Attendu | Mesuré |
| --- | --- | --- |
| Durée de montage | à mesurer | |
| Coût d'une séance | 0 € | |
| Objectifs prouvés | 6 sur 6 | |
| Nettoyage | plus rien ne tourne | |

### Pannes fréquentes

| Symptôme | Cause probable | Correctif |
| --- | --- | --- |
| Aucune réponse de l'API de fuites | En-tête `User-Agent` absent, exigé par l'API | Ajouter un `User-Agent` identifiant l'application |
| Pas de notification sur iPhone | PWA ouverte dans Safari sans être installée, ou iOS trop ancien | Ajouter à l'écran d'accueil, puis demander la permission |
| Permission de notification refusée d'office | Demande lancée sans action de l'utilisateur | Déclencher la demande sur un clic |
| Ancienne version affichée après déploiement | Service worker qui sert le cache | Versionner le cache et gérer la mise à jour du service worker |
| Préfixe non trouvé alors que le mot de passe est connu | Empreinte en minuscules ou mal découpée | SHA-1 en hexadécimal majuscule, 5 caractères envoyés, 35 comparés localement |
