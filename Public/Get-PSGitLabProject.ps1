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
    $PrivateToken,

    [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Project', HelpMessage = 'Full Path of the Project - Example: Group/Project')]
    [string[]]
    $ProjectFullPath,

    [Parameter(Mandatory, ParameterSetName = 'Group')]
    $GroupFullPath
  )

  

  process {
    switch ($PSCmdlet.ParameterSetName) {
      'Project' {
        foreach ($Project in $ProjectFullPath) {
          $query = @{
            query = @"
            query {
              project(fullPath:"$($Project)") {
                id
                name
                archived
                createdAt
                lastActivityAt
              }
            }
"@
          } | ConvertTo-Json 
          $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
          $response.data.project
        }
      }
  
      'Group' {
        $checkGroupExists = Test-PSGitLabObject -OrganizationName $($OrganizationName) -PrivateToken $($PrivateToken) -GroupFullPath $($GroupFullPath)
        if ($checkGroupExists -eq $true) {
          $Query = @{
            query = @"
          query {
              group(fullPath: "$($GroupFullPath)") {
                projects(includeSubgroups: true,first:5, after: null) {
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
                    projects(includeSubgroups: true,first:5, after: "$($response.data.group.projects.pageInfo.endCursor)") {
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
        else {
          Write-Warning -Message "The group $($GroupFullPath) is not found. Contact the GitLab administrator" -InformationAction Continue
        }
      }
    }
  }
}