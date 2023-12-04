function Get-PSGitLabSnippet {
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