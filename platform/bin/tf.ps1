# Wrapper script for running terraform apply & plan commands in PowerShell

# Load environment variables from .env
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ($_ -match "^\s*#") { return }  # skip comments
        if ($_ -match "^\s*$") { return }  # skip empty lines
        $parts = $_ -split '=', 2
        if ($parts.Count -eq 2) {
            $key = $parts[0].Trim()
            $val = $parts[1].Trim('"').Trim("'")
            [System.Environment]::SetEnvironmentVariable($key, $val)
        }
    }
}

# Ensure we are in the same directory as the script location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location (Join-Path $scriptDir "..")
$repoDir = Get-Location

# Show help if the first argument is --help or help
if ($args.Count -ge 1 -and ($args[0] -eq "help" -or $args[0] -eq "--help")) {
    Write-Host "This script wraps basic terraform commands with the required flags and settings"
    Write-Host "To use, run bin\tf.ps1 <environment> <command> [<options>]"
    Write-Host "eg."
    Write-Host ".\bin\tf.ps1 test plan"
    Write-Host ".\bin\tf.ps1 staging apply --target module.eks"
    exit 0
}

if ($args.Count -lt 2) {
    Write-Host "Usage: .\bin\tf.ps1 <environment> <command> [<options>]"
    exit 1
}

$envDir = $args[0]
$tfArgs = $args[1..($args.Count - 1)]

Set-Location $envDir

terraform @tfArgs

Set-Location $repoDir