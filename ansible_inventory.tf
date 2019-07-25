resource "local_file" "ansible_inventory" {
  content = "[${var.droplet_name}]\n${join("\n",
            formatlist(
              "%s ansible_user=%s ansible_become_user=root ansible_sudo_password=%s ansible_ssh_private_key_file=%s ansible_python_interpreter=/usr/bin/python3",
              digitalocean_droplet.mainserver.ipv4_address,
              var.system_username,
              var.system_password,
              var.ssh_private_key,
              )
        )}"
        filename = "ansible/ansible_inventory"
}