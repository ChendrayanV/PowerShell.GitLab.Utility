param (
    $PrivateToken
)

BeforeAll -Scriptblock {
    Import-Module .\PowerShell.GitLab.Utility.psd1 -Force
}

Describe -Name 'PowerShell.GitLab.Utility' -Fixture {
    Context -Name 'General' -Fixture {
        It -Name 'Public Folder Should Exists' {
            Test-Path .\Public | Should -Be $true
        }
    }

    Context -Name 'Existance of Examples' -Fixture {
        It -Name 'All cmdlets should have minimum 1 example' {
            $Cmdlets = Get-Command -Module PowerShell.GitLab.Utility
            foreach($Cmdlet in $Cmdlets) {
                (Get-Help $($Cmdlet)).Examples.Count | Should -BeExactly 1
            }
        }
    }
    
}

AfterAll -Scriptblock {
    Remove-Module PowerShell.GitLab.Utility
}