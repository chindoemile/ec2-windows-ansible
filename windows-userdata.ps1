<powershell>
# Minimal UserData - Under 16KB
$ErrorActionPreference = "Continue"
$Log = "C:\UserData-Log.txt"
Start-Transcript $Log

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Start-Sleep 10

# Refresh environment
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

# Install software
choco install git python -y --no-progress
Start-Sleep 30

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Add Python paths
$PythonPaths = @("C:\Python312","C:\Python311","C:\Python310")
foreach ($p in $PythonPaths) {
    if (Test-Path "$p\python.exe") {
        $env:Path += ";$p;$p\Scripts"
        break
    }
}

# Install Ansible
python -m pip install --upgrade pip --quiet
pip install ansible pywinrm boto3 --quiet

# Configure Git
git config --global user.name "EC2 Admin"
git config --global user.email "admin@ec2.local"

# Clone repo
New-Item C:\Ansible -ItemType Directory -Force | Out-Null
cd C:\Ansible
git clone ${github_repo_url}

# Create and run playbook
cd dba.ansible -ErrorAction SilentlyContinue
if (-not (Test-Path "test-playbook.yml")) {
@"
---
- name: Test Ansible
  hosts: localhost
  connection: local
  gather_facts: yes
  tasks:
    - debug: msg="Ansible {{ ansible_version.full }} works!"
    - win_command: git --version
      register: git
      changed_when: false
    - debug: var=git.stdout
    - win_copy:
        content: "Success at {{ ansible_date_time.iso8601 }}"
        dest: C:\Ansible-Success.txt
    - debug: msg="All tests passed!"
"@ | Out-File test-playbook.yml -Encoding UTF8
}

ansible-playbook test-playbook.yml -v

"Completed $(Get-Date)" | Out-File C:\UserData-Done.txt
Stop-Transcript
</powershell>
