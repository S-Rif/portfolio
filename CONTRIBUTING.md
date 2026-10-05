# Contribuer

Le dépôt est partagé avec les personnes qui suivent la formation. `main` est toujours publiable ; tout changement passe par une branche courte et une pull request.

## Avant le premier commit

```bash
pre-commit install
pre-commit run --all-files
```

Les commits sont signés (clé SSH déclarée en signature sur GitHub) et l'identité Git utilise l'adresse noreply de GitHub.

## Règles

- **Aucun secret** (mot de passe, jeton, clé), aucune adresse e-mail, aucune donnée réelle de client, d'employeur ou de personne. Fil rouge fictif HubLabs uniquement.
- **Dossiers et fichiers** en minuscules ASCII, sans accent ni espace, labs préfixés par leur numéro (`labs/02-firewall-as-code`).
- **Pas de script d'outillage** : l'automatisation du dépôt passe par `.github/workflows/`, actions tierces épinglées par SHA, permissions minimales par job. Le code construit par un lab est un livrable du lab.
- **Preuves** : un objectif passe à « Validé » uniquement quand la colonne Preuve de son `objectifs.md` est remplie.
- **Une documentation, un endroit** : une information vit dans un seul fichier, les autres y renvoient par un lien.

## Branches, commits, versions

| Élément | Convention | Exemple |
| --- | --- | --- |
| Branche | `type/sujet`, supprimée à la fusion | `docs/lab-02-seance-1`, `feat/lab-08-matrice` |
| Commit | Conventional Commits, un sujet par commit | `docs(lab-02): séance 1` |
| Version d'un lab | Tag `lab-NN-vX.Y.Z` | `lab-02-v1.0.0` |
| Version du portfolio | Tag `hub-vX.Y.Z`, entrée dans `CHANGELOG.md` | `hub-v0.2.0` |

| Type | Usage | Exemple |
| --- | --- | --- |
| `docs` | Documentation | `docs(lab-02): séance 1` |
| `feat` | Fonction nouvelle dans un lab | `feat(lab-02): générateur de politique` |
| `fix` | Correction | `fix(lab-03): fuseau UTC de Suricata` |
| `refactor` | Restructuration sans changement de comportement | `refactor(hub): contrat des labs en cinq éléments` |
| `ci` | Workflows | `ci(hub): contrôle des preuves` |
| `chore` | Entretien | `chore(hub): versions des hooks` |

## Workflows

| Workflow | Déclenchement | Rôle |
| --- | --- | --- |
| [`qualite`](.github/workflows/qualite.yml) | Push sur `main`, PR, manuel | Hooks pre-commit, liens internes, secrets dans tout l'historique, contrat des labs, objectifs validés sans preuve, noms et données interdits |
| [`labs`](.github/workflows/labs.yml) | Modification d'un lab, manuel (`lab`, `site_intl`) | Contrôle de chaque lab modifié, en parallèle : tableau de bord, Compose, Terraform, Ansible, GitOps |
| [`liens-externes`](.github/workflows/liens-externes.yml) | Chaque lundi, manuel | Liens vers l'extérieur, hors du chemin bloquant |
| [`release`](.github/workflows/release.yml) | Tag `lab-NN-v*` ou `hub-v*` | Publie la version avec ses notes |

## Avant de pousser

- `pre-commit run --all-files` entièrement vert.
- `git log --oneline main..HEAD` relu : un sujet par commit.
- Après le push : `gh pr checks --watch`, contrôles verts.
