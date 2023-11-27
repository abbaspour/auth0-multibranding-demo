## authorisation server
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

## brand A app
resource "vercel_project" "brand_a" {
  name      = "brand-a"
}

data "vercel_project_directory" "brand_a_build" {
  path = "../apps/brand-a/build"
}

resource "vercel_deployment" "brand_a_deployment" {
  project_id  = vercel_project.brand_a.id
  files       = data.vercel_project_directory.brand_a_build.files
  path_prefix = data.vercel_project_directory.brand_a_build.path
  production  = true
}


## brand B app
resource "vercel_project" "brand_b" {
  name      = "brand-b"
}

data "vercel_project_directory" "brand_b_build" {
  path = "../apps/brand-b/dist"
}

resource "vercel_deployment" "brand_b_deployment" {
  project_id  = vercel_project.brand_b.id
  files       = data.vercel_project_directory.brand_b_build.files
  path_prefix = data.vercel_project_directory.brand_b_build.path
  production  = true
}
