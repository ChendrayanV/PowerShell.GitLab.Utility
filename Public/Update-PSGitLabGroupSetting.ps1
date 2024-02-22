function Update-PSGitLabGroupSetting {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]     
        $OrganizationName,

        [Parameter(Mandatory)]
        $PrivateToken,

        [Parameter(Mandatory)]
        [string[]]
        $GroupFullPath,

        [Parameter(Mandatory)]
        [ValidateSet('true', 'false')]
        $lockMathRenderingLimitsEnabled,

        [Parameter(Mandatory)]
        [ValidateSet('true', 'false')]
        $mathRenderingLimitsEnabled,

        [Parameter(Mandatory)]
        [ValidateSet('DISABLED_AND_UNOVERRIDABLE', 'DISABLED_AND_OVERRIDABLE', 'ENABLED')]
        $sharedRunnersSetting
    )
    
    process {
        $Query = @{
            query = @"
            mutation {
                groupUpdate(input: {fullPath: "$($GroupFullPath)",lockMathRenderingLimitsEnabled:$($lockMathRenderingLimitsEnabled), mathRenderingLimitsEnabled: $($mathRenderingLimitsEnabled), sharedRunnersSetting: $($sharedRunnersSetting)}) {
                  errors
                  group {
                    id
                    name
                  }
                }
              }
"@
        } | ConvertTo-Json -Compress

        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        if ($response.errors) {
            $response.errors
        }
        else {
            $response.data.groupUpdate.group
        }
    }
}