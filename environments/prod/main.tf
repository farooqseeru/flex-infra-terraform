module "network" {
  source              = "../../modules/network"
  vpc_cidr_block      = "10.2.0.0/16"
  subnet_cidr_block   = "10.2.1.0/24"
  availability_zone   = "eu-west-2a"
  env                 = "prod"
}
