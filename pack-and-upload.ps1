param(
    [string]$AppSource = (Join-Path $PSScriptRoot "powerapps-canvas-template\app-src"),
    [string]$SolutionSrc = (Join-Path $PSScriptRoot "powerapps-canvas-template\solution-src"),
    [string]$OutDir = (Join-Path $PSScriptRoot "powerapps-canvas-template\out"),
    [switch]$PublishAfterImport
)

$ErrorActionPreference = "Stop"

function Fail([string]$Message) {
    Write-Host "ERROR: $Message" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command pac -ErrorAction SilentlyContinue)) {
    Fail "Power Platform CLI (pac) is not installed or not in PATH."
}

if (-not (Test-Path -LiteralPath $AppSource)) {
    Fail "App source folder not found: $AppSource"
}

if (-not (Test-Path -LiteralPath $SolutionSrc)) {
    Fail "Solution source folder not found: $SolutionSrc"
}

$canvasAppsFolder = Join-Path $SolutionSrc "CanvasApps"
if (-not (Test-Path -LiteralPath $canvasAppsFolder)) {
    Fail "CanvasApps folder not found under solution source: $canvasAppsFolder"
}

$docMsapp = Get-ChildItem -Path $canvasAppsFolder -Filter "*_DocumentUri.msapp" -File | Select-Object -First 1
if (-not $docMsapp) {
    Fail "No *_DocumentUri.msapp found in: $canvasAppsFolder"
}

New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

$updatedMsapp = Join-Path $OutDir "app-updated.msapp"
$solutionZip = Join-Path $OutDir "solution-updated.zip"

Write-Host "[1/4] Packing canvas source..."
pac canvas pack --sources "$AppSource" --msapp "$updatedMsapp" --layout SourceCode --overwrite

Write-Host "[2/4] Replacing solution canvas payload..."
Copy-Item "$updatedMsapp" "$($docMsapp.FullName)" -Force

Write-Host "[3/4] Packing solution zip..."
pac solution pack --folder "$SolutionSrc" --zipfile "$solutionZip" --packagetype Unmanaged

Write-Host "[4/4] Importing solution..."
pac solution import --path "$solutionZip" --publish-changes

if ($PublishAfterImport) {
    Write-Host "[5/5] Publishing all customizations..."
    pac solution publish
}

Write-Host "Done. App deploy completed." -ForegroundColor Green
Write-Host "Imported from zip: $solutionZip"
