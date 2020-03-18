data "digitalocean_ssh_key" "mysshkey" {
  name = "bigrig"
}

data "template_file" "mirror_origin_host" {
  template = "${file("../templates/ansible-mirror-origin.conf")}"
  depends_on = [
    digitalocean_droplet.mirror-origin
  ]
  vars = {
    public_ip = "${digitalocean_droplet.mirror-origin.ipv4_address}"
  }
}
