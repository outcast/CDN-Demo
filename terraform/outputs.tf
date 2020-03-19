output "mirror_origin_id" {
  value = digitalocean_droplet.mirror_origin.id
}

output "mirror_origin_ipv4" {
  value = digitalocean_droplet.mirror_origin.ipv4_address
}

output "mirror_origin_ipv4_private" {
  value = digitalocean_droplet.mirror_origin.ipv4_address_private
}

output "cache_nodes_ipv4" {
  value = {
    for node in digitalocean_droplet.cache_nodes:
    node.region => node.ipv4_address
  }
}
