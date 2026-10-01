# Lab 03 · Préparation

## Contexte

Un automate parle Modbus TCP : aucun chiffrement, aucune authentification. Quiconque atteint le port 502 peut lire et écrire des registres. La seule défense réaliste est architecturale : des zones étanches, des conduits explicites et une détection sur chaque conduit. Ce lab construit cette architecture en conteneurs, la double d'une maquette Packet Tracer multi-sites et la rend observable.

## Moyens

| Outil | Rôle dans le lab | Licence et coût | Version |
| --- | --- | --- | --- |
| Docker Engine et Compose | Zones Purdue en réseaux isolés | Libre, 0 € | à figer au démarrage |
| Simulateur Modbus (pymodbus) | Automate et client SCADA | Libre, 0 € | à figer au démarrage |
| Suricata | Détection d'intrusion, parseur Modbus | Libre, 0 € | à figer au démarrage |
| Loki, Grafana Alloy, Grafana | Collecte et tableau de bord | Libre, 0 € en auto-hébergé | à figer au démarrage |
| Cisco Packet Tracer (Windows) | Maquette réseau multi-sites | Gratuit avec un compte Cisco Networking Academy | à figer au démarrage |
| Rôle `nva` du lab 02 | Règles du pare-feu `lyo-fw01` | Interne | à figer au démarrage |

Règle : chaque version est relevée au démarrage (`<outil> --version`) et reportée dans ce tableau. Une version non figée rend le lab non rejouable.

## Gratuit ou payant

| Poste | Option gratuite | Option payante | Choix du lab |
| --- | --- | --- | --- |
| Automates | Simulateur pymodbus | Automate physique ou logiciel sous licence | Simulateur |
| Observabilité | Loki et Grafana auto-hébergés | Offre cloud managée | Auto-hébergé |
| Maquette réseau | Packet Tracer | GNS3 ou EVE-NG avec images constructeur | Packet Tracer |

Lab sans coût : 0 €. Aucun compte payant, aucune carte bancaire.

## Prérequis

- Labs 00 et 02 validés (le pare-feu de zone vient du lab 02).
- Packet Tracer installé sous Windows.
- Notions : modèle Purdue, ce qu'est un automate et un registre Modbus.

## Valeurs du référentiel utilisées

Statut **D** : reprise du doc 00 de la formation, fait foi. Statut **P** : proposée, à valider contre le doc 00 avant usage.

| Élément | Valeur | Statut |
| --- | --- | --- |
| LYO IT postes / serveurs (niveau 4) | 10.20.1.0/24 / 10.20.2.0/24 | P |
| LYO iDMZ (niveau 3.5) | 10.20.8.0/24 | P |
| LYO OT exploitation (niveau 3) | 10.20.9.0/24 | P |
| LYO OT supervision (niveau 2) | 10.20.10.0/24 | P |
| LYO OT contrôle (niveau 1) | 10.20.11.0/24 | P |
| GRE / DIJ | 10.20.16.0/20 / 10.20.32.0/20 | P |
| CLD / INT-MA / INT-ES | 10.20.48.0/20 / 10.20.64.0/20 / 10.20.80.0/20 | P |
| Ports locaux du lab (Grafana inclus) | 18030 à 18039 | P |

## Ressources machine

3 à 4 Go de RAM avec Suricata, Loki et Grafana. 8 Go conseillés sur le poste ; limiter WSL dans `.wslconfig`.

## Sécurité et données

- Fil rouge fictif uniquement : HubLabs, domaine réservé `hublabs.example`, aucune donnée réelle de client, d'employeur ou de personne.
- Aucun secret dans Git, dans une capture ou dans un échange : variables d'environnement, fichiers ignorés, identité fédérée (OIDC) pour la CI.
- `pre-commit` actif avant le premier commit du lab.
