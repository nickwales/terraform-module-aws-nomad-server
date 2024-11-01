variable "name" {}
variable "owner" {}
variable "region" {}
variable "vpc_id" {}

variable "cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "nomad_token" {
  default = "root"
}

variable "nomad_region" {
  default = "dc1"
}

variable "nomad_datacenter" {
  default = "dc1"
}
variable "nomad_license" {
  description = "Required for Enterprise Versions"
  default     = ""
}
variable "nomad_version" {
  default = "1.8.3"
}
variable "nomad_binary" {
  description = "To use nomad Enterprise, set this to 'nomad-enterprise'"
  default     = "nomad"
}


variable "consul_enabled" {
  description = "value"
  default     = true
}
variable "consul_binary" {
  description = "Should be 'consul' or 'consul-enterprise'"
  default     = "consul"
}

variable "consul_version" {
  default = "1.19.2"
}
variable "consul_license" {
  default = ""
}
variable "consul_token" {
  default = "root"
}
variable "consul_ca_file" {}

variable "consul_partition" {
  default = "default"
}
variable "consul_agent_token" {
  default = "root"
}
variable "consul_encryption_key" {
  default = ""
}

variable "datacenter" {
  default = "dc1"
}

variable "nomad_server_count" {
  description = "The number of nomad servers, should be 1,3 or 5"
  default     = 1
}

variable "nomad_encryption_key" {
  description = "Nomad Encryption Key, default only for dev environments"
  default     = "P4+PEZg4jDcWkSgHZ/i3xMuHaMmU8rx2owA4ffl2K8w="
}

variable "nomad_bootstrap_token" {
  description = "Do not use defaults in production"
  default     = "30d8650c-d7fa-45d7-ab6e-7a8bf7c74a6b"
}

variable "ca_file" {}
variable "cert_file" {
  default = ""
}
variable "key_file" {
  default = ""
}

variable "target_groups" {
  description = "List of target groups"
  type        = list(string)
  default     = [""]
}

variable "nomad_non_voting_server" {
  description = "Determine if a Nomad server should join the voting pool https://developer.hashicorp.com/nomad/docs/configuration/server#non_voting_server"
  type        = bool
  default     = false
}