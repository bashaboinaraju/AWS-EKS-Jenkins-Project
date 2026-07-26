output "vpc_cni" {

  value = aws_eks_addon.vpc_cni.id

}

output "coredns" {

  value = aws_eks_addon.coredns.id

}

output "kube_proxy" {

  value = aws_eks_addon.kube_proxy.id

}

output "ebs_csi_driver" {

  value = aws_eks_addon.ebs_csi.id

}