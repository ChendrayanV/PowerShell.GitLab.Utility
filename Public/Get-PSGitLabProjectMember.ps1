function Get-PSGitLabProjectMember {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $OrganizationName,

        [Parameter(Mandatory)]
        [string]
        $PrivateToken,

        [Parameter(Mandatory)]
        $ProjectFullPath
    )
    
    do {
        $query = @{
          query = @"
          query {
            project(fullPath: "$($ProjectFullPath)") {
              projectMembers(first: 99, after: "$($endCursor)") {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                nodes {
                  id
                  user {
                    name
                    state
                    createdAt
                    lastActivityOn
                    publicEmail
                  }
                }
              }
            }
          }
"@
        } | ConvertTo-Json 
      
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.project.projectMembers.nodes
        $endCursor = $response.data.project.pageInfo.endCursor
        $hasNextPage = $response.data.project.pageInfo.hasNextPage
    
      } while ($hasNextPage)
}