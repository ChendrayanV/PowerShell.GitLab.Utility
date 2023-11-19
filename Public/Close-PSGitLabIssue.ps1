function Close-PSGitLabIssue {
    [CmdletBinding()]
    param (
          
        $OrganizationName,
  
        $PrivateToken,
  
        $ProjectFullPath,
  
        $IID
    )
      
    $Query = @{
        query = @"
            mutation {
                updateIssue(input: {projectPath: "$($ProjectFullPath)", iid: "$($IID)", stateEvent:CLOSE}) {
                    issue {
                        id
                        iid
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
        $response.data.updateIssue.issue
    }
}