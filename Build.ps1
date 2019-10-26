<#
.SYNOPSIS
    Loads up invoke build and runs the predefined build steps for the module
.PARAMETER Configuration
    The build configuration. Supported values are "Debug" or "Release"
    Used to determine what build steps to run (e.g. help documentation isn't generated in debug) 
    * Defaults to "Debug"
#>
param(
    [ValidateSet("Debug", "Release")]
    $Configuration = "Debug"
)

if (-not (Get-Module -ListAvailable -Name InvokeBuild)) {
    throw "Invoke Build is not installed. Run Install-Prerequisites.ps1 before building."
}

Import-Module InvokeBuild
Invoke-Build -File $PSScriptRoot\Build\BuildSteps.ps1 -Configuration $Configuration