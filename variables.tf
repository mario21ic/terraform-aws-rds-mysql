variable "region" {
  description = "Regions aws"
}

variable "env" {
  description = "environment name"
}

variable "allocated_storage" {
  description = "Storage size in GB"
}

variable "engine" {
  description = "Engine type, example values mysql, postgres"
}

variable "engine_version" {
  description = "Engine version"
}

variable "family" {
  default = "postgres96"
  description = "family name"
}

variable "name" {
  description = "Name"
}

variable "backup_name" {
  default = ""
  description = "Backup name"
}

variable "instance_class" {
  description = "Instance class"
}


variable "username" {
  description = "usr for dev db"
}

variable "password" {
  description = "password, provide through your ENV variables"
}

variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "sg_name" {
  default     = "rds_sg"
  description = "Tag Name for sg"
}


variable "publicly_accessible" {
  default = false
  description = "access to public"
}

# Variable externals
variable "vpc_id" {
  description = "vpc id"
}

variable "subnet_ids" {
  type = "list"
  default = []
  description = "Subnet id"
}

variable "security_group_ids" {
  type = "list"
  default = []
  description = "security group ids"
}

