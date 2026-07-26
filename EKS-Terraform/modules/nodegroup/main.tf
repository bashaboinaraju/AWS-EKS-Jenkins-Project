####################################################
# LAUNCH TEMPLATE
####################################################

resource "aws_launch_template" "eks_nodes" {

  name_prefix = "eks-node-"

  update_default_version = true

  vpc_security_group_ids = [
    var.worker_security_group_id
  ]

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.disk_size

      volume_type = "gp3"

      encrypted = true

      delete_on_termination = true

    }

  }

  # Use the default EKS-optimized AMI unless an explicit override is provided.
  image_id = var.ami_id != "" ? var.ami_id : null

  monitoring {

    enabled = true

  }

  metadata_options {

    http_endpoint = "enabled"

    http_tokens   = "required"

  }

  key_name = var.ssh_key_name != "" ? var.ssh_key_name : null

  tags = merge(
    var.common_tags,
    {
      Name = "eks-launch-template"
    }
  )
}

####################################################
# NODE GROUP
####################################################

resource "aws_eks_node_group" "this" {

  cluster_name = var.cluster_name

  node_group_name = "managed-node-group"

  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  capacity_type = "ON_DEMAND"

  instance_types = [
    var.instance_type
  ]

  scaling_config {

    desired_size = var.desired_size

    min_size = var.min_size

    max_size = var.max_size

  }

  launch_template {

    id = aws_launch_template.eks_nodes.id

    version = "$Latest"

  }

  update_config {

    max_unavailable = 1

  }

  labels = {

    environment = "dev"

    workload = "application"

  }

  tags = merge(
    var.common_tags,
    {
      Name = "managed-node-group"
    }
  )

}