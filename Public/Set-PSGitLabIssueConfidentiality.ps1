function Set-PSGitLabIssueConfidentiality {
  [CmdletBinding()]
  param (
          
    $OrganizationName,
  
    $PrivateToken,
  
    $ProjectFullPath,
  
    $IID,

    $Confidential
  )
      
  $Query = @{
    query = @"
    mutation {
        issueSetConfidential(input: {projectPath:"$($ProjectFullPath)", iid: "$($IID)", confidential: $($Confidential)}) {
          issue {
            id
            iid
            severity
            confidential
            createdAt
          }
          errors
        }
      }
"@
  } | ConvertTo-Json -Compress
      
  $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
      
  if ($response.errors) {
    $response.errors.message
  }
  else {
    $response.data.issueSetConfidential.issue
  }
}