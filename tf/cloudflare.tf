# configure worker to proxy auth0 routes
resource "cloudflare_worker_script" "auth0_worker" {
  name       = "custom-domain-worker"
  content    = file("./worker.js")
  account_id = var.cloudflare_account_id

  plain_text_binding {
    name = "AUTH0_EDGE_RECORD"
    text = var.auth0_edge_location
  }

  secret_text_binding {
    name = "CNAME_API_KEY"
    text = var.auth0_cname_api_key
  }
}

# set worker to proxy auth0 routes
resource "cloudflare_worker_route" "auth0_route" {
  zone_id     = var.cloudflare_zone_id
  pattern     = "${local.auth0_custom_domain}/*"
  script_name = cloudflare_worker_script.auth0_worker.name
}

# add an auth0 CNAME record to the owner zone
resource "cloudflare_record" "auth0_cname" {
  zone_id = var.cloudflare_zone_id
  name    = "id1"
  type    = "CNAME"
  value   = "${cloudflare_worker_script.auth0_worker.name}.${var.cloudflare_workers_domain}"
  proxied = true
  ttl     = 1
}

# app hosting domain names
resource "cloudflare_record" "naked" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "A"
  value   = "76.76.21.21"
  proxied = false
  ttl     = 300
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "CNAME"
  value   = "cname.vercel-dns.com."
  proxied = false
  ttl     = 300
}

resource "cloudflare_record" "brand_a_subdomain" {
  zone_id = var.cloudflare_zone_id
  name    = var.brand_a_subdomain
  type    = "CNAME"
  value   = "cname.vercel-dns.com."
  proxied = false
  ttl     = 300
}

resource "cloudflare_record" "brand_b_subdomain" {
  zone_id = var.cloudflare_zone_id
  name    = var.brand_b_subdomain
  type    = "CNAME"
  value   = "cname.vercel-dns.com."
  proxied = false
  ttl     = 300
}
