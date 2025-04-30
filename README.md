# audit
# Audit & Billing Platform

This repo contains the code and configuration for a multi-tenant, serverless Audit & Billing Platform on Azure.  
This README explains **why** it exists and guides you—step by step—from a fresh Windows machine (PowerShell 7.5.1) to a working local development environment with Azure Functions.

---

## Why This README

- **Onboarding**: All prerequisites in one place.  
- **Reproducibility**: Ensures consistent tool versions and paths.  
- **Documentation**: Your primary reference for setup and local development.

---

## Prerequisites

- **PowerShell 7.5.1** (or later)  
- **Admin rights** (to install global tools and SDKs)  
- **Internet access**

> No VMs, no extra runtimes—just PowerShell.

---

## 1. Install .NET 6 SDK (LTS)

Needed to host the Azure Functions Core Tools global-tool.

```powershell
# 1) Download .NET 6 LTS SDK (x64)
$dotnetMsi = "$env:TEMP\dotnet-sdk6-lts.msi"
Invoke-WebRequest `
  -Uri "https://download.visualstudio.microsoft.com/download/pr/0a8b4e3f-8c8e-4fbb-9a87-cfefa40e2e5f/2b8c5cc0c26d3cdd8d5b5e2b2e3a1b4a/dotnet-sdk-6.0.426-win-x64.exe" `
  -OutFile $dotnetMsi

# 2) Silent install
Start-Process msiexec.exe `
  -ArgumentList "/i `"$dotnetMsi`" /quiet /norestart" -Wait

# 3) Verify & cleanup
if (Get-Command dotnet -ErrorAction SilentlyContinue) {
  Write-Host "✅ .NET SDK installed. Removing installer."
  Remove-Item $dotnetMsi -Force
} else {
  Write-Warning "❌ .NET SDK not found. Please install manually from https://dotnet.microsoft.com/download"
}

https://aka.ms/azfunc-win64
https://github.com/Azure/azure-functions-core-tools/?tab=readme-ov-file
# 1) Download the latest ZIP from GitHub Releases
$version = '4.0.4895'   # update to the latest tag as needed
$zipUrl  = "https://github.com/Azure/azure-functions-core-tools/releases/download/$version/Azure.Functions.Cli.win-x64.zip"
$zipPath = "$env:TEMP\func.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# 2) Extract to a user-local tools folder
$installDir = "$HOME\AzureFunctionsCoreTools"
Remove-Item -Recurse -Force $installDir -ErrorAction SilentlyContinue
Expand-Archive -Path $zipPath -DestinationPath $installDir

# 3) Add to PATH for current session & persist for user
$env:PATH += ";$installDir"
[Environment]::SetEnvironmentVariable('PATH', $Env:PATH, 'User')

# 4) Cleanup
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
    Write-Host "✅ Core Tools extracted to $installDir and ZIP cleaned up."
}

# 5) Verify
func --version