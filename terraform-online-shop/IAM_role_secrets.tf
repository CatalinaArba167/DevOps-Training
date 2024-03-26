resource "aws_iam_role" "secret_role" {
  name="secret_role"
  assume_role_policy = jsonencode(
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  )
  
}

resource "aws_iam_policy" "secret_policy" {
  name="secret_policy"
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:767397826387:secret:MyFirstSecret-1Npzvk"
      ]
    }
  ]
})
  
}

resource "aws_iam_role_policy_attachment" "secret_push_attach" {
  role       = aws_iam_role.secret_role.name
  policy_arn = aws_iam_policy.secret_policy.arn
}
