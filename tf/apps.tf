# brand A react
resource "local_file" "brand_a_config" {
  content  = <<EOF
{
  "domain": "${local.auth0_custom_domain}",
  "clientId": "${auth0_client.brand_a.client_id}",
  "audience": ""
}
EOF
  filename = "../apps/brand-a/src/auth_config.json"
}

# brand B vue
resource "local_file" "brand_b_config" {
  content  = <<EOF
{
  "domain": "${local.auth0_custom_domain}",
  "clientId": "${auth0_client.brand_b.client_id}"
}
EOF
  filename = "../apps/brand-b/auth_config.json"
}

