terraform {
  required_version = "> 0.12.0"
}

provider "aws" {
  shared_credentials_file = var.aws_creds_file
  profile                 = var.aws_profile
  region                  = var.aws_region
}

resource "random_id" "hash" {
  byte_length = 4
}

locals {
  common_name      = "${lookup(var.tags, "prefix", "changeme")}-${random_id.hash.hex}"
}

module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  version                 = "2.5.0"
  name                    = "${local.common_name}-chef-vpc"
  cidr                    = "10.0.0.0/16"
  azs                     = var.aws_azs
  public_subnets          = ["10.0.1.0/24"]
  map_public_ip_on_launch = true
  tags                    = var.tags
}
# module.vpc.vpc_cidr_block
module "windows_server_base" {
  source                      = "srb3/workshop-server/aws"
  version                     = "0.0.22"
  key_name                    = var.key_name
  create_user                 = var.create_user
  user_name                   = var.windows_server_user_name
  user_pass                   = var.windows_server_user_pass
  sec_grp_ingress_rules       = var.windows_server_ingress_rules
  sec_grp_ingress_cidr_blocks = [module.vpc.vpc_cidr_block, var.workstation_access_cidr_block]
  public_ip                   = true
  server_count                = var.windows_server_count
  server_image_name           = var.windows_server_image_name
  server_image_owner          = var.windows_server_image_owner
  server_instance_type        = var.windows_server_instance_type
  subnets                     = module.vpc.public_subnets
  instance_name               = var.windows_server_hostname
  vpc_id                      = module.vpc.vpc_id
  tags                        = var.tags
  system_type                 = "windows"
}

module "linux_server_base" {
  source                      = "srb3/workshop-server/aws"
  version                     = "0.0.22"
  key_name                    = var.key_name
  create_user                 = var.create_user
  user_name                   = var.user_name
  user_public_key             = var.user_public_key
  sec_grp_ingress_rules       = var.linux_server_ingress_rules
  sec_grp_ingress_cidr_blocks = [module.vpc.vpc_cidr_block, var.workstation_access_cidr_block]
  public_ip                   = true
  server_count                = var.linux_server_count
  user_private_key            = var.user_private_key
  server_image_name           = var.linux_server_image_name
  server_image_owner          = var.linux_server_image_owner
  server_instance_type        = var.linux_server_instance_type
  subnets                     = module.vpc.public_subnets
  instance_name               = var.linux_server_hostname
  vpc_id                      = module.vpc.vpc_id
  tags                        = var.tags
}

module "linux_workstation_base" {
  source                      = "srb3/workshop-server/aws"
  version                     = "0.0.22"
  key_name                    = var.key_name
  create_user                 = var.create_user
  user_name                   = var.user_name
  user_public_key             = var.user_public_key
  sec_grp_ingress_rules       = var.linux_workstation_ingress_rules
  sec_grp_ingress_cidr_blocks = [var.workstation_access_cidr_block]
  server_count                = var.linux_workstation_count
  user_private_key            = var.user_private_key
  server_image_name           = var.linux_workstation_image_name
  server_image_owner          = var.linux_workstation_image_owner
  server_instance_type        = var.linux_workstation_instance_type
  workstation_chef            = true
  install_workstation_tools   = true
  subnets                     = module.vpc.public_subnets
  instance_name               = var.linux_workstation_hostname
  vpc_id                      = module.vpc.vpc_id
  tags                        = var.tags
}

module "chef_server_base" {
  source                      = "srb3/workshop-server/aws"
  version                     = "0.0.22"
  key_name                    = var.key_name
  create_user                 = var.create_user
  user_name                   = var.user_name
  user_public_key             = var.user_public_key
  sec_grp_ingress_rules       = var.chef_server_ingress_rules
  sec_grp_ingress_cidr_blocks = [module.vpc.vpc_cidr_block, var.workstation_access_cidr_block]
  public_ip                   = true
  server_count                = var.chef_server_count
  user_private_key            = var.user_private_key
  server_image_name           = var.chef_server_image_name
  server_image_owner          = var.chef_server_image_owner
  server_instance_type        = var.chef_server_instance_type
  subnets                     = module.vpc.public_subnets
  instance_name               = var.chef_server_hostname
  vpc_id                      = module.vpc.vpc_id
  tags                        = var.tags
}

