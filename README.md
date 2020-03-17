# CDN-Demo
---
Author: James Jones <jam.jones@nginx.com>

## Usage {#usage}

### Prerequisites {#prerequisites}
- terraform
- ansbile
- Nginx Plus repo access cert and key
- Digital Ocean Account with a ssh key imported

### Setup {#setup}
1. Clone repo
2. Copy your Nginx repo access cert and key to './certs'
3. In './mirror-origin/data.tf' add the key name to `data "digitalocean_ssh_key" "mysshkey"`.

  Example:

  ```
  data "digitalocean_ssh_key" "mysshkey" {
    name = "mysshkey"
  }
  ```
4. mkdir ~/.private
5. Create a file '~/.private/do_token' with mode '0600' and put your Digital Ocean token in it.

### To Deploy {#deploy}
  `./deploy.sh`

### To Destroy {#destroy}
  `./destroy.sh`
