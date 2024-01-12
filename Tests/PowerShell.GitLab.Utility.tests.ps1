param (
    $PrivateToken,

    $ProjectFullPath,

    $GroupFullPath
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

    Context -Name 'Test PS GitLab Object' -Fixture {
        It -Name 'Project Path' {
            Test-PSGitLabObject -OrganizationName $($OrganizationName) -PrivateToken $($PrivateToken) -ProjectFullPath $($ProjectFullPath) | Should -BeIn $($true, $false)
        }

        It -Name 'Group Path' {
            Test-PSGitLabObject -OrganizationName $($OrganizationName) -PrivateToken $($PrivateToken) -GroupFullPath $($GroupFullPath) | Should -BeIn $($true, $false)
        }
    }
    
}

AfterAll -Scriptblock {
    Remove-Module PowerShell.GitLab.Utility
}