module "chef_automate_base" {
  source                      = "srb3/workshop-server/aws"
  version                     = "0.0.22"
  key_name                    = var.key_name
  create_user                 = var.create_user
  user_name                   = var.user_name
  user_public_key             = var.user_public_key
  sec_grp_ingress_rules       = var.chef_automate_ingress_rules
  sec_grp_ingress_cidr_blocks = [module.vpc.vpc_cidr_block, var.workstation_access_cidr_block]
  public_ip                   = true
  server_count                = var.chef_automate_count
  user_private_key            = var.user_private_key
  server_image_name           = var.chef_automate_image_name
  server_image_owner          = var.chef_automate_image_owner
  server_instance_type        = var.chef_automate_instance_type
  subnets                     = module.vpc.public_subnets
  instance_name               = var.chef_automate_hostname
  vpc_id                      = module.vpc.vpc_id
  tags                        = var.tags
}

module "windows_workstation_base" {
  source                      = "srb3/workshop-server/aws"
  version                     = "0.0.22"
  key_name                    = var.key_name
  create_user                 = var.create_user
  user_name                   = var.windows_workstation_user_name
  user_pass                   = var.windows_workstation_user_pass
  sec_grp_ingress_rules       = var.windows_workstation_ingress_rules
  sec_grp_ingress_cidr_blocks = [var.workstation_access_cidr_block]
  server_count                = var.windows_workstation_count
  user_private_key            = var.user_private_key
  server_image_name           = var.windows_workstation_image_name
  server_image_owner          = var.windows_workstation_image_owner
  server_instance_type        = var.windows_workstation_instance_type
  subnets                     = module.vpc.public_subnets
  workstation_chef            = true
  instance_name               = var.windows_workstation_hostname
  install_workstation_tools   = true
  vpc_id                      = module.vpc.vpc_id
  tags                        = var.tags
  system_type                 = "windows"
  kb_uk                       = var.windows_workstation_uk_keyboard
  wsl                         = var.windows_workstation_enable_wsl
}

locals {
  chef_server_records = { for ip in module.chef_server_base.server_private_ip : "${var.chef_server_hostname}-${index(module.chef_server_base.server_private_ip, ip)}" => ip }
  chef_automate_records = { for ip in module.chef_automate_base.server_private_ip : "${var.chef_automate_hostname}-${index(module.chef_automate_base.server_private_ip, ip)}" => ip }
}

module "chef_server_dns" {
  source         = "srb3/record/dnsimple"
  version        = "0.0.2"
  records        = local.chef_server_records
  instance_count = var.chef_server_count
  domain_name    = var.dnsimple_domain_name
  oauth_token    = var.dnsimple_oauth_token
  account        = var.dnsimple_account
}

module "chef_automate_dns" {
  source         = "srb3/record/dnsimple"
  version        = "0.0.2"
  records        = local.chef_automate_records
  instance_count = var.chef_automate_count
  domain_name    = var.dnsimple_domain_name
  oauth_token    = var.dnsimple_oauth_token
  account        = var.dnsimple_account
}

module "chef_server" {
  source               = "srb3/chef-server/linux"
  version              = "0.0.12"
  ips                  = module.chef_server_base.server_public_ip
  instance_count       = var.chef_server_count
  ssh_user_name        = var.user_name
  ssh_user_private_key = var.user_private_key
  fqdns                = module.chef_server_dns.hostname
  addons               = var.chef_server_addons
  users                = var.chef_server_users
  orgs                 = var.chef_server_orgs
  config               = var.chef_frontend_config
  force_run            = var.force_frontend_chef_run
  automate_module      = jsonencode(module.chef_automate)
}

