output "mirror_origin_id" {
  value = digitalocean_droplet.mirror_origin.id
}

output "mirror_origin_ipv4" {
  value = digitalocean_droplet.mirror_origin.ipv4_address
}

output "mirror_origin_ipv4_private" {
  value = digitalocean_droplet.mirror_origin.ipv4_address_private
}

output "nyc1_cache_nodes_ipv4" {
  value = {
    for node in digitalocean_droplet.nyc1_cache_nodes:
    node.id => node.ipv4_address
  }
}

output "nyc3_cache_nodes_ipv4" {
  value = {
    for node in digitalocean_droplet.nyc3_cache_nodes:
    node.id => node.ipv4_address
  }
}

output "lon1_cache_nodes_ipv4" {
  value = {
    for node in digitalocean_droplet.lon1_cache_nodes:
    node.id => node.ipv4_address
  }
}

output "tor1_cache_nodes_ipv4" {
  value = {
    for node in digitalocean_droplet.tor1_cache_nodes:
    node.id => node.ipv4_address
  }
}

output "consul_nodes_ipv4" {
  value = {
    for node in digitalocean_droplet.consul_nodes:
    node.region => node.ipv4_address
  }
}
