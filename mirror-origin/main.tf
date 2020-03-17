resource "digitalocean_volume" "mirror-storage" {
  region                  = "nyc1"
  name                    = "mirror-storage"
  size                    = 500
  initial_filesystem_type = "ext4"
  description             = "volume used for storing apt mirror"
}

# Create a new mirror-origin server in the nyc1 region
resource "digitalocean_droplet" "mirror-origin" {
  image  = "ubuntu-18-04-x64"
  name   = "mirror-origin"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.mysshkey.id]
}

resource "digitalocean_volume_attachment" "mirror-origin-volume" {
  droplet_id = digitalocean_droplet.mirror-origin.id
  volume_id  = digitalocean_volume.mirror-storage.id
}
