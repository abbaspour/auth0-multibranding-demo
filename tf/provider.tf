terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "1.1.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "0.16.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
    external = {
      source = "hashicorp/external"
      version = "2.3.2"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_tf_client_id
  client_secret = var.auth0_tf_client_secret
  debug         = "true"
}


provider "vercel" {
  api_token = var.vercel_api_token
}