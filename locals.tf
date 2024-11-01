locals {
  voter = var.nomad_non_voting_server ? "non-voter" : "voter"
}

