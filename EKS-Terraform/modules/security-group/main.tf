###########################################################
# EKS CONTROL PLANE SECURITY GROUP
###########################################################

resource "aws_security_group" "eks_cluster" {

  name        = "eks-cluster-sg"
  description = "Security Group for EKS Control Plane"
  vpc_id      = var.vpc_id

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(
    var.common_tags,
    {
      Name = "eks-cluster-sg"
    }
  )

}

###########################################################
# EKS NODE GROUP SECURITY GROUP
###########################################################

resource "aws_security_group" "worker_nodes" {

  name        = "eks-worker-sg"
  description = "Worker Node Security Group"
  vpc_id      = var.vpc_id

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(
    var.common_tags,
    {
      Name = "eks-worker-sg"
    }
  )

}

###########################################################
# BASTION/JENKINS SECURITY GROUP
###########################################################

resource "aws_security_group" "bastion" {

  name        = "jenkins-bastion-sg"
  description = "Security Group for Jenkins EC2"
  vpc_id      = var.vpc_id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    description = "Jenkins"

    from_port = 8080
    to_port   = 8080

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(
    var.common_tags,
    {
      Name = "jenkins-bastion-sg"
    }
  )

}

###########################################################
# MYSQL / RDS SECURITY GROUP
###########################################################

resource "aws_security_group" "rds" {

  name        = "mysql-rds-sg"
  description = "Security Group for MySQL RDS"
  vpc_id      = var.vpc_id

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(
    var.common_tags,
    {
      Name = "mysql-rds-sg"
    }
  )

}

###########################################################
# EKS CLUSTER <-> WORKER NODES
###########################################################

resource "aws_security_group_rule" "cluster_from_worker" {

  type = "ingress"

  from_port = 443
  to_port   = 443

  protocol = "tcp"

  security_group_id = aws_security_group.eks_cluster.id

  source_security_group_id = aws_security_group.worker_nodes.id

}

resource "aws_security_group_rule" "worker_from_cluster" {

  type = "ingress"

  from_port = 1025
  to_port   = 65535

  protocol = "tcp"

  security_group_id = aws_security_group.worker_nodes.id

  source_security_group_id = aws_security_group.eks_cluster.id

}

###########################################################
# NODE TO NODE COMMUNICATION
###########################################################

resource "aws_security_group_rule" "worker_internal" {

  type = "ingress"

  from_port = 0
  to_port   = 65535

  protocol = "-1"

  security_group_id = aws_security_group.worker_nodes.id

  source_security_group_id = aws_security_group.worker_nodes.id

}

###########################################################
# BASTION TO EKS
###########################################################

resource "aws_security_group_rule" "bastion_to_worker" {

  type = "ingress"

  from_port = 22
  to_port   = 22

  protocol = "tcp"

  security_group_id = aws_security_group.worker_nodes.id

  source_security_group_id = aws_security_group.bastion.id

}

resource "aws_security_group_rule" "bastion_to_cluster" {

  type = "ingress"

  from_port = 443

  to_port   = 443

  protocol = "tcp"

  security_group_id = aws_security_group.eks_cluster.id

  source_security_group_id = aws_security_group.bastion.id

}

###########################################################
# BASTION TO MYSQL
###########################################################

resource "aws_security_group_rule" "mysql_from_bastion" {

  type = "ingress"

  from_port = 3306
  to_port   = 3306

  protocol = "tcp"

  security_group_id = aws_security_group.rds.id

  source_security_group_id = aws_security_group.bastion.id

}

###########################################################
# EKS PODS TO MYSQL
###########################################################

resource "aws_security_group_rule" "mysql_from_worker" {

  type = "ingress"

  from_port = 3306
  to_port   = 3306

  protocol = "tcp"

  security_group_id = aws_security_group.rds.id

  source_security_group_id = aws_security_group.worker_nodes.id

}