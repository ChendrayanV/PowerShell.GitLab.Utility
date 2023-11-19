function Set-PSGitLabIssueDueDate {
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
        
        $OrganizationName,

        $PrivateToken,

        $ProjectFullPath,

        $IID,

        $DueDate
    )
    
    $Query = @{
        query = @"
            mutation {
                issueSetDueDate(input: {projectPath:"$($ProjectFullPath)", iid:"$($IID)", dueDate: "$($DueDate)" }) {
                  issue {
                    id
                    iid
                    dueDate
                    state
                  }
                  errors
                }
              }
"@
    } | ConvertTo-Json -Compress
        
    $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        
    if ($response.errors) {
        Write-Error -Message $($response.errors.message) -InformationAction Continue
    }
    else {
        $response.data.issueSetDueDate.issue
    }
}