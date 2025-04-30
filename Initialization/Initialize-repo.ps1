<#
.SYNOPSIS
  Bootstraps repo structure for audit-billing-platform

.DESCRIPTION
  Creates folders under config/schemas, src/functions, and src/agent,
  and creates empty schema, README.md and .gitignore files.

  Place this script in an `Initialization` folder at the repo root,
  then run it from anywhere.
#>

# Determine script and repo root paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot  = Split-Path -Parent $scriptDir

Write-Host "Repo root detected at: $repoRoot"

# Directories to create
$dirs = @(
    "$repoRoot\config\schemas",
    "$repoRoot\src\functions\ingest",
    "$repoRoot\src\functions\report",
    "$repoRoot\src\functions\chat-dsl",
    "$repoRoot\src\agent"
)

# Files to create
$files = @(
    "$repoRoot\.gitignore",
    "$repoRoot\README.md",
    "$repoRoot\config\schemas\assets.schema.json",
    "$repoRoot\config\schemas\skus.schema.json",
    "$repoRoot\config\schemas\licensePool.schema.json",
    "$repoRoot\config\schemas\subscriptionInstance.schema.json",
    "$repoRoot\config\schemas\assignments.schema.json",
    "$repoRoot\config\schemas\licenseUsage.schema.json",
    "$repoRoot\config\schemas\subscriptionUsage.schema.json",
    "$repoRoot\config\schemas\discount.schema.json",
    "$repoRoot\config\schemas\taxComponent.schema.json",
    "$repoRoot\config\schemas\taxProfile.schema.json",
    "$repoRoot\config\schemas\taxOverride.schema.json",
    "$repoRoot\src\agent\Dockerfile",
    "$repoRoot\src\agent\collector.ps1"
)

# Create directories
foreach ($dir in $dirs) {
    if (-not (Test-Path -Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created directory: $dir"
    } else {
        Write-Host "Directory already exists: $dir"
    }
}

# Create files
foreach ($file in $files) {
    if (-not (Test-Path -Path $file)) {
        # Ensure parent directory exists
        $parent = Split-Path -Parent $file
        if (-not (Test-Path -Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        New-Item -ItemType File -Path $file -Force | Out-Null
        Write-Host "Created file: $file"
    } else {
        Write-Host "File already exists: $file"
    }
}

Write-Host "Bootstrap complete."
