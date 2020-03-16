########### aws details #########################

variable "tags" {
  type    = "map"
  default = {}
}

variable "aws_region" {
  type    = string
}

variable "aws_profile" {
  type    = string
}

variable "aws_creds_file" {
  type    = string
}

variable "key_name" {
  type    = string
}

variable "aws_azs" {
  type    = list
  default = ["eu-west-2a","eu-west-2b"]
}

########## linux workstation base settings ###########

variable "linux_workstation_hostname" {
  type    = string
}

variable "linux_workstation_image_name" {
  type    = string
  default = "suse-sles-12-sp3-byos-v20190623-hvm-ssd-x86_64"
}

variable "linux_workstation_image_owner" {
  type    = string
  default = "013907871322"
}

variable "linux_workstation_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "linux_workstation_root_disk_size" {
  default = 40
}

variable "linux_workstation_count" {
  default = 1
}

variable "linux_workstation_chef" {
  type    = bool
  default = false
}

variable "linux_workstation_ingress_rules" {
  type    = list(string)
  default = ["ssh-tcp"]
}

variable "linux_workstation_restart" {
  type    = bool
  default = true
}

variable "workstation_access_cidr_block" {
  description = "A CIDR block from which access to workstations will be allowed"
  type        = string
  default     = "0.0.0.0/0"
}

########### windows workstation base config #############

variable "windows_workstation_hostname" {
  type    = string
}

variable "windows_workstation_image_name" {
  type    = string
  default = "Windows_Server-2016-English-Full-Base-2019.08.16"
}

variable "windows_workstation_image_owner" {
  type    = string
  default = "801119661308"
}

variable "windows_workstation_instance_type" {
  type    = string
  default = "t3.large"
}

variable "windows_workstation_root_disk_size" {
  default = 40
}

variable "windows_workstation_count" {
  default = 1
}

variable "windows_workstation_uk_keyboard" {
  default = true
}

variable "windows_workstation_enable_wsl" {
  default = true
}

variable "windows_workstation_ingress_rules" {
  type    = list(string)
  default = ["rdp-tcp", "rdp-udp", "winrm-http-tcp", "winrm-https-tcp"]
}

variable "windows_workstation_restart" {
  type    = bool
  default = true
}
########### windows server base config #############

variable "windows_server_hostname" {
  type    = string
}

variable "windows_server_image_name" {
  type    = string
  default = "Windows_Server-2016-English-Full-Base-2019.08.16"
}

variable "windows_server_image_owner" {
  type    = string
  default = "801119661308"
}

variable "windows_server_instance_type" {
  type    = string
  default = "t3.large"
}

variable "windows_server_root_disk_size" {
  default = 40
}

variable "windows_server_count" {
  default = 1
}

variable "windows_server_ingress_rules" {
  type    = list(string)
  default = ["rdp-tcp", "rdp-udp", "winrm-http-tcp", "winrm-https-tcp","http-8080-tcp"]
}

########### linux server base config #############

variable "linux_server_hostname" {
  type    = string
}

variable "linux_server_image_name" {
  type    = string
  default = "suse-sles-12-sp3-byos-v20190623-hvm-ssd-x86_64"
}

variable "linux_server_image_owner" {
  type    = string
  default = "013907871322"
}

variable "linux_server_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "linux_server_root_disk_size" {
  default = 40
}

variable "linux_server_count" {
  default = 1
}

variable "linux_server_ingress_rules" {
  type    = list(string)
  default = ["ssh-tcp", "http-8080-tcp"]
}

########### chef automate base config #############

variable "chef_automate_image_name" {
  type    = string
  default = "suse-sles-12-sp3-byos-v20190623-hvm-ssd-x86_64"
}

variable "chef_automate_image_owner" {
  type    = string
  default = "013907871322"
}

variable "chef_automate_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "chef_automate_root_disk_size" {
  default = 40
}

variable "chef_automate_count" {
  default = 1
}

variable "chef_automate_ingress_rules" {
  type    = list(string)
  default = ["ssh-tcp", "https-443-tcp", "http-80-tcp"]
}

########### chef server base config #############

variable "chef_server_hostname" {
  type    = string
}

variable "chef_server_image_name" {
  type    = string
  default = "suse-sles-12-sp3-byos-v20190623-hvm-ssd-x86_64"
}

variable "chef_server_image_owner" {
  type    = string
  default = "013907871322"
}

variable "chef_server_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "chef_server_root_disk_size" {
  default = 40
}

variable "chef_server_count" {
  default = 1
}

variable "chef_server_ingress_rules" {
  type    = list(string)
  default = ["ssh-tcp", "https-443-tcp", "http-80-tcp"]
}

########### connection details ##################

variable "windows_workstation_user_name" {
  type    = string
}

variable "windows_workstation_user_pass" {
  type    = string
}

variable "windows_server_user_name" {
  type    = string
}

variable "windows_server_user_pass" {
  type    = string
}

variable "user_name" {
  type    = string
}

variable "user_pass" {
  type    = string
  default = ""
}

variable "create_user" {
  default = false
}

variable "user_public_key" {
  type    = string
  default = ""
}

variable "user_private_key" {
  type    = string
  default = ""
}

########## chef server populate config ##########

variable "berksfiles" {
  type    = list
  default = []
}

variable "policyfiles" {
  type    = list
  default = []
}

variable "environments" {
  type    = list
  default = []
}

variable "roles" {
  type    = list
  default = []
}

variable "accept_chef_license" {
  type    = bool
  default = true
}

variable "github_cookbooks" {
  description = "A list of cookbooks to clone from github" 
  type        = list
  default     = []
}

variable "github_repos" {
  description = "A list of repos to clone from github" 
  type        = list
  default     = []
}

variable "github_ssh_key" {
  description = "The path to an ssh key to use for github auth"
  type        = string
  default     = ""
}

variable "github_user" {
  description = "A user name for an exisiting github account"
  type        = string
  default     = "jsoe"
}

variable "github_email" {
  description = "An email for an exisiting github account"
  type        = string
  default     = "jsoe@mail.com"
}
########## chef server config ###################

variable "chef_server_addons" {
  type    = map
  default = {}
}

variable "chef_server_users" {
  type    = map(object({ serveradmin=bool, first_name=string, last_name=string, email=string, password=string }))
  default = {}
}

variable "chef_server_orgs" {
  type    = map(object({ admins=list(string), org_full_name=string }))
  default = {}
}

variable "force_frontend_chef_run" {
  type    = string
  default = "default"
}

variable "chef_frontend_config" {
  type    = string
  default = ""
}

########### chef automate config ################

variable "data_collector_token" {
  type    = string
  default = ""
}

variable "chef_automate_admin_password" {
  type    = string
  default = ""
}

variable "chef_automate_license" {
  type    = string
  default = ""
}

variable "chef_automate_hostname" {
  type    = string
}

variable "chef_automate_version" {
  type    = string
  default = "latest"
}

########### populate automate config ##################

variable "chef_automate_enabled_profiles" {
  type    = list
  default = []
}

########### dns settings ########################

variable "dnsimple_oauth_token" {
  type = string
}

variable "dnsimple_account" {
  type = string
}

variable "dnsimple_domain_name" {
  type = string
}

variable "issuer_url" {
  type    = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

########### demo output #########################

variable "dev_count" {
  type = number
  default = 1
}

variable "stage_count" {
  type = number
  default = 2
}

variable "prod_count" {
  type = number
  default = 2
}

########### workstation bootstrap settings ######


