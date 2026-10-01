# Contribuer

Le dépôt est partagé avec les personnes qui suivent la formation. Une seule branche active : `main`.

## Avant le premier commit

```bash
pre-commit install
pre-commit run --all-files
```

Les commits sont signés (clé SSH déclarée en signature sur GitHub) et l'identité Git utilise l'adresse noreply de GitHub.

## Règles

- **Aucun secret** (mot de passe, jeton, clé), aucune adresse e-mail, aucune donnée réelle de client, d'employeur ou de personne. Fil rouge fictif HubLabs uniquement.
- **Dossiers et fichiers** en minuscules ASCII, sans accent ni espace, labs préfixés par leur numéro (`labs/02-firewall-as-code`).
- **Pas de script** : toute automatisation passe par un workflow dans `.github/workflows/`, actions tierces épinglées par SHA, permissions minimales par job.
- **Preuves** : un objectif passe à « Validé » uniquement avec sa preuve dans `preuves/README.md`.
- **Petits commits**, au format Conventional Commits :

| Type | Usage | Exemple |
| --- | --- | --- |
| `docs` | Documentation | `docs(lab-02): séance 1` |
| `feat` | Fonction nouvelle dans un lab | `feat(lab-02): générateur de politique` |
| `fix` | Correction | `fix(lab-03): fuseau UTC de Suricata` |
| `ci` | Workflows | `ci(hub): contrôle des preuves` |
| `chore` | Entretien | `chore(hub): versions des hooks` |

## Avant de pousser

- `pre-commit run --all-files` entièrement vert.
- `git log --oneline -5` relu : un sujet par commit.
- Après le push : `gh run list --limit 3`, workflows verts.
