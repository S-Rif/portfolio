# Règle de région du lab 01 : un plan est refusé si la région demandée
# n'est pas autorisée pour le site choisi (SITE_INTL).
# Les régions viennent du référentiel : aucune région n'est écrite en dur ici.
terraform {
  required_version = ">= 1.4"
}

locals {
  lignes_ref = [for l in split("\n", file("${path.module}/../../../docs/referentiel/valeurs.env")) : trimspace(l) if length(regexall("^[A-Z0-9_]+=", trimspace(l))) > 0]
  ref        = { for l in local.lignes_ref : split("=", l)[0] => join("=", slice(split("=", l), 1, length(split("=", l)))) }

  # Le site Maroc n'a pas de région définie dans le référentiel : liste vide, tout plan est refusé.
  autorisees = {
    azure = {
      aucun = compact([local.ref["AZ_REGION"]])
      es    = compact([local.ref["AZ_REGION_ES"]])
      ma    = compact([])
    }
    aws = {
      aucun = compact([local.ref["AWS_REGION"]])
      es    = compact([local.ref["AWS_REGION_ES"]])
      ma    = compact([])
    }
  }

  regions_site = local.autorisees[var.cloud][var.site_intl]
}

resource "terraform_data" "site_virtuel" {
  input = {
    cloud     = var.cloud
    site_intl = var.site_intl
    region    = var.region
  }

  lifecycle {
    precondition {
      condition     = contains(local.regions_site, var.region)
      error_message = "Région ${var.region} refusée pour ${var.cloud} avec SITE_INTL=${var.site_intl}. Régions autorisées : ${length(local.regions_site) > 0 ? join(", ", local.regions_site) : "aucune (non définie dans le référentiel)"}."
    }
  }
}

output "region_retenue" {
  value = var.region
}
