function New-PSGitLabEpic {
    <#
    .SYNOPSIS
        A PowerShell cmdlet to create a GitLab epic.
    .DESCRIPTION
        A PowerShell cmdlet to create a GitLab epic.
    .NOTES
        Author : Chendrayan Venkatesan
        Email  : Chendrayan.Exchange@hotmail.com
    .LINK
        https://docs.gitlab.com/ee/api/graphql/reference/#mutationcreateepic
    .EXAMPLE
        New-PSGitLabEpic -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXXX' -GroupFullPath 'group' -Title 'First Issue'
    #>
    
    
    [CmdletBinding()]
    param (
      [string]
      $OrganizationName,
  
      [string]
      $PrivateToken,
  
      [string]
      $GroupFullPath,
  
      [string]
      $Title
    )
      
    $Query = @{
      query = @"
            mutation {
                createEpic(input: {groupPath: "$($GroupFullPath)", title: "$($Title)"}) {
                    epic {
                        id
                        author {
                            id
                            name
                        }
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
      $response.data.createEpic.epic
    }
  }