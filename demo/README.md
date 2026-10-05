# Démo

La partie **Démo** du portfolio : ce que je montre en entretien, dans quel ordre, et comment je me rattrape si le direct échoue. Chaque étape renvoie au scénario de démo du lab concerné, qui reste la référence.

## Principes

- **Dix minutes, un fil** : un problème de l'Usine HubLabs, puis la preuve que je sais le résoudre. Pas de visite guidée des outils.
- **En local de préférence**, sur un clone propre de la version taguée ; les workflows du dépôt servent de preuve en ligne.
- **Chaque affirmation a sa preuve** : si je ne peux pas la montrer en direct, je montre l'exécution verte du workflow ou le fichier de `preuves/`.
- **Rien de payant ne tourne avant l'entretien** : les labs cloud sont montrés par leur historique de pipeline, sauf demande explicite.

## Choisir le parcours

| Le poste parle surtout de… | Parcours |
| --- | --- |
| Cloud, réseau, sécurité OT/IT, Azure, Kubernetes | A · Cloud et OT |
| CI/CD, déploiement sur serveurs fournis, Linux, secrets, qualité de code | B · Usine de déploiement |

### Parcours A · Cloud et OT (10 minutes)

| Minute | Contenu | Scénario source |
| --- | --- | --- |
| 0–1 | Le contexte HubLabs : une usine qui migre sa supervision vers le cloud sans ouvrir son OT | [README racine](../README.md#le-fil-rouge--hublabs) |
| 1–3 | Un faux secret poussé, le pipeline s'arrête ; correction, image signée et vérifiée | [Lab 01](../labs/01-devsecops/README.md#scénario-de-démo-5-minutes) |
| 3–5 | Un flux ajouté dans la matrice, règle générée et testée ; une règle ajoutée à la main est détectée | [Lab 02](../labs/02-firewall-as-code/README.md#scénario-de-démo-5-minutes) |
| 5–7 | Requête Modbus depuis l'IT bloquée et levée dans Grafana | [Lab 03](../labs/03-segmentation-ot-it/README.md#scénario-de-démo-5-minutes) |
| 7–9 | Plan relu, apply approuvé sans secret, ou retour arrière par `git revert` | [Lab 04](../labs/04-landing-zone-azure/README.md#scénario-de-démo-5-minutes) ou [lab 05](../labs/05-kubernetes-gitops/README.md#scénario-de-démo-5-minutes) |
| 9–10 | Coût réel, limites assumées, ce que je ferais en production | Journaux des labs |

### Parcours B · Usine de déploiement (10 minutes)

| Minute | Contenu | Scénario source |
| --- | --- | --- |
| 0–1 | Le contexte : des dizaines de scripts déployés à la main sur des serveurs de l'usine | [Lab 08](../labs/08-usine-deploiement/README.md#le-problème-métier) |
| 1–3 | Un faux secret poussé, le pipeline s'arrête avant tout déploiement | [Lab 01](../labs/01-devsecops/README.md#scénario-de-démo-5-minutes) |
| 3–6 | Quality gate rouge puis verte, matrice de 20 déploiements, secret lu dans Vault | [Lab 08](../labs/08-usine-deploiement/README.md#scénario-de-démo-5-minutes) |
| 6–8 | Timers systemd sur la cible prd, rollback N-1 en un job | [Lab 08](../labs/08-usine-deploiement/README.md#scénario-de-démo-5-minutes) |
| 8–9 | Configuration des serveurs en code : second passage Ansible `changed=0` | [Lab 02](../labs/02-firewall-as-code/README.md#scénario-de-démo-5-minutes) |
| 9–10 | Ce qui passe à l'échelle (200 scripts), limites assumées (Windows Server non pratiqué) | [Journal du lab 08](../labs/08-usine-deploiement/journal.md) |

## Préparer la démo

### La veille

1. Partir de la version taguée de la vitrine (`hub-vX.Y.Z`), sur un clone propre.
2. Rejouer le parcours en entier, chronomètre en main ; noter le temps réel de chaque étape.
3. Précharger les images (`docker compose pull`) pour ne rien télécharger pendant l'entretien.
4. Ouvrir dans des onglets les exécutions vertes des workflows et les fichiers de preuves : c'est le plan B.
5. Vérifier qu'aucune ressource cloud ne tourne et qu'aucun secret n'est visible (terminal, historique, variables affichées).

### Une heure avant

1. `wsl --shutdown`, puis relance : Docker démarre seul.
2. Monter les labs du parcours, lancer une fois leurs tests.
3. Terminal en grande police, notifications coupées, un seul bureau.

## Si le direct échoue

| Situation | Plan B |
| --- | --- |
| Un conteneur ne monte pas | Montrer l'exécution verte du workflow `labs` pour ce lab, puis la preuve correspondante |
| Pas de réseau | Tout le parcours B et les labs 01 à 03 tournent hors ligne, une fois les images préchargées |
| Question hors du parcours | Ouvrir le `README.md` du lab concerné : schéma, puis section « Sous le capot » |
| Question pointue | Répondre par la question de connaissance du lab, rédigée dans son journal |

## Après la démo

Noter dans le journal du lab concerné les questions posées et ce qui a coincé. Une question qui revient deux fois devient un objectif ou une section « Sous le capot ».
