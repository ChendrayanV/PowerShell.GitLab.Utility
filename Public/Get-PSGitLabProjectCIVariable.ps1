function Get-PSGitLabProjectCIVariable {
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
        [string]
        $OrganizationName,

        [string]
        $PrivateToken,

        [string]
        $ProjectFullPath
    )
    
    $query = @{
        query = @"
        query {
            project(fullPath: "$($ProjectFullPath)") {
              ciVariables(first: 10, after: null) {
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
    $collection = @()

    while ($true) {
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $query = @{
            query = @"
                query {
                    project(fullPath: "$($ProjectFullPath)") {
                    ciVariables(first: 10, after: "$($response.data.project.ciVariables.pageInfo.endCursor)") {
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

        $collection += $response
        if ($response.data.project.ciVariables.pageInfo.hasNextPage -eq $false) {
            break 
        }
    }
    $collection.data.project.ciVariables.nodes
}