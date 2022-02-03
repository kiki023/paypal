 
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "demo-node" {
  name = "terraform-eks-demo-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

data "aws_iam_policy_document" "worker_autoscaling" {
  statement {
    sid    = "eksWorkerAutoscalingAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "eksWorkerAutoscalingOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.demo.id}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "workers_autoscaling" {
  policy_arn = aws_iam_policy.worker_autoscaling.arn
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_policy" "worker_autoscaling" {
  name_prefix = "eks-worker-autoscaling-${aws_eks_cluster.demo.id}"
  description = "EKS worker node autoscaling policy for cluster ${aws_eks_cluster.demo.id}"
  policy      = data.aws_iam_policy_document.worker_autoscaling.json
}



resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.demo-node.name
}

resource "aws_eks_node_group" "demo" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "demo"
  node_role_arn   = aws_iam_role.demo-node.arn
  subnet_ids      = aws_subnet.demo[*].id
  instance_types = [var.eks_node_instance_type]
  remote_access{
      ec2_ssh_key = 2022
  }


  scaling_config {
    desired_size = 2
    max_size     = 200
    min_size     = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.workers_autoscaling,
    aws_iam_role_policy_attachment.demo-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demo-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demo-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
//resource "aws_key_pair" "deployer" {
  //key_name   = "work"
  //public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC75EQOHWoSpOuiWYureIl4kUz6qd7/jNLkfMkMn6Y9k6sOi4LOKHHXuoJBWcHXcUqiEmEd3Py3ZwQe/obXe7S0u43QYwZl08/y47KsFflljgYNZ3plNKVdPL9aJtplF4Ayw/vVfSbU6vJDxVA0qdbAjcaaPH3Gy+envUffXc+Lm+6eTkbPJq5e2N875vaM4cXKJWYnosbm7X+GM1S7whLSmGctmIXJg0OhIH+xhM2yVKTlqdfgkglewhUQdwXm5w3O807iNzG3oO6WpX/2tSax71QL58gK7XhDN/KEJqMLwpCcURx44ZnpVKtrxqiUYf2ycQcJNT+etRDrYHdRwEqF 2022 "
//}
