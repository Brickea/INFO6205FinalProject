variable "project_name" {
  default = "AVS-"
}

variable "subdomain_zone_id" {
  default = "Z06040141HS23QE67878Q"
}

variable "subdomain_name" {
  default = "avs.brickea.me"
}

variable "s3_role_policy" {
  default = "policies/s3_role_policy.json"
}

variable "s3_codeDeploy_role_policy" {
  default = "policies/s3_codeDeploy_role_policy.json"
}

variable "s3_ghUpload_role_policy" {
  default = "policies/s3_ghUpload_role_policy.json"
}

variable "gh_code_deploy_call_codeDeply_policy" {
  default = "policies/gh_code_deploy_call_codeDeploy_policy.json"
}

variable "s3_file_bucket_name" {
  default = "avs.dev.zixiao.wang"
}

variable "s3_codedeploy_bucket_name" {
    default = "avs.codedeploy.dev.brickea.me"
}