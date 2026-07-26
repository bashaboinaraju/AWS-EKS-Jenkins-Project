The next module is the VPC module, which is the largest foundational component. It will contain approximately:

variables.tf
versions.tf
main.tf
outputs.tf

Inside main.tf, we'll include:

VPC
Internet Gateway
2 Public Subnets
2 Private Subnets
Elastic IP
NAT Gateway
Public Route Table
Private Route Table
All Route Table Associations

This module will replace the VPC-related resources currently embedded in your monolithic main.tf and expose clean outputs (VPC ID, subnet IDs, route tables) for the EKS, RDS, and Bastion modules to consume. This is the same modular pattern used in enterprise Terraform codebases.

-----------------------------------------------------------------

Improvements over the original design

Compared to your original allow_all security group:

✅ Separate security groups for EKS, worker nodes, Jenkins, and RDS.
✅ Security group references instead of exposing databases to the internet.
✅ Worker nodes can communicate with each other.
✅ Only Jenkins can SSH to worker nodes (if SSH access is enabled).
✅ Only Jenkins and EKS worker nodes can reach MySQL on port 3306.
✅ Easier to audit, troubleshoot, and extend as the environment grows.

-----------------------

How Other Modules Will Use These Outputs
EKS Cluster Module
role_arn = module.iam.cluster_role_arn
Node Group Module
node_role_arn = module.iam.worker_role_arn
EBS CSI Pod Identity
role_arn = module.iam.ebs_role_arn
EKS Cluster Dependency
depends_on = [
  module.iam
]

or, if you want an explicit dependency on the policy attachment:

depends_on = [
  module.iam.cluster_policy_dependency
]
Industry Best Practice Improvements

Compared to your original IAM configuration, this version:

✅ Groups all IAM resources into a reusable module.
✅ Applies consistent tags to IAM roles.
✅ Exposes only the required outputs (ARNs and dependencies).
✅ Keeps IAM logic separate from networking and compute resources.
✅ Makes it easier to reuse the same IAM module across environments (dev, QA, prod) without duplicating code.
One Additional Recommendation

For an enterprise environment, I would make one further enhancement: avoid hardcoding IAM role names such as eks-cluster-role and eks-worker-role. Instead, derive them from variables, for example:

name = "${var.project_name}-${var.environment}-eks-cluster-role"

This lets you deploy multiple environments (such as dev, qa, and prod) in the same AWS account without IAM role name conflicts.

The next module will be the EKS Cluster module, where we'll create the cluster itself and connect it to the VPC, IAM roles, and security groups we've already modularized.

------------------------------------------------
How Everything Connects
          IAM Module
               │
               │
               ▼
      Cluster IAM Role
               │
               │
               ▼
          EKS Module
               ▲
               │
        Security Group
               ▲
               │
          VPC Module
Improvements Over Your Original Code

Your original configuration:

resource "aws_eks_cluster" "eks" {

  role_arn = aws_iam_role.cluster_role.arn

  subnet_ids = [

      aws_subnet.private1.id,

      aws_subnet.private2.id

  ]

}

Problems:

Hardcoded references to resources.
Not reusable.
No CloudWatch control plane logging.
No module outputs.
Mixed with networking and IAM code.

The modular version provides:

✅ Reusable EKS module.
✅ Inputs come from VPC, IAM, and Security Group modules.
✅ Control plane logs enabled.
✅ Public and private API endpoints.
✅ Outputs for use by the Node Group and Add-ons modules.
✅ Easier to reuse across development, QA, and production environments.
One Recommendation

Your original code uses:

endpoint_public_access = true

For learning and small projects, this is fine.

For production, many organizations use:

endpoint_public_access  = false
endpoint_private_access = true

and manage the cluster from a VPN, Direct Connect, or a bastion host. This reduces exposure of the Kubernetes API to the internet while still allowing secure administrative access.