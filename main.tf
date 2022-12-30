module "iam_expo" {
  source = "./modules/iam"
}

module "api-gw" {
  source = "./modules/api-gateway-policy"
}