module "populate_chef_server" {
  source                = "srb3/chef-server-populate/linux"
  version               = "0.0.10"
  ip                    = length(module.chef_server_base.server_public_ip) > 0 ? module.chef_server_base.server_public_ip[0] : ""
  user_name             = var.user_name
  user_private_key      = var.user_private_key
  chef_module           = jsonencode(module.chef_server)
#  policyfiles           = file("${path.module}/files/policyfiles.json")
}

module "chef_automate" {
  source                = "srb3/chef-automate/linux"
  version               = "0.0.24"
  ips                   = module.chef_automate_base.server_public_ip
  instance_count        = var.chef_automate_count
  install_version       = var.chef_automate_version
  ssh_user_name         = var.user_name
  ssh_user_private_key  = var.user_private_key
  fqdns                 = module.chef_automate_dns.hostname
  chef_automate_license = var.chef_automate_license
  data_collector_token  = var.data_collector_token
  admin_password        = var.chef_automate_admin_password
}

module "populate_automate_server" {
  source           = "srb3/chef-automate-populate/linux"
  version          = "0.0.8"
  ips              = module.chef_automate_base.server_public_ip
  instance_count   = var.chef_automate_count
  user_name        = var.user_name
  automate_module  = jsonencode(module.chef_automate)
  user_private_key = var.user_private_key
  enabled_profiles = var.chef_automate_enabled_profiles
}

module "setup_workstations" {
  source                   = "/home/steveb/workspace/terraform/modules/srb3/terraform-chef-workstation"
  ips                      = module.windows_workstation_base.server_public_ip
  instance_count           = var.windows_workstation_count
  user_name                = var.windows_workstation_user_name
  user_pass                = var.windows_workstation_user_pass
  chef_module              = jsonencode(module.chef_server)
  automate_module          = jsonencode(module.chef_automate)
#  policyfiles              = file("${path.module}/files/policyfiles.json")
#  github_cookbooks         = jsonencode(var.github_cookbooks)
  github_repos             = jsonencode(var.github_repos)
  github_ssh_key           = file(var.github_ssh_key)
  bootstrap_github_user    = var.github_user
  bootstrap_github_email   = var.github_email
  server_ssh_key           = file(var.user_private_key)
  urls                     = length(module.chef_server.org_url) > 0 ? length(module.chef_automate.url) > 0 ? [module.chef_server.org_url[0], module.chef_automate.url[0]] : [] : []
  restart                  = var.windows_workstation_restart
  bootstrap_winrm_username = var.windows_server_user_name
  bootstrap_winrm_password = var.windows_server_user_pass
  bootstrap_ssh_username   = var.user_name
  bootstrap_win_ips        = module.windows_server_base.server_private_ip
  bootstrap_lin_ips        = module.linux_server_base.server_private_ip
  bootstrap_dev_count      = var.dev_count
  bootstrap_stage_count    = var.stage_count
  bootstrap_prod_count     = var.prod_count
  system_type              = "windows"
}

module "setup_linux_workstations" {
  source           = "/home/steveb/workspace/terraform/modules/srb3/terraform-chef-workstation"
  ips              = module.linux_workstation_base.server_public_ip
  instance_count   = var.linux_workstation_count
  user_name        = var.user_name
  user_pass        = var.user_pass
  chef_module      = jsonencode(module.chef_server)
#  policyfiles      = file("${path.module}/files/policyfiles.json")
#  github_cookbooks = jsonencode(var.github_cookbooks)
  github_repos     = jsonencode(var.github_repos)
  github_ssh_key   = file(var.github_ssh_key)
  server_ssh_key   = file(var.user_private_key)
  restart          = var.linux_workstation_restart
  system_type      = "linux"
}

resource "random_shuffle" "all_private_ips" {
  input = concat(module.windows_server_base.server_private_ip, module.linux_server_base.server_private_ip)
}

resource "random_shuffle" "all_public_ips" {
  input = concat(module.windows_server_base.server_public_ip, module.linux_server_base.server_public_ip)
}
