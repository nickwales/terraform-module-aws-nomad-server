locals {
  voter = var.nomad_non_voting_server ? "non-voter" : "voter"
  nomad_voter_config = var.nomad_binary == "nomad-enterprise" ? "non_voting_server = ${var.nomad_non_voting_server}" : ""
}

