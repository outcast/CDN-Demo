
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
resource "digitalocean_volume" "nyc1_cache_storage" {
  count = var.cache_node_count
  region                  = "nyc1"
  name                    = "nyc1-cache-storage-${count.index}"
  size                    = 500
  initial_filesystem_type = "ext4"
  initial_filesystem_label= "cache-storage"
  description             = "volume used for storing apt mirror"
}

resource "digitalocean_volume" "nyc3_cache_storage" {
  count = var.cache_node_count
  region                  = "nyc3"
  name                    = "nyc3-cache-storage-${count.index}"
  size                    = 500
  initial_filesystem_type = "ext4"
  initial_filesystem_label= "cache-storage"
  description             = "volume used for storing apt mirror"
}

resource "digitalocean_volume" "lon1_cache_storage" {
  count = var.cache_node_count
  region                  = "lon1"
  name                    = "lon1-cache-storage-${count.index}"
  size                    = 500
  initial_filesystem_type = "ext4"
  initial_filesystem_label= "cache-storage"
  description             = "volume used for storing apt mirror"
}

resource "digitalocean_volume" "tor1_cache_storage" {
  count = var.cache_node_count
  region                  = "tor1"
  name                    = "tor1-cache-storage-${count.index}"
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
  name   = "cache-nyc1-${count.index}"
  region = "nyc1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "nyc3_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-nyc3-${count.index}"
  region = "nyc3"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "lon1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-lon1-${count.index}"
  region = "lon1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_droplet" "tor1_cache_nodes" {
  count = var.cache_node_count
  image  = "ubuntu-18-04-x64"
  name   = "cache-tor1-${count.index}"
  region = "tor1"
  private_networking = true
  size   = "s-1vcpu-2gb"
  ssh_keys = [for key in data.digitalocean_ssh_key.ssh_keys:
    key.id
  ]
}

resource "digitalocean_volume_attachment" "nyc1_cache_volume" {
  count = var.cache_node_count
  droplet_id = digitalocean_droplet.nyc1_cache_nodes[count.index].id
  volume_id  = digitalocean_volume.nyc1_cache_storage[count.index].id
}

resource "digitalocean_volume_attachment" "nyc3_cache_volume" {
  count = var.cache_node_count
  droplet_id = digitalocean_droplet.nyc3_cache_nodes[count.index].id
  volume_id  = digitalocean_volume.nyc3_cache_storage[count.index].id
}

resource "digitalocean_volume_attachment" "lon1_cache_volume" {
  count = var.cache_node_count
  droplet_id = digitalocean_droplet.lon1_cache_nodes[count.index].id
  volume_id  = digitalocean_volume.lon1_cache_storage[count.index].id
}

resource "digitalocean_volume_attachment" "tor1_cache_volume" {
  count = var.cache_node_count
  droplet_id = digitalocean_droplet.tor1_cache_nodes[count.index].id
  volume_id  = digitalocean_volume.tor1_cache_storage[count.index].id
}
