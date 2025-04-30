<#
.SYNTAX
    .\install-prereqs.ps1
.DESCRIPTION
    Installs the following prerequisites using winget:
      - Git
      - Node.js (LTS)
      - Python 3.10
      - Visual Studio Code
      - Docker Desktop
.AUTHOR
    Dan Stolts
.DATE
    2025-04-29
#>

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# Check for winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget not found. Please install App Installer from the Microsoft Store or install prerequisites manually."
    exit 1
}

function Install-PackageIfNeeded {
    param (
        [Parameter(Mandatory)]
        [string]$Id,
        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Host "Checking for $Name..."
    $found = winget list --id $Id --source winget --quiet
    if ($found) {
        Write-Host "$Name is already installed.`n"
    }
    else {
        Write-Host "Installing $Name..."
        winget install `
            --id $Id `
            --silent `
            --accept-package-agreements `
            --accept-source-agreements

        if ($LASTEXITCODE -eq 0) {
            Write-Host "$Name installation succeeded.`n"
        }
        else {
            Write-Warning "$Name installation failed. Please install $Name manually."
        }
    }
}

# Install required software
Install-PackageIfNeeded -Id "Git.Git" -Name "Git"
Install-PackageIfNeeded -Id "NodeJS.LTS" -Name "Node.js LTS"
Install-PackageIfNeeded -Id "Python.Python.3.10" -Name "Python 3.10"
Install-PackageIfNeeded -Id "Microsoft.VisualStudioCode" -Name "Visual Studio Code"
Install-PackageIfNeeded -Id "Docker.DockerDesktop" -Name "Docker Desktop"

Write-Host "Prerequisite installation complete. Please restart your terminal to pick up any PATH changes."
