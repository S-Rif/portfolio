# Lab 08 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L08-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L08-O1 | Terraform monte l'usine (réseau, runner, SonarQube, Vault, deux cibles, nginx) ; destroy puis apply redonne le même état | Sorties `apply` et `destroy`, puis `terraform plan` : `No changes` | À faire | |
| L08-O2 | Runner self-hosted enregistré sur le projet GitLab, seuls les jobs étiquetés y tournent | Runner « online » dans GitLab, journal d'un job : exécuté sur `lyo-run01` | À faire | |
| L08-O3 | Un template unique (`include` + `parallel:matrix`) déploie 10 scripts sur dev et prd | Pipeline de 20 jobs verts, un seul fichier de template | À faire | |
| L08-O4 | Quality gate SonarQube bloquante | Pipeline rouge sur un défaut volontaire, vert après correction | À faire | |
| L08-O5 | Secret lu dans Vault par le job via son jeton d'identité GitLab, aucun secret applicatif dans les variables CI ni dans le dépôt | Journal du job (valeur masquée), liste des variables CI, `gitleaks` vert | À faire | |
| L08-O6 | Ansible configure les cibles de façon idempotente : utilisateur de service, venv Python, service et timer systemd | Second passage `changed=0`, sortie de `systemctl list-timers` | À faire | |
| L08-O7 | Retour à la version N-1 d'un script en un job | Job de rollback, version déployée avant et après | À faire | |
| L08-O8 | Portail Vue construit par le pipeline et servi par nginx, sur dev puis prd | `curl` en 200 avec la version affichée, pipeline vert | À faire | |
| L08-O9 | Choix « timer systemd ou CronJob Kubernetes » argumenté et chiffré | [ADR-001](adr/ADR-001.md) au statut « accepté » | À faire | |
| L08-O10 | Bonus : statut de chaque déploiement en base (MongoDB) et job PowerShell (`pwsh`) en conteneur | Requête sur la base, journal du job `pwsh` | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Windows Server : non gratuit et trop lourd sous WSL. Formulation honnête en entretien : « PowerShell pratiqué, Windows Server non pratiqué ».
- SQL Server : l'image demande au moins 2 Go de RAM ; seulement si la mémoire de WSL le permet, sinon MongoDB seul.
- Haute disponibilité de Vault et de SonarQube, GitLab auto-hébergé (le projet reste sur gitlab.com, seul le runner est local).

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| GitLab CI : templates, `include`, `parallel:matrix`, runners étiquetés | 3 | Template expliqué ligne par ligne, runner dépanné sans aide |
| Terraform : provider Docker, provider Vault, états séparés | 2 | Destroy puis apply sans écart, choix des deux états expliqué |
| Ansible : rôles, unités systemd, idempotence | 3 | `changed=0`, rôle relu |
| Vault : authentification JWT, politiques | 2 | Politique et rôle lus et expliqués |
| Qualité du code : SonarQube, quality gate | 2 | Gate rouge puis verte expliquée |
| systemd : service, timer, journal | 2 | `systemd-analyze calendar` et `journalctl -u` commentés |

## Question de connaissance

Ta matrice déploie 10 scripts sur deux environnements. Le client en a 200 : que se passe-t-il si tu gardes le même modèle, et comment ne déploies-tu que les scripts réellement modifiés ?

Réponse rédigée dans le [journal](journal.md).
