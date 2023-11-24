resource "vercel_project" "hosting" {
  name      = "multibrand-hosting"
}

data "vercel_project_directory" "css_files" {
  depends_on = [local_file.brand_a_css, local_file.brand_b_css]
  path = "../static"
}

resource "vercel_deployment" "css_deployment" {
  project_id  = vercel_project.hosting.id
  files       = data.vercel_project_directory.css_files.files
  path_prefix = data.vercel_project_directory.css_files.path
  production  = true
}