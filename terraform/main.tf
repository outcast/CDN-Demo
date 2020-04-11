
resource "digitalocean_volume" "mirror_storage" {
  region                  = var.origin_zone
  name                    = "mirror-storage"
  size                    = 500
  initial_filesystem_type = "ext4"
  description             = "volume used for storing apt mirror"
}

# Create a new mirror_origin server in the defined origin_zone region
resource "digitalocean_droplet" "mirror_origin" {
  image  = "ubuntu-18-04-x64"
  name   = "mirror-origin"
  region = var.origin_zone
  size   = "s-4vcpu-8gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_volume_attachment" "mirror_origin_volume" {
  droplet_id = digitalocean_droplet.mirror_origin.id
  volume_id  = digitalocean_volume.mirror_storage.id
}

#### Caching Nodes
resource "digitalocean_volume" "cache_storage" {
  for_each = var.cache_zones
  region                  = each.value
  name                    = "cache-storage"
  size                    = 500
  initial_filesystem_type = "ext4"
  initial_filesystem_label= "cache-storage"
  description             = "volume used for storing apt mirror"
}

# Create caching servers in the defined cache_zones
resource "digitalocean_droplet" "lb_nodes" {
  for_each = var.cache_zones
  image  = "ubuntu-18-04-x64"
  name   = "lb-${each.value}"
  region = each.value
  private_networking = true
  size   = "s-2vcpu-4gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "nyc1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-ny1-${count.value}"
  region = "nyc1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "nyc1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-ny1-${count.value}"
  region = "nyc1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "nyc1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-ny1-${count.value}"
  region = "nyc1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "nyc1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-ny1-${count.value}"
  region = "nyc1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "nyc1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-ny1-${count.value}"
  region = "nyc1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

#resource "digitalocean_droplet" "cache_nodes" {
#  count = var.cache_node_count
#  for zone in var.cache_zones:
#  image  = "ubuntu-18-04-x64"
#  name   = "cache-${count.value}"
#  region = each.value
#  private_networking = true
#  size   = "s-1vcpu-2gb"
#  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
#    key.id
#  ]
#}

#resource "digitalocean_volume_attachment" "cache_volume" {
#  for_each = var.cache_zones
#  droplet_id = digitalocean_droplet.cache_nodes["${each.value}"].id
#  volume_id  = digitalocean_volume.cache_storage["${each.value}"].id
#}
