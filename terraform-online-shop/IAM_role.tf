resource "aws_iam_policy" "ECR_push_policy" {
  name        = "ECR_push_policy"
  description = "Policy that allows pushing images to ECR"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:CompleteLayerUpload",
                "ecr:GetAuthorizationToken",
                "ecr:UploadLayerPart",
                "ecr:InitiateLayerUpload",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage"
            ],
            "Resource": "*"
        }
    ]
})
}


resource "aws_iam_role" "ECR_push_role" {
  name               = "ECR_push_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ECR_push_attach" {
  role       = aws_iam_role.ECR_push_role.name
  policy_arn = aws_iam_policy.ECR_push_policy.arn
}
