output "cluster_role_arn" {

  value = aws_iam_role.cluster_role.arn

}

output "worker_role_arn" {

  value = aws_iam_role.worker_role.arn

}

output "ebs_role_arn" {

  value = aws_iam_role.ebs_csi_role.arn

}

output "cluster_policy_dependency" {

  value = aws_iam_role_policy_attachment.cluster_policy.id

}

output "worker_policy_dependencies" {

  value = [

    aws_iam_role_policy_attachment.worker_node.id,

    aws_iam_role_policy_attachment.worker_cni.id,

    aws_iam_role_policy_attachment.worker_ecr.id

  ]

}

output "ebs_policy_dependency" {

  value = aws_iam_role_policy_attachment.ebs_policy.id

}