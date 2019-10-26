function Test-PrivateFunction {
    <#
    .SYNOPSIS
        A private test function
    .PARAMETER InputObject
        The string to test against
    #>
    [CmdletBinding()]
    [OutputType('bool')]
    param (
        [PSTypeName("NameWrapper")]
        [Parameter(ValueFromPipeline)]
        [PSCustomObject]
        $InputObject
    )
    process {
        # We foreach in the process block becuase we don't know if the function is called from the pipeline
        # or if it's called directly with an array of inputs
        foreach ($_ in $InputObject) {
            $_.Name -ceq "Forrest"
        }
    }
}