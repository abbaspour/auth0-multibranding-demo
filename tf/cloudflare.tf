# configure worker to proxy auth0 routes
resource "cloudflare_worker_script" "auth0_worker" {
  name    = "custom-domain-worker"
  content = file("./worker.js")
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
  pattern     = "${var.auth0_custom_domain}/*"
  script_name = cloudflare_worker_script.auth0_worker.name
}

resource "cloudflare_worker_route" "auth0_route_2" {
  zone_id     = var.cloudflare_zone_id
  pattern     = "id2.multibrand.app/*"
  script_name = cloudflare_worker_script.auth0_worker.name
}

# add an auth0 CNAME record to the owner zone
resource "cloudflare_record" "auth0_cname" {
  zone_id = var.cloudflare_zone_id
  name    = "id1"
  type    = "CNAME"
  value = "${cloudflare_worker_script.auth0_worker.name}.${var.cloudflare_workers_domain}"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "auth0_cname_2" {
  zone_id = var.cloudflare_zone_id
  name    = "id2"
  type    = "CNAME"
  value = "${cloudflare_worker_script.auth0_worker.name}.${var.cloudflare_workers_domain}"
  proxied = true
  ttl     = 1
}
