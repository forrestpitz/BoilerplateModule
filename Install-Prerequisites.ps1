<#
.SYNOPSIS
    Install the prerequisite powershell packages
#>
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Install-Prerequisites must be run as administrator."
}

$modulesToInstall = @("PSDepend", "InvokeBuild")

$modulesToInstall | ForEach-Object {
    if (-not (Get-Module -ListAvailable -Name $_)) {
        Install-Module $_
    }
}