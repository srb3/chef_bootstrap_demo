############ chef server outputs ##############

output "chef_server_ip" {
  value = module.chef_server_base.server_public_ip
}

output "chef_client_name" {
  value = module.populate_chef_server.workstation_user_name
}

output "chef_org_url" {
  value = module.populate_chef_server.workstation_org_url
}

output "chef_org_name" {
  value = module.populate_chef_server.workstation_org_name
}

############ chef automate outputs ##############

output "automate_ip" {
  value = module.chef_automate.ip
}
output "automate_pass" {
  value = module.chef_automate.admin_pass
}

output "automate_user" {
  value = module.chef_automate.admin_user
}

output "automate_url" {
  value = module.chef_automate.url
}

output "automate_token" {
  value = module.chef_automate.token
}

########### linux server outputs ################

output "linux_server_public_ips" {
  value = module.linux_server_base.server_public_ip
}

output "linux_server_private_ips" {
  value = module.linux_server_base.server_private_ip
}

########### linux workstation outputs ################

output "linux_workstation_ips" {
  value = module.linux_workstation_base.server_public_ip
}

########### windows server outputs ################

output "windows_server_public_ips" {
  value = module.windows_server_base.server_public_ip
}

output "windows_server_private_ips" {
  value = module.windows_server_base.server_private_ip
}

########### windows workstation outputs ################

output "windows_workstation_ips" {
  value = module.windows_workstation_base.server_public_ip
}

########### all server outputs ################

output "all_server_public_ips" {
  value = local.all_server_public_ips
}

output "all_server_private_ips" {
  value = local.all_server_private_ips
}

########### demo output ###############
output "prod" {
  value = length(module.windows_server_base.server_private_ip) > 0 ? length(module.linux_server_base.server_private_ip) > 0 ? concat(slice(module.windows_server_base.server_private_ip,0,var.prod_count),slice(module.linux_server_base.server_private_ip,0,var.prod_count)) : [] : []
}

output "stage" {
  value = length(module.windows_server_base.server_private_ip) > 0 ? length(module.linux_server_base.server_private_ip) > 0 ? concat(slice(module.windows_server_base.server_private_ip,var.dev_count,var.dev_count+var.stage_count),slice(module.linux_server_base.server_private_ip,0,var.stage_count)) : [] : []
}

output "dev" {
  value = length(module.windows_server_base.server_private_ip) > 0 ? length(module.linux_server_base.server_private_ip) > 0 ? concat(slice(module.windows_server_base.server_private_ip,local.ps_count,local.all_w_count),slice(module.linux_server_base.server_private_ip,local.ps_count,local.all_l_count)) : [] : []
}

locals {
  ps_count = (var.prod_count+var.stage_count)
  all_server_public_ips = concat(module.windows_server_base.server_public_ip, module.linux_server_base.server_public_ip)
  all_server_private_ips = concat(module.windows_server_base.server_private_ip, module.linux_server_base.server_private_ip)
  all_w_count = length(module.windows_server_base.server_private_ip)
  all_l_count = length(module.linux_server_base.server_private_ip)
  win_name_ip = {
    for index, ip in module.windows_server_base.server_private_ip:
      "windows-server-${index}" => ip
  }
  lin_name_ip = {
    for index, ip in module.linux_server_base.server_private_ip:
      "linux-server-${index}" => ip
  }  
}

output "win_name_ip" {
  value = local.win_name_ip
}

output "lin_name_ip" {
  value = local.lin_name_ip
}
