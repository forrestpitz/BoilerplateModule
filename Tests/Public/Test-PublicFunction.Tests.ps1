Describe "TestPublicFunction" -Tag "Unit" {
    Context "It handles string comparisons" {

        It "Returns true when the string was `"Forrest`"" {
            Test-PublicFunction "Forrest" | Should -Be $true
        }

        It "Returns false when the string was not `"Forrest`"" {
            Test-PublicFunction "asdf" | Should -Be $false
        }
    }

    Context "Pipelines" {
        It "Handles pipeline input" {
            "Forrest" | Test-PublicFunction | Should -Be $true
            "asdf" | Test-PublicFunction | Should -Be $false
            "asdf", "Forrest" | Test-PublicFunction | Should -Be $false, $true
        }
    }
}