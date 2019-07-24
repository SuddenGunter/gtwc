provider "digitalocean" {
  token = "${var.do_token}"
}
variable "do_token" {}

variable "ssh_md5" {}
variable "ssh_private_key" {}
variable "ssh_public_key" {}

variable "docker_username" {}
variable "docker_password" {}

variable "system_password" {}
variable "system_username" {}

variable "droplet_name" {}

variable "allowed_ips" {
  type    = list(string)
}