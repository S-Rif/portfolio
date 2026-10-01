# Adressage

Plages reprises des fiches de labs. Les valeurs D font foi ; les valeurs P sont à confirmer contre le doc 00.

## Sites

| Site | Plage | Statut |
| --- | --- | --- |
| LYO, Usine HubLabs | 10.20.0.0/20 | P |
| GRE | 10.20.16.0/20 | P |
| DIJ | 10.20.32.0/20 | P |
| CLD, site virtuel cloud (Azure) | 10.20.48.0/20 | P |
| INT-MA, site international Maroc | 10.20.64.0/20 | P |
| INT-ES, site international Espagne | 10.20.80.0/20 | P |
| CLD-AWS, site virtuel AWS | 10.20.96.0/20 (proposition, réserve) | P |
| Transit des tunnels | 10.20.252.0/24 | P |

## Zones de LYO (modèle Purdue)

| Zone | Niveau | Plage | Statut |
| --- | --- | --- | --- |
| IT postes | 4 | 10.20.1.0/24 | P |
| IT serveurs | 4 | 10.20.2.0/24 | P |
| iDMZ (bastion, relais) | 3.5 | 10.20.8.0/24 | P |
| OT exploitation | 3 | 10.20.9.0/24 | P |
| OT supervision | 2 | 10.20.10.0/24 | P |
| OT contrôle (automates) | 1 | 10.20.11.0/24 | P |

## Azure

| Réseau | Plage | Statut |
| --- | --- | --- |
| Hub | 10.50.0.0/16 | D |
| Spoke dev | 10.10.0.0/16 | D |
| Spoke prod | 10.40.0.0/16 | D |

## Régions

| Usage | Azure | AWS | Statut |
| --- | --- | --- | --- |
| Base | francecentral | eu-west-3 | P |
| Option Espagne | spaincentral | eu-south-2 | P |
| Option Maroc | région européenne la plus proche (à vérifier) | idem | P |
