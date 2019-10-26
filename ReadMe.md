# Boilerplate Module

This module is designed to act as a blueprint for the structure and capabilities of a good powershell module

To get started run Install-Prerequisites.ps1 which will install Invoke-Build and PSDepend. All other dependencies will be bootstrapped by those packages.

To "compile" the module just run `"Build.ps1`"

Features:

* [Invoke-Build](https://github.com/nightroman/Invoke-Build) is used to "compile" the module, run tests via [Pester](https://github.com/pester/Pester) run script analysis with [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) and finally publish the package to nuget with Publish-Module
* Each function is in it's own file and then [ModuleBuilder](https://github.com/PoshCode/ModuleBuilder) is used to "compile" a psm1 from that source respecting the /Private and /Public folder strucutre to Export-ModuleMember
* All functions have their own Pester test file as well as integration tests that run accross multiple functions. Tests are tagged to allow for limited test runs
* PSScriptAnalyzer is used to make sure code conforms to style standards. This includes both built in and custom psscript analyzer rules.
* [PlatyPS](https://github.com/PowerShell/platyPS) Is used to make external help
* Functions use the advanced function syntax, support [CmdletBinding], should process, support pipeline input
* [PSCustomObjects] are given a PSTypeName parameter to allow functions to specify expected types.
* Code conforms to style guidelines laid out in https://github.com/PoshCode/PowerShellPracticeAndStyle