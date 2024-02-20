function Get-PSGitLabSnippet {
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
        [string]
        $OrganizationName,

        [Parameter(Mandatory)]
        [string]
        $PrivateToken,

        [Parameter(Mandatory)]
        $ProjectId
    )
    
    
    do {
        $query = @{
            query = @"
            query {
                snippets(first: 99, after: "$endCursor", projectId: "$ProjectId") {
                pageInfo {
                    hasNextPage
                    endCursor
                }
                nodes {
                  id
                  fileName
                  title
                }
  }
            }
"@
        } | ConvertTo-Json 
    
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.snippets.nodes
        $endCursor = $response.data.snippets.pageInfo.endCursor
        $hasNextPage = $response.data.snippets.pageInfo.hasNextPage

    } while ($hasNextPage)
}