#########################################################
# EKS CLUSTER
#########################################################

resource "aws_eks_cluster" "this" {

  name     = var.cluster_name

  role_arn = var.cluster_role_arn

  version  = var.cluster_version

  access_config {

    authentication_mode = "API_AND_CONFIG_MAP"

    bootstrap_cluster_creator_admin_permissions = true

  }

  vpc_config {

    subnet_ids = var.private_subnet_ids

    security_group_ids = [

      var.eks_cluster_security_group

    ]

    endpoint_public_access  = true

    endpoint_private_access = true

  }

  enabled_cluster_log_types = [

    "api",

    "audit",

    "authenticator",

    "controllerManager",

    "scheduler"

  ]

  tags = merge(

    var.common_tags,

    {

      Name = var.cluster_name

    }

  )

}