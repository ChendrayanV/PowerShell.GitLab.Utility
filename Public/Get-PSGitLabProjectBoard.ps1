function Get-PSGitLabProjectBoard {
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

        [Parameter(Mandatory)]
        $ProjectFullPath
    )

    do {
        $Query = @{
            query = @"
                query {
                    project(fullPath: "$($ProjectFullPath)") {
                    boards(first: 5, after: "$endCursor") {
                        pageInfo {
                            hasNextPage
                            endCursor
                        }
                        nodes {
                            id
                            name
                            createdAt
                        }
                    }
                    }
                }
              
"@
        } | ConvertTo-Json 
    
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.project.boards.nodes
        $endCursor = $response.data.project.boards.pageInfo.endCursor
        $hasNextPage = $response.data.project.boards.pageInfo.hasNextPage 

    } while ($hasNextPage)

}
