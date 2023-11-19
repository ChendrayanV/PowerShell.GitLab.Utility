function New-PSGitLabIssue {
  [CmdletBinding()]
  param (
        
    $OrganizationName,

    $PrivateToken,

    $ProjectFullPath,

    $Title
  )
    
  $Query = @{
    query = @"
        mutation {
            createIssue(
              input: {projectPath: "$($ProjectFullPath)", title: "$($Title)"}
            ) {
              issue {
                id
                iid
                title
                createdAt
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
    $response.data.createIssue.issue
  }
}