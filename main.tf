terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">=3.0.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = ">=0.20.0"
    }
  }
}

provider "vault" {
  address = data.terraform_remote_state.hcp.outputs.consul_public_address
  token   = hcp_consul_cluster_root_token.consul_root_token.token
}

provider "hcp" {}

data "terraform_remote_state" "hcp" {
  backend = "remote"

  config = {
    organization = "mtharpe"
    workspaces = {
      name = "terraform-hcp-demo"
    }
  }
}

resource "hcp_consul_cluster_root_token" "consul_root_token" {
  cluster_id = "demo-consul-cluster"
}
