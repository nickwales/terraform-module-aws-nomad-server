locals {
  voter = var.nomad_non_voting_server ? "non-voter" : "voter"
  nomad_voter_config = var.nomad_binary == "nomad-enterprise" ? "non_voting_server = ${var.nomad_non_voting_server}" : "#############"
  nomad_bootstrap_expect = var.nomad_non_voting_server ? "" : "bootstrap_expect = ${var.nomad_server_count}"
}
