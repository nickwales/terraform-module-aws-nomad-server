resource "aws_autoscaling_group" "nomad_server" {
  name                      = "nomad-server-${var.name}-${var.datacenter}-${local.voter}"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.nomad_server_count
  launch_template {
    id = aws_launch_template.nomad_server.id
  }
  target_group_arns   = var.target_groups
  vpc_zone_identifier = var.private_subnets

  tag {
    key                 = "Name"
    value               = "nomad-server-${var.name}-${var.datacenter}"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "nomad_server" {
  instance_type = "t3.small"
  image_id      = data.aws_ami.ubuntu.id

  iam_instance_profile {
    name = aws_iam_instance_profile.nomad_server.name
  }
  name = "nomad-server-${var.name}-${var.datacenter}-${local.voter}"
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nomad-server-${var.name}-${var.datacenter}-${local.voter}",
      role = "nomad-server-${var.name}-${var.datacenter}-${local.voter}",
    }
  }
  update_default_version = true

  user_data = base64encode(templatefile("${path.module}/templates/userdata.sh.tftpl", {
    name                    = var.name
    datacenter              = var.datacenter,
    nomad_version           = var.nomad_version,
    nomad_token             = var.nomad_token,
    nomad_encryption_key    = var.nomad_encryption_key,
    nomad_bootstrap_token   = var.nomad_bootstrap_token,
    nomad_license           = var.nomad_license,
    nomad_region            = var.nomad_region,
    nomad_datacenter        = var.nomad_datacenter,
    nomad_server_count      = var.nomad_server_count,
    nomad_key_file          = var.key_file,
    nomad_cert_file         = var.cert_file,
    nomad_binary            = var.nomad_binary,
    nomad_ca_file           = var.ca_file,
    nomad_non_voting_server = var.nomad_non_voting_server,
    consul_enabled          = var.consul_enabled,
    consul_ca_file          = var.consul_ca_file,
    consul_binary           = var.consul_binary,
    consul_version          = var.consul_version,
    consul_license          = var.consul_license,
    consul_token            = var.consul_token,
    consul_partition        = var.consul_partition,
    consul_agent_token      = var.consul_agent_token,
    consul_encryption_key   = var.consul_encryption_key,
  }))
  vpc_security_group_ids = [aws_security_group.nomad_server_sg.id]
}
