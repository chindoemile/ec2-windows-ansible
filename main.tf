# main.tf

# ============================================
# Local Variables
# ============================================
locals {
  # Add GitHub token to URL if provided
  github_url = var.github_token != "" ? replace(var.github_repo_url, "https://", "https://${var.github_token}@") : var.github_repo_url
}

# ============================================
# EC2 Instance
# ============================================
resource "aws_instance" "windows_ansible" {
  ami                    = var.windows_ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  # UserData script
  user_data = templatefile("${path.module}/windows-userdata.ps1", {
    github_repo_url = local.github_url
  })

  # Root volume configuration
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    encrypted             = false
  }

  # Tags
  tags = {
    Name      = var.instance_name
    OS        = "Windows"
    Purpose   = "Ansible Server"
    ManagedBy = "OpenTofu"
  }

  # IMDSv2
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
}
