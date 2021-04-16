resource "aws_iam_role" "ec2_instance" {
  name               = "AWSDefaultEC2Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_instance" {
  role = aws_iam_role.ec2_instance.id
  name = aws_iam_role.ec2_instance.name
}

resource "aws_iam_role_policy_attachment" "ec2_instance_ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2_instance.id
}

resource "aws_iam_role_policy_attachment" "ec2_instance_cloudwatch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ec2_instance.id
}

resource "aws_iam_role_policy_attachment" "ec2_instance_ssm_decrypt" {
  policy_arn = data.terraform_remote_state.ssm.outputs.ssm_decrypt_policy_arn
  role       = aws_iam_role.ec2_instance.id
}
