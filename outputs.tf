# outputs.tf

output "instance_id" {
  description = "ID of the Windows instance"
  value       = aws_instance.windows_ansible.id
}

output "instance_public_ip" {
  description = "Public IP address"
  value       = aws_instance.windows_ansible.public_ip
}

output "instance_private_ip" {
  description = "Private IP address"
  value       = aws_instance.windows_ansible.private_ip
}

output "rdp_command" {
  description = "RDP connection info"
  value       = "Connect via RDP to: ${aws_instance.windows_ansible.public_ip}"
}

output "get_password_command" {
  description = "Command to decrypt Windows password"
  value       = "aws ec2 get-password-data --instance-id ${aws_instance.windows_ansible.id} --priv-launch-key /path/to/your-key.pem"
}

output "userdata_log_location" {
  description = "Location of UserData execution log"
  value       = "C:\\UserData-Log.txt"
}
