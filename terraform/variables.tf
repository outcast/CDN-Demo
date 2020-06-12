variable "do_token" {}

variable "ssh_keys" {
  type = set(string)
  default = [
    "bigrig",
    "docker host"
  ]
}

variable "origin_zone" {
  type = string
  default = "nyc1"
}

variable "cache_zones" {
  type = set(string)
  default = [
    "nyc1",
    "nyc3",
    "lon1",
    "tor1"
  ]
}

variable "cache_node_count" {
  type = number
  default = 3
}

variable "cache_disk_size" {
  type = number
  default = 2
}
