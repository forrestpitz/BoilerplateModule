# Private functions aren't exported so we need InModuleScope to allow them to be tested
InModuleScope BoilerplateModule {
    Describe "TestPrivateFunction" -Tag "Unit" {
        Context "It handles string comparisons" {
            It "Throws when a custom object is not of type `"NameWrapper`"" {
                { Test-PrivateFunction "Forrest" } | Should -Throw
            }

            It "Returns true when the name property was `"Forrest`"" {
                $nameToTestObject = [PSCustomObject]@{
                    PSTypeName = "NameWrapper"
                    Name       = "Forrest"
                }

                Test-PrivateFunction -InputObject $nameToTestObject | Should -Be $true
            }

            It "Returns false when the name property was not `"Forrest`"" {
                $nameToTestObject = [PSCustomObject]@{
                    PSTypeName = "NameWrapper"
                    Name       = "asdf"
                }

                Test-PrivateFunction -InputObject $nameToTestObject | Should -Be $false
            }
        }
    }
}