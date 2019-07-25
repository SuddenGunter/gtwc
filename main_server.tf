resource "digitalocean_droplet" "mainserver" {
  image      = "ubuntu-18-04-x64"
  name       = "${var.droplet_name}"
  region     = "ams3"
  size       = "s-2vcpu-2gb"
  monitoring = true
  ssh_keys = [
    "${var.ssh_md5}"
  ]

  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.ssh_private_key)}"
    timeout     = "4m"
    host        = "${self.ipv4_address}"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",

      #firewall setup
      "ufw allow OpenSSH",
      "sudo ufw allow http",
      "sudo ufw allow https",
      "ufw --force enable",

      #add user with root access
      "adduser --disabled-password --gecos '' ${var.system_username}",
      "echo '${var.system_username}:${var.system_password}' | sudo chpasswd",
      "usermod -aG sudo ${var.system_username}",
      "rsync --archive --chown=${var.system_username}:${var.system_username} ~/.ssh /home/${var.system_username}",

      #wait until apt is availbale
      "sleep 10",

      #update system
      "sudo apt update -q",
      "sudo ucf --purge /boot/grub/menu.lst",
      "sudo DEBIAN_FRONTEND=noninteractive UCF_FORCE_CONFFNEW=YES apt-get upgrade -yq",

      #install docker
      "sudo DEBIAN_FRONTEND=noninteractive apt install -yq apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository  -y 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'",
      "sudo apt update -q",
      "sudo apt-get install -yq docker-ce docker-ce-cli containerd.io",
      "docker login --username ${var.docker_username} --password ${var.docker_password}",
      "sudo systemctl enable docker",

      #allow user to use docker without root
      "sudo groupadd docker",
      "sudo usermod -aG docker ${var.system_username}",
    ]
  }
}
