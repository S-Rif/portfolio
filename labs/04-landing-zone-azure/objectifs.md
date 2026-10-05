# Lab 04 · Objectifs et preuves

Un objectif passe à « Validé » **uniquement** quand sa colonne **Preuve** est remplie : lien vers un fichier de [`preuves/`](preuves/) puis le commit court. Le workflow `qualite` refuse un « Validé » sans preuve.

Nommage d'une preuve : `L04-On-AAAA-MM-JJ-sujet.txt` (sortie de commande, préférée) ou `.png`. Relis-la avant de la committer : ni secret, ni jeton, ni adresse e-mail, ni donnée réelle.

## Objectifs

| ID | Objectif mesurable | Preuve attendue | Statut | Preuve |
| --- | --- | --- | --- | --- |
| L04-O1 | Hub-spoke conforme aux plages D (10.50, 10.10, 10.40) | `terraform plan` propre et inventaire des VNet et peerings | À faire | |
| L04-O2 | Site virtuel CLD relié au hub en IPsec | Tunnel établi, ping de CLD vers le spoke prod | À faire | |
| L04-O3 | Déploiement sans secret statique (OIDC) | Pipeline sans `client_secret`, journal de connexion fédérée | À faire | |
| L04-O4 | Politiques : régions autorisées et étiquettes obligatoires | Ressource non conforme refusée (message d'Azure Policy) | À faire | |
| L04-O5 | Budget avec alerte avant le premier apply | Alerte de budget reçue (seuil de test bas) | À faire | |
| L04-O6 | Destroy puis apply redonne le socle | Deux exécutions successives, plans identiques | À faire | |
| L04-O7 | Option internationale chiffrée avant activation | Coût mesuré consigné dans le journal | À faire | |

Statuts : À faire, En cours, Validé, Bloqué.

## Hors périmètre

- Groupes d'administration et abonnements multiples (un seul abonnement de lab).
- Azure Firewall et VPN Gateway (chiffrés dans l'ADR, non déployés).
- Déploiement de l'application elle-même (lab 05).

## Compétences visées

Échelle de 0 à 4 : voir la [méthode](../README.md#niveaux-de-compétence).

| Compétence | Niveau visé | Comment c'est vérifié |
| --- | --- | --- |
| Terraform : modules, état distant, verrouillage | 3 | Destroy puis apply sans écart |
| Réseau Azure : peering, routage utilisateur (UDR), NVA | 3 | Chemin d'un paquet expliqué de CLD au spoke prod |
| Identité fédérée OIDC pour la CI | 3 | Revendication `subject` expliquée et restreinte |
| Gouvernance : Azure Policy, budget, FinOps | 2 | Refus de policy et alerte reproduits |

## Question de connaissance

Ton apply passe par une identité fédérée sans secret. Qu'est-ce qui empêche une branche quelconque de déclencher un apply avec cette identité ? Montre la revendication `subject` exacte que tu autorises et explique pourquoi elle suffit.

Réponse rédigée dans le [journal](journal.md).
