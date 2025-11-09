# variables.tf

# ============================================
# AWS Configuration
# ============================================
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-2"
}

# ============================================
# EC2 Instance Configuration
# ============================================
variable "windows_ami_id" {
  description = "AMI ID for Windows Server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.xlarge"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "windows-ansible-server"
}

# ============================================
# Network Configuration
# ============================================
variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

# ============================================
# Key Pair Configuration
# ============================================
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

# ============================================
# Storage Configuration
# ============================================
variable "root_volume_size" {
  description = "Size of root volume in GB"
  type        = number
  default     = 80
}

variable "root_volume_type" {
  description = "Type of root volume"
  type        = string
  default     = "gp3"
}

# ============================================
# GitHub Repository Configuration
# ============================================
variable "github_repo_url" {
  description = "GitHub repository URL"
  type        = string
  default     = "https://github.com/your-org/dba.ansible.git"
}

variable "github_token" {
  description = "GitHub token for private repos (optional)"
  type        = string
  default     = ""
  sensitive   = true
}
