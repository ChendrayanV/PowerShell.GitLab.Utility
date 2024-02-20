function Get-PSGitLabCICDVariable {
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
      Get-PSGitLabProjectCICDVariable -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXX' -ProjectFullPath 'group/projectfullpath'
    #>
    
    
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    $OrganizationName,

    [Parameter(Mandatory)]
    $PrivateToken,
        
    [Parameter(Mandatory, ParameterSetName = 'Project')]
    $ProjectFullPath,

    [Parameter(Mandatory, ParameterSetName = 'Group')]
    $GroupFullPath
  )
    
  
  
  switch ($PSCmdlet.ParameterSetName) {
    'Project' {
      do {
        
        $query = @{
          query = @"
        query {
            project(fullPath: "$($ProjectFullPath)") {
              ciVariables(first: 10, after: "$($endCursor)") {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                nodes {
                  key
                  value
                  masked
                  environmentScope
                  protected
                  variableType
                }
              }
            }
          }
"@
        } | ConvertTo-Json 
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.project.ciVariables.nodes
        $endCursor = $response.data.project.ciVariables.pageInfo.endCursor
        $hasNextPage = $response.data.project.ciVariables.pageInfo.hasNextPage

      } while ($hasNextPage)
    }

    'Group' {
      do {
        
        $query = @{
          query = @"
        query {
            group(fullPath: "$($GroupFullPath)") {
              ciVariables(first: 10, after: "$($endCursor)") {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                nodes {
                  key
                  value
                  masked
                  environmentScope
                  protected
                  variableType
                }
              }
            }
          }
"@
        } | ConvertTo-Json 
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.group.ciVariables.nodes
        $endCursor = $response.data.group.ciVariables.pageInfo.endCursor
        $hasNextPage = $response.data.group.ciVariables.pageInfo.hasNextPage

      } while ($hasNextPage)
    }

    default {
      'Do something'
    }
  }
}

# Get-PSGitLabCICDVariable -OrganizationName 'gitlab.com' -PrivateToken 'glpat-39ZmznjESiztLVP3Pbzz' -ProjectFullPath "cloud-warriors/PowerShell.GitLab.Utility"