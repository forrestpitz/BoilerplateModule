# Boilerplate Module

This module is designed to act as a blueprint for the structure and capabilities of a good powershell module.

## This module is designed to:
* Enforce well formatted and well documented code through script analysis
* Provide a framework for testing that code and easily confirming the code is being tested
* Provide a platform for "compiling" the code structure into a single module file to speed up module loading and prevent issues with powershell functionality like classes that don't play well with multi-file modules
* Provide a directory structure that promotes easy location of a given function while still allowing function grouping.

## Features:

* [Invoke-Build](https://github.com/nightroman/Invoke-Build) is used to "compile" the module, run tests via [Pester](https://github.com/pester/Pester) run script analysis with [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) and finally publish the package to nuget with Publish-Module
* Each function is in it's own file and then [ModuleBuilder](https://github.com/PoshCode/ModuleBuilder) is used to "compile" a psm1 from that source respecting the /Private and /Public folder structure to Export-ModuleMember
* All functions have their own Pester test file as well as integration tests that run across multiple functions. Tests are tagged to allow for limited test runs
* PSScriptAnalyzer is used to make sure code conforms to style standards. This includes both built in and custom psscript analyzer rules.
* [PlatyPS](https://github.com/PowerShell/platyPS) Is used to make external help
* Functions use the advanced function syntax, support [CmdletBinding], should process, support pipeline input
* [PSCustomObjects] are given a PSTypeName parameter to allow functions to specify expected types.
* Code conforms to style guidelines laid out in https://github.com/PoshCode/PowerShellPracticeAndStyle

## Getting Started
Tun Install-Prerequisites.ps1 which will install Invoke-Build and PSDepend. All other dependencies will be bootstrapped by those packages.

To "compile" the module just run `"Build.ps1`". Add a -Configuration Release if you want to generate external help documentation and publish the package.

## Code Layout:
```text
/:
    /.gitignore: Don't publish either the output directory or the dependencies pulled at build time.
    /Build.ps1: Run a "compile" step to make a module, run tests and script analysis and then optionally publish a new package version.
    /ReadMe.md: The file you are reading right now

/Build
    /Build.Dependencies.psd1: A list of dependencies used by PSDepend for the build and test process. 
    /BuildSteps.ps1: The script executed by Invoke-Build to drive the build and publish process.
/Docs
    /en-US:
        about_*: These help files give the user of your module a detailed look into specific topics (rather than function specific information). The remaining documentation is generated from the help comments
/Output
    This directory is where the compiled module, manifest, and documentation go. Think of it like /bin.
/Source
    /Classes:
        *.ps1: Each file is one class. That could range from custom validation attributes, object with better property validation etc.
    /Private:
        *.ps1: Each file is a different private function. They won't be exported as a module member.
    /Public:
        *.ps1: Each file is a different public function. They will be exported and available for a user of the module to use.
    /BoilerplateModule.psd1: This file is a scaffold for making the psd1 for the built module. some info like the copyright are take and others like exported functions are replaced at build time.
    /Build.psd1: Tells ModuleBuilder how to combine the files in /Source to make a module and where to put it. Must be named Build.psd1 or ModuleBuilder won't understand it 
/Tests
    /Private:
        *.Tests.ps1: Each function in /Source/Private should have a corresponding file in /Tests/Private to house the unit tests for those files.
    /Public:
        *.Tests.ps1: Each function in /Source/Public should have a corresponding file in /Tests/Public to house the unit tests for those files.
    /Integration:
        *.Tests.ps1: Some tests span more than one function. Use the /Integration folder to house tests that test multiple functions. File name should represent the scenario being tested. 
```