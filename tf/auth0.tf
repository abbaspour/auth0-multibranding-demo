resource "auth0_tenant" "tenant_config" {
  friendly_name = "Multi Branding Demo"
  default_redirection_uri = "https://${vercel_project.hosting.name}.vercel.app"

  flags {
    enable_client_connections = false
  }
}

# Users DB
resource "auth0_connection" "users" {
  name = "Users"
  strategy = "auth0"

  options {
    requires_username = false
    password_policy = "low"
    disable_signup = false
    brute_force_protection = true
  }
}

# Brand clients
resource "auth0_client" "brand_a" {
  name = "Brand A"
  description = "Brand A client"
  app_type = "spa"
  oidc_conformant = true
  is_first_party = true

  callbacks = [
    "https://jwt.io"
  ]

  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_client" "brand_b" {
  name = "Brand B"
  description = "Brand B client"
  app_type = "spa"
  oidc_conformant = true
  is_first_party = true

  callbacks = [
    "https://jwt.io"
  ]

  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_connection_clients" "brands_central_user_store" {
  connection_id   = auth0_connection.users.id
  enabled_clients = [auth0_client.brand_a.id, auth0_client.brand_b.id, var.auth0_tf_client_id]
}

## Branding
resource "auth0_branding" "brand" {
  logo_url = "https://upload.wikimedia.org/wikipedia/en/thumb/d/d0/Service_NSW_Logo.png/440px-Service_NSW_Logo.png"
  favicon_url = "https://www.lesmills.com.au/themes/lmap/favicon/favicon.ico"
}

resource "auth0_pages" "cul_pages" {
  login {
    enabled = true
    html    = file("../ul/classic.html")
  }
}

## Users
resource "auth0_user" "user_1" {
  depends_on = [auth0_connection_clients.brands_central_user_store]
  connection_name = auth0_connection.users.name
  email = "user1@atko.email"
  password = var.default_password
}

resource "auth0_user" "user_2" {
  depends_on = [auth0_connection_clients.brands_central_user_store]
  connection_name = auth0_connection.users.name
  email = "user2@atko.email"
  password = var.default_password
}

## Email Server
resource "auth0_email_provider" "mailtrap_provider" {
  name = "smtp"
  enabled = true
  default_from_address = "noreply@multibrand.app"
  credentials {
    smtp_host = "sandbox.smtp.mailtrap.io"
    smtp_port = 2525
    smtp_user = var.mailtrap_smtp_user
    smtp_pass = var.mailtrap_smtp_pass
  }
}

## outputs
output "brand_a_client" {
  value = auth0_client.brand_a.id
}

output "brand_b_client" {
  value = auth0_client.brand_b.id
}