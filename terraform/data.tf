data "digitalocean_ssh_key" "ssh_keys" {
  for_each = var.ssh_keys
  name = each.value
}


data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "template_file" "ansible_nodes_conf" {
  template = "${file("../templates/ansible_nodes.conf")}"
  depends_on = [
    digitalocean_droplet.mirror_origin,
    digitalocean_droplet.cache_nodes
  ]
  vars = {
    origin_public_ip = "${digitalocean_droplet.mirror_origin.ipv4_address}"
    cache_nodes  = "${jsonencode(digitalocean_droplet.cache_nodes)}"
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

data "template_file" "nginx_cache_conf" {
  template = "${file("../templates/nginx_cache.conf")}"
  depends_on = [
    digitalocean_droplet.mirror_origin,
    data.http.myip
  ]
  vars = {
    my_ip = "${chomp(data.http.myip.body)}",
    origin_public_ip = "${digitalocean_droplet.mirror_origin.ipv4_address}"
  }
}
