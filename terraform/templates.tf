resource "null_resource" "ansible_nodes_conf" {
  triggers = {
    template_rendered = data.template_file.ansible_nodes_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_nodes_conf.rendered}' > ../configs/ansible/nodes.conf"
  }
}

resource "null_resource" "nginx_origin_conf" {
  triggers = {
    template_rendered = data.template_file.nginx_origin_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.nginx_origin_conf.rendered}' > ../configs/nginx/origin.conf"
  }
}

resource "null_resource" "nginx_cache_conf" {
  triggers = {
    template_rendered = data.template_file.nginx_cache_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.nginx_cache_conf.rendered}' > ../configs/nginx/cache.conf"
  }
}

resource "null_resource" "nginx_nyc1_lb_conf" {
  triggers = {
    template_rendered = data.template_file.nginx_nyc1_lb_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.nginx_nyc1_lb_conf.rendered}' > ../configs/nginx/nyc1_lb.conf"
  }
}

resource "null_resource" "nginx_nyc3_lb_conf" {
  triggers = {
    template_rendered = data.template_file.nginx_nyc3_lb_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.nginx_nyc3_lb_conf.rendered}' > ../configs/nginx/nyc3_lb.conf"
  }
}

resource "null_resource" "nginx_lon1_lb_conf" {
  triggers = {
    template_rendered = data.template_file.nginx_lon1_lb_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.nginx_lon1_lb_conf.rendered}' > ../configs/nginx/lon1_lb.conf"
  }
}

resource "null_resource" "nginx_tor1_lb_conf" {
  triggers = {
    template_rendered = data.template_file.nginx_tor1_lb_conf.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.nginx_tor1_lb_conf.rendered}' > ../configs/nginx/tor1_lb.conf"
  }
}
