function Set-PSGitLabIssueDueDate {
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