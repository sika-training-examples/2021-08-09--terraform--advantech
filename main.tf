module "dev" {
  source = "./env/dev"
}

output "dev" {
  value = {
    example-ip     = module.dev.example-ip
    postgres1-host = module.dev.postgres1-host
  }
}

output "dev-sensitive" {
  value = {
    postgres1-password = module.dev.postgres1-password
  }
  sensitive = true
}

module "prod" {
  source = "./env/prod"
}
