
<#
.SYNOPSIS
    Builds, tests, and publishes the module
.PARAMETER Configuration
    The build configuration. Supported values are "Debug" or "Release"
    Used to determine what build steps to run (e.g. help documentation isn't generated in debug) 
    * Defaults to "Debug"
.NOTES
    # TODO: Version the build
#>
param(
    [ValidateSet("Debug", "Release")]
    $Configuration = "Debug"
)
begin {
    Import-Module -Force PSDepend
}
process {
    task Init {
        Set-StrictMode -Version Latest
    }

    # Synopsis: Load packages the build dependens on
    task LoadDependecies {
        # Load dependencies
        Invoke-PSDepend -Path $PSScriptRoot\Build.Dependencies.psd1 -Target $PSScriptRoot\Dependencies -Install -Import -Force
    }

    # Synopsis: Use ModuleBuilder to combine our script files, classes, etc into a module
    task Build {
        Build-Module -SourcePath $PSScriptRoot\..\Source\Build.psd1 -OutputDirectory "$PSScriptRoot\..\Output"
    }

    # Synopsis: Remove the built module files.
    task Clean {
        Remove-BuildItem $PSScriptRoot\..\Output
    }

    # Synopsis: Load the module we just built
    task LoadModule {
        Get-ChildItem -Recurse -Filter "*.psd1" -Path $PSScriptRoot\..\Output | Select-Object -Last 1 | ForEach-Object { Import-Module $_.FullName -DisableNameChecking -Force }
    }

    # Synopsis: Run all tests in the \Tests directory
    task Test {
        Get-ChildItem -Recurse -File -Path $PSScriptRoot\..\Tests | ForEach-Object { Invoke-Pester $_.FullName }
    }

    # Synopsis: Run PSScriptAnalizer for common and custom analysis
    task Analyze {
        Get-ChildItem -Recurse -File -Path $PSScriptRoot\..\Source | ForEach-Object { Invoke-ScriptAnalyzer $_.FullName }
    }

    # Synopsis: Use PlatyPS to make MAML and Markdown external help 
    task MakeHelp -If ($Configuration -eq 'Release') {
        $ModuleName = (Import-PowerShellDataFile $PSScriptRoot\..\Source\Build.psd1).Path.Split(".")[0]
        New-MarkdownHelp -Module $ModuleName -OutputFolder "$PSScriptRoot\..\Output\1.1.0\Docs"
        New-ExternalHelp "$PSScriptRoot\..\Output\1.1.0\Docs" -OutputPath "$PSScriptRoot\..\Output\1.1.0\en-US\"
    }

    # Synopsis: run the full build pipeline.
    task . Clean, LoadDependecies, Build, LoadModule, Test, Analyze, MakeHelp 
}