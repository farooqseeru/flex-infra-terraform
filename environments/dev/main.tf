module "network" {
  source              = "../../modules/network"
  vpc_cidr_block      = "10.0.0.0/16"
  subnet_cidr_block   = "10.0.1.0/24"
  availability_zone   = "eu-west-2a"
  env                 = "dev"
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "subnet_id" {
  value = module.network.subnet_id
}
