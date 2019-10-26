function Test-PublicFunction {
    <#
    .SYNOPSIS
        A public test function. It calls a private function for real functionality
    .PARAMETER NameToTest
        The name to test
    #>
    [CmdletBinding()]
    [OutputType('bool')]
    param (
        [Parameter(ValueFromPipeline)]
        [string]
        $NameToTest
    )
    process {
        # We foreach in the process block becuase we don't know if the function is called from the pipeline
        # or if it's called directly with an array of inputs
        foreach ($_ in $NameToTest) {
            $nameToTestObject = [PSCustomObject]@{
                PSTypeName = "NameWrapper"
                Name       = $_
            }

            Test-PrivateFunction -InputObject $nameToTestObject
        }
    }
}