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
    digitalocean_droplet.nyc1_cache_nodes,
    digitalocean_droplet.nyc3_cache_nodes,
    digitalocean_droplet.lon1_cache_nodes,
    digitalocean_droplet.tor1_cache_nodes,
    digitalocean_droplet.lb_nodes,
    digitalocean_droplet.consul_nodes
  ]
  vars = {
    origin_public_ip = "${digitalocean_droplet.mirror_origin.ipv4_address}"
    lb_nodes = "${jsonencode(digitalocean_droplet.lb_nodes)}"
    consul_nodes = "${jsonencode(digitalocean_droplet.consul_nodes)}"
    nyc1_cache_nodes  = "${jsonencode(digitalocean_droplet.nyc1_cache_nodes)}"
    nyc3_cache_nodes  = "${jsonencode(digitalocean_droplet.nyc3_cache_nodes)}"
    lon1_cache_nodes  = "${jsonencode(digitalocean_droplet.lon1_cache_nodes)}"
    tor1_cache_nodes  = "${jsonencode(digitalocean_droplet.tor1_cache_nodes)}"
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

#data "template_file" "nginx_nyc1_lb_conf" {
#  template = "${file("../templates/nginx_lb.conf")}"
#  depends_on = [
#    digitalocean_droplet.nyc1_cache_nodes
#  ]
#  vars = {
#    cache_nodes  = "${jsonencode(digitalocean_droplet.nyc1_cache_nodes)}"
#  }
#}

#data "template_file" "nginx_nyc3_lb_conf" {
#  template = "${file("../templates/nginx_lb.conf")}"
#  depends_on = [
#    digitalocean_droplet.nyc3_cache_nodes
#  ]
#  vars = {
#    cache_nodes  = "${jsonencode(digitalocean_droplet.nyc3_cache_nodes)}"
#  }
#}

#data "template_file" "nginx_lon1_lb_conf" {
#  template = "${file("../templates/nginx_lb.conf")}"
#  depends_on = [
#    digitalocean_droplet.lon1_cache_nodes
#  ]
#  vars = {
#    cache_nodes  = "${jsonencode(digitalocean_droplet.lon1_cache_nodes)}"
#  }
#}

#data "template_file" "nginx_tor1_lb_conf" {
#  template = "${file("../templates/nginx_lb.conf")}"
#  depends_on = [
#    digitalocean_droplet.tor1_cache_nodes
#  ]
#  vars = {
#    cache_nodes  = "${jsonencode(digitalocean_droplet.tor1_cache_nodes)}"
#  }
#}
