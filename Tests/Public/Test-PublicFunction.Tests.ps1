Describe "TestPublicFunction" {
    Context "It handles string comparisons" {

        It "Returns true when the string was `"Forrest`"" {
            Test-PublicFunction "Forrest" | Should -Be $true
        }

        It "Returns false when the string was not `"Forrest`"" {
            Test-PublicFunction "asdf" | Should -Be $false
        }
    }
}