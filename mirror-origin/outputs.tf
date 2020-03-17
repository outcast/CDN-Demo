output "mirror_origin_id" {
  value = digitalocean_droplet.mirror-origin.id
}

output "mirror_origin_ipv4" {
  value = digitalocean_droplet.mirror-origin.ipv4_address
}

output "mirror_origin_ipv4_private" {
  value = digitalocean_droplet.mirror-origin.ipv4_address_private
}
