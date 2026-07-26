###########################################################
# POD IDENTITY ASSOCIATION
###########################################################

resource "aws_eks_pod_identity_association" "ebs_csi" {

  cluster_name = var.cluster_name

  namespace = "kube-system"

  service_account = "ebs-csi-controller-sa"

  role_arn = var.ebs_role_arn

}

###########################################################
# VPC CNI
###########################################################

resource "aws_eks_addon" "vpc_cni" {

  cluster_name = var.cluster_name

  addon_name = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.common_tags

}

###########################################################
# COREDNS
###########################################################

resource "aws_eks_addon" "coredns" {

  cluster_name = var.cluster_name

  addon_name = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.common_tags

}

###########################################################
# KUBE PROXY
###########################################################

resource "aws_eks_addon" "kube_proxy" {

  cluster_name = var.cluster_name

  addon_name = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.common_tags

}

###########################################################
# EBS CSI DRIVER
###########################################################

resource "aws_eks_addon" "ebs_csi" {

  cluster_name = var.cluster_name

  addon_name = "aws-ebs-csi-driver"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  service_account_role_arn = var.ebs_role_arn

  depends_on = [

    aws_eks_pod_identity_association.ebs_csi

  ]

  tags = var.common_tags

}