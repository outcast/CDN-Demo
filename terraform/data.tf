data "digitalocean_ssh_key" "mysshkey" {
  name = "bigrig"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "template_file" "ansible_nodes_conf" {
  template = "${file("../templates/ansible_nodes.conf")}"
  depends_on = [
    digitalocean_droplet.mirror-origin
  ]
  vars = {
    origin_public_ip = "${digitalocean_droplet.mirror-origin.ipv4_address}"
  }
}

data "template_file" "nginx_default_conf" {
  template = "${file("../templates/nginx_default.conf")}"
  depends_on = [
    data.http.myip
  ]
  vars = {
    my_ip = "${chomp(data.http.myip.body)}"
  }
}

data "template_file" "nginx_origin_conf" {
  template = "${file("../templates/nginx_origin.conf")}"
  depends_on = [
    data.http.myip
  ]
  vars = {
    my_ip = "${chomp(data.http.myip.body)}"
  }
}
