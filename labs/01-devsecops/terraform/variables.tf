variable "cloud" {
  type        = string
  default     = "azure"
  description = "Cloud cible : azure ou aws."

  validation {
    condition     = contains(["azure", "aws"], var.cloud)
    error_message = "cloud doit valoir azure ou aws."
  }
}

variable "site_intl" {
  type        = string
  default     = "aucun"
  description = "Site international : aucun (site principal), ma ou es."

  validation {
    condition     = contains(["aucun", "ma", "es"], var.site_intl)
    error_message = "site_intl doit valoir aucun, ma ou es."
  }
}

variable "region" {
  type        = string
  description = "Région demandée pour le site virtuel."
}
