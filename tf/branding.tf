# brand A
resource "local_file" "brand_a_css" {
  content  = file("../dynamic/a.css")
  filename = "../static/css/${auth0_client.brand_a.client_id}.css"
}

# brand B
resource "local_file" "brand_b_css" {
  content  = file("../dynamic/b.css")
  filename = "../static/css/${auth0_client.brand_b.client_id}.css"
}

