resource "null_resource" "mirror-origin" {
  triggers = {
    template_rendered = data.template_file.mirror_origin_host.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.mirror_origin_host.rendered}' > ../configs/ansible/mirror-origin.conf"
  }
}
