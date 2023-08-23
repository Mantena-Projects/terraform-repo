# variables for provider configuration - assign access key and secret key at runtime
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {} 

variable "AWS_REGION" {

  default = "us-east-1"

}

#...............................................................

#varibles for to assign CIDR for vpc & subnets (private & public)
variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "PUBLIC_SUBNET_1_CIDR" {
  default = "10.0.1.0/24"
}

variable "PUBLIC_SUBNET_2_CIDR" {
  default = "10.0.2.0/24"
}

variable "PRIVATE_SUBNET_1_CIDR" {
  default = "10.0.3.0/24"
}

variable "PRIVATE_SUBNET_2_CIDR" {
  default = "10.0.4.0/24"

}

#.................................................................

#create variables for route 53
variable "domain_name" {
  default     = "padmamantena.co.uk"
  description = "domain name"
  type        = string
}

variable "record_name" {
  default     = "www"
  description = "sub domain name"
  type        = string
}