############################################################
# EKS CLUSTER ROLE
############################################################

resource "aws_iam_role" "cluster_role" {

  name = "eks-cluster-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "eks.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = merge(
    var.common_tags,
    {
      Name = "eks-cluster-role"
    }
  )

}

############################################################
# EKS CLUSTER POLICY
############################################################

resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role       = aws_iam_role.cluster_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}

############################################################
# WORKER NODE ROLE
############################################################

resource "aws_iam_role" "worker_role" {

  name = "eks-worker-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = merge(
    var.common_tags,
    {
      Name = "eks-worker-role"
    }
  )

}

############################################################
# WORKER NODE POLICIES
############################################################

resource "aws_iam_role_policy_attachment" "worker_node" {

  role       = aws_iam_role.worker_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}

resource "aws_iam_role_policy_attachment" "worker_cni" {

  role       = aws_iam_role.worker_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}

resource "aws_iam_role_policy_attachment" "worker_ecr" {

  role       = aws_iam_role.worker_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

############################################################
# EBS CSI DRIVER ROLE
############################################################

resource "aws_iam_role" "ebs_csi_role" {

  name = "AmazonEKS_EBS_CSI_DriverRole"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "pods.eks.amazonaws.com"

        }

        Action = [

          "sts:AssumeRole",

          "sts:TagSession"

        ]

      }

    ]

  })

  tags = merge(
    var.common_tags,
    {
      Name = "ebs-csi-role"
    }
  )

}

############################################################
# EBS POLICY
############################################################

resource "aws_iam_role_policy_attachment" "ebs_policy" {

  role       = aws_iam_role.ebs_csi_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

}