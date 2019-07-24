resource "digitalocean_firewall" "only_home_allowed" {
  name = "only-home-access-allowed"

  droplet_ids = ["${digitalocean_droplet.mainserver.id}"]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["${var.allowed_ip}"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    source_addresses = ["${var.allowed_ip}"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "all"
    source_addresses = ["${var.allowed_ip}"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
