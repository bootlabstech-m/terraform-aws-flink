variable "name" {
  type = string

}
variable "runtime_environment" {
  type = string

}
# variable "bucket_arn" {
#   type = string

# }
# variable "file_key" {
#   type = string

# }
variable "code_content_type" {
  type    = string
  default = "ZIPFILE"

}
variable "region" {
  type    = string
  default = "ap-south-1"

}

