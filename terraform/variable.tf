variable "tags" {
  type        = list(string)
  description = "The tags for the different resources in order they were created."
  default     = ["webVPC", "webPubSunet1", "webPubSunet2", "webPubSunet3", "webServersRoute", "webServersGW", "webServerPubSG"]
}

variable "region" {
  type        = string
  description = "The AWS region to deploy to."
  default     = "eu-west-1"
}

variable "cidr_block" {
  type        = list(string)
  description = "The CIDR block for the VPC."
  default     = ["10.10.0.0/16", "10.10.0.0/24", "10.10.2.0/24", "10.10.4.0/24", "0.0.0.0/0"]
}

variable "instance_type" {
  type        = string
  description = "The instance type."
  default     = "t2.micro"
}

variable "availability_zones" {
  type        = list(string)
  description = "The first availability zone."
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "key_name" {
  type        = string
  description = "The key pair for secure connection."
  sensitive   = true
  default = "KeyPair"
}

