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

    Context -Name 'Test ' -Fixture {
        It -Name 'Test for failures' {
            1 | Should -BeExactly 2
        }
    }
}

AfterAll -Scriptblock {
    Remove-Module PowerShell.GitLab.Utility
}