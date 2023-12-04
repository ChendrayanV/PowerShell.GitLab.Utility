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
        [string]
        $ProjectId
    )
    
    
    $query = @{
        query = @"
            query {
                snippets(projectId:"$($ProjectId)",first:10,after: null) {
                pageInfo {
                    hasNextPage
                    endCursor
                }
                nodes {
                    id
                    title
                    description
                    fileName
                    rawUrl
                    hidden
                    createdAt
                    updatedAt
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
                    snippets(projectId:"$($ProjectId)",first:10,after: "$($response.data.snippets.pageInfo.endCursor)") {
                    pageInfo {
                        hasNextPage
                        endCursor
                    }
                    nodes {
                        id
                        title
                        description
                        fileName
                        rawUrl
                        hidden
                        createdAt
                        updatedAt
                    }
                    }
                }
"@
        } | ConvertTo-Json 
        
        $collection += $response
        
        if ($response.data.snippets.pageInfo.hasNextPage -eq $false) {
            break 
        }

    }
    $collection.data.snippets.nodes 
}