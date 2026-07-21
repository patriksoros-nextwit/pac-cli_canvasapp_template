param(
    [string]$ZipFile = "C:\Users\soros\Git\PAC_CLI_test\PAC_CLI_CanvasApp_Template_1_0_0_1.zip",           # Change: exported solution zip path
    [string]$OutputFolder = "C:\Users\soros\Git\PAC_CLI_Templates\powerapps-canvas-template\solution-src" # Change: unpack destination folder
)

pac solution unpack --zipfile "$ZipFile" --folder "$OutputFolder" --packagetype Unmanaged
