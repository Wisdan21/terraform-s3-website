module "website" {
  source = "github.com/glennbechdevops/s3-website-module/"
  bucket_name = var.bucket_name
}


