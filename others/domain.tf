resource "digitalocean_floating_ip" "main_domain_handler" {
  droplet_id = "${digitalocean_droplet.mainserver.id}"
  region     = "${digitalocean_droplet.mainserver.region}"
}

resource "digitalocean_domain" "main_domain" {
  name       = "${var.domain_name}"
  ip_address = "${digitalocean_floating_ip.main_domain_handler.ip_address}"
}

resource "digitalocean_record" "drone_record" {
  domain = "${digitalocean_domain.main_domain.name}"
  type   = "A"
  name   = "${var.drone_subdomain}"
  value  = "${digitalocean_floating_ip.main_domain_handler.ip_address}"
}