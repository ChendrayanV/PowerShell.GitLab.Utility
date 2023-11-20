param (
    $PrivateToken
)

BeforeAll -Scriptblock {
    Import-Module .\PowerShell.GitLab.Utility.psd1 
}

Describe -Name 'PowerShell.GitLab.Utility' -Fixture {
    Context -Name 'General' -Fixture {
        It -Name 'Public Folder Should Exists' {
            Test-Path .\Public | Should -Be $true
        }
    }

    
}

AfterAll -Scriptblock {
    Remove-Module PowerShell.GitLab.Utility
}