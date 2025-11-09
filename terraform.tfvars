# terraform.tfvars

aws_region = "us-east-2"

# Windows Server 2022 AMI (update with your AMI ID)
windows_ami_id = "ami-0b4e6a058b5dd6960"  # Replace with actual Windows AMI

# Instance configuration
instance_type = "t3.xlarge"  # Windows needs more resources
instance_name = "windows-ansible-server"

# Network configuration
subnet_id          = "subnet-0a610e439e897cad5"  # Your subnet
security_group_ids = ["sg-021edaede75001706"]    # Your security group

# Key pair
key_name = "SqlServerDB-key"

# GitHub repository (update with your repo)
github_repo_url = "https://github.com/chindoemile/OpentTofu_Clone.git"

# GitHub token for private repos (optional)
# github_token = "ghp_xxxxxxxxxxxx"
