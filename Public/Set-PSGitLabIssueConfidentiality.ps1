function Set-PSGitLabIssueConfidentiality {
  <#
  .SYNOPSIS
    A PowerShell cmdlet to set the GitLab issue confidentiality.
  .DESCRIPTION
    A PowerShell cmdlet to set the GitLab issue confidentiality.
  .NOTES
    Author : Chendrayan Venkatesan
    Email  : Chendrayan.Exchange@hotmail.com
  .LINK
    https://docs.gitlab.com/ee/api/graphql/reference/#mutationissuesetconfidential
  .EXAMPLE
    Set-PSGitLabIssueConfidentiality -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXXX' -ProjectFullPath 'group/projectpath' -IID 5 -Confidential 'true'
  #>
  
  
  
  
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