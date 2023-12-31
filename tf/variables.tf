## domain
variable "demo_tld" {
  type = string
  description = "demo domain"
}

## cloudflare
variable "cloudflare_email" {
  type = string
  description = "cloudflare email"
}

variable "cloudflare_account_id" {
  type = string
  description = "cloudflare account_id"
}

variable "cloudflare_api_key" {
  type = string
  description = "cloudflare api key"
  sensitive = true
}

variable "cloudflare_zone_id" {
  type = string
  description = "cloudflare zone id"
}

variable "cloudflare_workers_domain" {
  type = string
  description = "workers domain"
}

## auth0
variable "auth0_domain" {
  type = string
  description = "Auth0 Domain"
}

variable "auth0_custom_subdomain" {
  type = string
  description = "Auth0 custom subdomain name"
}

variable "auth0_tf_client_id" {
  type = string
  description = "Auth0 TF provider client_id"
}

variable "auth0_tf_client_secret" {
  type = string
  description = "Auth0 TF provider client_secret"
  sensitive = true
}

variable "auth0_edge_location" {
  type = string
  description = "Auth0 custom domain edge location"
}

variable "auth0_cname_api_key" {
  type = string
  description = "Auth0 custom domain cname-api-key"
  sensitive = true
}
variable "default_password" {
  type = string
  description = "password for test users"
  sensitive = true
}

## vercel
variable "vercel_api_token" {
  type = string
  description = "vercel token"
  sensitive = true
}

variable "brand_a_subdomain" {
  type = string
  default = "a"
}

variable "brand_b_subdomain" {
  type = string
  default = "b"
}

## mailtrap
variable "mailtrap_smtp_user" {
  type = string
}

variable "mailtrap_smtp_pass" {
  type = string
  sensitive = true
}