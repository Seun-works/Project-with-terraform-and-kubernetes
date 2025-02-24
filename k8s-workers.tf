# Create node group for the EKS cluster

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node_group"
  node_role_arn   = aws_iam_role.eks_role.arn
  subnet_ids      = [for subnet in aws_subnet.kubernetes_subnets : subnet.id if subnet.tags["Name"] == "kubernetes-project-subnet-private"]
  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }
  instance_types = ["t3.medium"]
}