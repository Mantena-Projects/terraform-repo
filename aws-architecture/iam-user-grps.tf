#TF File for IAM Users and Groups
resource "aws_iam_user" "cloudfront-user1" {

  name = "cloudfront-user-1"

}
resource "aws_iam_user" "cloudfront-user2" {

  name = "cloudfront-user-2"

}

#..........................................................

#Group TF definition
resource "aws_iam_group" "cloudfront-group" {

  name = "cloudfront-group"
}

#Assign User to AWS Group
resource "aws_iam_group_membership" "cloudfront-users" {

  name = "cloudfront-users"
  users = [
    aws_iam_user.cloudfront-user1.name,
    aws_iam_user.cloudfront-user2.name,
  ]
  group = aws_iam_group.cloudfront-group.name

}

#...................................................................

#policy for AWS group
resource "aws_iam_policy_attachment" "cloudfront-users-attach" {

  name       = "cloudfront-users-attach"
  groups     = [aws_iam_group.cloudfront-group.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"

}