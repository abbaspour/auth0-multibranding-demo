## UL
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

## Email Templates
# verification email
data "local_file" "brand_a_email_verification_link" {
  filename = "../email-templates/email-verification-link/a-email-verification-link.html"
}

data "local_file" "brand_b_email_verification_link" {
  filename = "../email-templates/email-verification-link/b-email-verification-link.html"
}

data "local_file" "generic_email_verification_link" {
  filename = "../email-templates/email-verification-link/generic-email-verification-link.html"
}

resource "local_file" "email_verification_link_template" {
  filename = "../email-templates/rendered/email-verification-link.liquid"
  content = templatefile("./email.tpl", {
    config = {
      (auth0_client.brand_a.client_id) = data.local_file.brand_a_email_verification_link.content
      (auth0_client.brand_b.client_id) = data.local_file.brand_b_email_verification_link.content
    }
    generic = data.local_file.generic_email_verification_link.content
  })
}

resource "auth0_email_template" "email_verification_link" {
  depends_on = [auth0_email_provider.mailtrap_provider]

  body     = local_file.email_verification_link_template.content
  enabled  = true
  from     = "noreply@atko.email" # todo: liquid
  subject  = "email verification" # todo: liquid
  syntax   = "liquid"
  template = "verify_email"
}