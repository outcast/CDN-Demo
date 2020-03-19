variable "do_token" {}

variable "ssh_keys" {
  type = set(string)
  default = [
    "bigrig"
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
