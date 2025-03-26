module "hubspot_service" {
  source           = "../../modules/ec2_microservice"
  service_name     = "hubspot-service"
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  subnet_id        = var.subnet_id
  vpc_id           = var.vpc_id
  secret_name      = "flex_backend_core_service"
  docker_port      = 8000
  enable_https     = true
  domain_name      = var.domain_name
}
