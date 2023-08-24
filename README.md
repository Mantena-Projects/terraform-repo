# terraform-repo
CREATED TERRAFORM CONFIGURATION FOR:

1) VPC
2) 4 SUBNETS (2-PRIVATE & 2-PUBLIC)
3) INTERNET GATEWAY (IGW)for vpc and public subnets
4) NAT GATEWAY in the public subnet 1, for private subnets
5) ROUTE TABLES & ASSOCIATION
6) SECURITY GROUPS for elb,ec2,rds
7) RDS in private subnet 1 & replica for private subnet 2
8) ELB (APPLICATION LB) in the public subnet 1&2
9) AUTOSCALING 
10) ROUTE 53 
11) EBS EXTRA VOLUME AND ATTACHED TO ebs-ec2-instance
12) IAM USERS, GROUP, AND POLICY
13) DATA SOURCE, USER DATA
