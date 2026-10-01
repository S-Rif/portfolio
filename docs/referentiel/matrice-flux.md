# Matrice de flux

Règle de base : **tout ce qui n'est pas listé est interdit**. Cette matrice est la source des règles générées au lab 02.

| ID | Source | Destination | Service | Décision | Statut |
| --- | --- | --- | --- | --- | --- |
| F01 | À reprendre du doc 00 | | | | P |
| F02 | LYO OT exploitation (historian) | LYO iDMZ (relais supervision) | HTTPS 443 | Autorisé | P |
| F03 | À reprendre du doc 00 | | | | P |
| F04 | À reprendre du doc 00 | | | | P |
| F05 | LYO OT supervision (SCADA) | LYO OT contrôle (automates) | Modbus TCP 502 | Autorisé | P |
| F06 | LYO IT postes | LYO OT (toutes zones) | Tous | Interdit | P |
| F07 | INT (technicien distant) | LYO iDMZ (bastion) | SSH 22, sessions tracées | Autorisé | P |
| F08 | INT | LYO OT (toutes zones) | Tous | Interdit | P |
| F09 | À reprendre du doc 00 | | | | P |
| F10 | À reprendre du doc 00 | | | | P |

Les lignes « À reprendre du doc 00 » doivent être complétées avant le lab 02 : ses tests portent sur F01 à F10.
