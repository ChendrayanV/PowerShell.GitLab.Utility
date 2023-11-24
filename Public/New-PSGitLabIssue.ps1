function New-PSGitLabIssue {
  <#
  .SYNOPSIS
      A PowerShell cmdlet to create a GitLab issue.
  .DESCRIPTION
      A PowerShell cmdlet to create a GitLab issue.
  .NOTES
      Author : Chendrayan Venkatesan
      Email  : Chendrayan.Exchange@hotmail.com
  .LINK
      https://docs.gitlab.com/ee/api/graphql/reference/#mutationcreateissue
  .EXAMPLE
      New-PSGitLabIssue -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXXX' -ProjectFullPath 'group/projectpath' -Title 'First Issue'
  #>
  
  
  [CmdletBinding()]
  param (
    [string]
    $OrganizationName,

    [string]
    $PrivateToken,

    [string]
    $ProjectFullPath,

    [string]
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