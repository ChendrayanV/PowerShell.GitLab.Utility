function Get-PSGitLabGroupProject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $OrganizationName,

        [Parameter(Mandatory)]
        $PrivateToken,

        [Parameter(Mandatory)]
        $GroupFullPath
    )
    
    $Query = @{
        query = @"
        query {
            group(fullPath: "$($GroupFullPath)") {
              projects(first:5, after: null) {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                nodes {
                  id
                  name
                  path
                  createdAt
                  lastActivityAt
                  languages {
                    name
                  }
                  importStatus
                  archived
                  issueStatusCounts {
                    all
                    closed
                    opened
                  }
                }
              }
            }
          }
              
"@
    } | ConvertTo-Json 
    $collection = @()

    while ($true) {
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $Query = @{
            query = @"
            query {
                group(fullPath: "$($GroupFullPath)") {
                  projects(first:5, after: "$($response.data.group.projects.pageInfo.endCursor)") {
                    pageInfo {
                      hasNextPage
                      endCursor
                    }
                    nodes {
                      id
                      name
                      path
                      createdAt
                      lastActivityAt
                      languages {
                        name
                      }
                      importStatus
                        archived
                        issueStatusCounts {
                            all
                            closed
                            opened
                          }
                    }
                  }
                }
              }
                  
"@
        } | ConvertTo-Json -Compress
        $collection += $response
        if ($response.data.group.projects.pageInfo.hasNextPage -eq $false) {
            break 
        }
    }
    $collection.data.group.projects.nodes

}