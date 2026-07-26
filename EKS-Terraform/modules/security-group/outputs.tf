output "eks_cluster_sg" {

  value = aws_security_group.eks_cluster.id

}

output "worker_node_sg" {

  value = aws_security_group.worker_nodes.id

}

output "bastion_sg" {

  value = aws_security_group.bastion.id

}

output "rds_sg" {

  value = aws_security_group.rds.id

}