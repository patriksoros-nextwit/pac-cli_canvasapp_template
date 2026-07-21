param(
    [Parameter(Mandatory = $true)]
    [string]$Environment,

    [int]$AuthIndex,

    [switch]$CreateAuth
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command pac -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Power Platform CLI (pac) is not installed or not in PATH." -ForegroundColor Red
    exit 1
}

if ($CreateAuth) {
    Write-Host "[1/5] Creating a new PAC auth profile..."
    pac auth create
} else {
    Write-Host "[1/5] Skipping auth creation (use -CreateAuth to add a new profile)."
}

Write-Host "[2/5] Available PAC auth profiles:"
pac auth list

if ($PSBoundParameters.ContainsKey('AuthIndex')) {
    Write-Host "[3/5] Selecting PAC auth profile index: $AuthIndex"
    pac auth select --index $AuthIndex
} else {
    Write-Host "[3/5] Keeping current PAC auth profile (use -AuthIndex to switch)."
}

Write-Host "[4/5] Selecting target environment: $Environment"
pac org select --environment "$Environment"

Write-Host "[5/5] Current PAC context:"
pac org who

Write-Host "Done. PAC environment is ready." -ForegroundColor Green
