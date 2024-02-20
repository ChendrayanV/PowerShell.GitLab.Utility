function Get-PSGitLabProject {
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
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
  #>
  
  
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    $OrganizationName,

    [Parameter(Mandatory)]
    $PrivateToken


  )

  do {
    $query = @{
      query = @"
          query {
            projects(first: 99, after: "$endCursor",membership: true) {
              pageInfo {
                hasNextPage
                endCursor
              }
              nodes {
                id
                name
                nameWithNamespace
                archived
                createdAt
                lastActivityAt
                
              }
            }
          }

                  
"@
    } | ConvertTo-Json 
  
    $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
    $response.data.projects.nodes
    $endCursor = $response.data.projects.pageInfo.endCursor
    $hasNextPage = $response.data.projects.pageInfo.hasNextPage

  } while ($hasNextPage)

}