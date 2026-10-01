# Référentiel HubLabs

Source unique des valeurs communes à tous les labs. Un lab ne contient aucune valeur en dur : il lit ce référentiel.

| Fichier | Contenu |
| --- | --- |
| [adressage.md](adressage.md) | Sites, zones et plages d'adresses |
| [matrice-flux.md](matrice-flux.md) | Flux autorisés et interdits (F01 à F10) |
| [valeurs.env](valeurs.env) | Les mêmes valeurs, lisibles par les outils |

## Statuts

- **D** : reprise du doc 00 de la formation, fait foi.
- **P** : proposée, à valider contre le doc 00 avant usage. Une valeur P qui change se corrige ici, par un commit dédié, puis dans les labs.

## Conventions

| Élément | Convention | Exemple | Statut |
| --- | --- | --- | --- |
| Entreprise, usine | HubLabs, Usine HubLabs | — | P |
| Domaine fictif | `hublabs.example` | `ma.hublabs.example` | P |
| Codes de sites | LYO, GRE, DIJ, CLD, INT-MA, INT-ES | — | P |
| Équipements | `<site>-<rôle><nn>` | `lyo-fw01`, `int-ma-fw01` | P |
| Ressources Azure | `<type>-hublabs-lab<NN>-<région>-<nn>` | `rg-hublabs-lab04-frc-01` | P |
| Étiquettes cloud | `projet=hublabs`, `lab=NN`, `site`, `env=lab` | — | P |
| Ports locaux | `180NN` à `180NN+9` par lab | lab 02 : 18020 à 18029 | P |
| Horodatage | UTC partout, conversion à l'affichage | — | P |
