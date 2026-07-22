# =============================================================================
# unpack-solution.ps1
# =============================================================================
# PURPOSE
#   Unpacks a Power Apps solution zip into editable source files so the canvas
#   app can be version-controlled and edited with the PAC CLI / Copilot.
#
# WHEN DO YOU NEED THIS SCRIPT?
#   Only if you are starting from a freshly exported solution zip (e.g. the
#   very first time this template is set up, or after a manual export from
#   make.powerapps.com). If you cloned this repo from GitHub and the
#   solution-src folder already contains .pa.yaml files, you can skip this
#   script entirely and go straight to editing.
#
# BEFORE RUNNING — update the two parameters below:
#
#   $ZipFile      Path to the exported solution zip on YOUR machine.
#                 Export an Unmanaged solution from make.powerapps.com:
#                 Solutions → your solution → Export → Unmanaged
#                 Example: "C:\Downloads\MyClientApp_1_0_0_1.zip"
#
#   $OutputFolder Path to the solution-src folder inside your local clone of
#                 this repo. Change the root to match where YOU cloned it.
#                 Example: "C:\Users\yourname\Git\pac-cli_canvasapp_template-main\powerapps-canvas-template\solution-src"
#
# HOW TO RUN
#   Option A — edit the defaults below, then run:
#     .\unpack-solution.ps1
#
#   Option B — pass values inline without editing the file:
#     .\unpack-solution.ps1 -ZipFile "C:\Downloads\MyExport.zip" -OutputFolder "C:\Users\yourname\Git\...\solution-src"
# =============================================================================

param(
    [string]$ZipFile = "C:\Users\soros\Git\PAC_CLI_test\PAC_CLI_CanvasApp_Template_1_0_0_1.zip", # <-- UPDATE: path to your exported solution zip
    [string]$OutputFolder = "C:\Users\soros\Git\pac-cli_canvasapp_template-main\powerapps-canvas-template\solution-src" # <-- UPDATE: path to solution-src in your local repo clone
)

# Step 1: Unpack the solution zip into source folders
pac solution unpack --zipfile "$ZipFile" --folder "$OutputFolder" --packagetype Unmanaged

# Step 2: Unpack each canvas app .msapp file into .pa.yaml source files
Get-ChildItem -Path "$OutputFolder\CanvasApps" -Filter "*.msapp" | ForEach-Object {
    $sourcesFolder = $_.FullName -replace "\.msapp$", ""
    Write-Host "Unpacking canvas app: $($_.Name)"
    pac canvas unpack --msapp "$($_.FullName)" --sources "$sourcesFolder"
}
