function Get-PSGitLabPipeline {
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
        $query = @{
            query = @"
            query {
                project(fullPath: "$($ProjectFullPath)") {
                    pipelines(first: 100, after: "$endCursor") {
                            pageInfo {
                                hasNextPage
                                endCursor
                            }
                            nodes {
                                id
                                status
                                startedAt
                                finishedAt
                            }
                        }
                    }
                }
"@
        } | ConvertTo-Json
    
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.project.pipelines.nodes
        $endCursor = $response.data.project.pipelines.pageInfo.endCursor
        $hasNextPage = $response.data.project.pipelines.pageInfo.hasNextPage

    } while ($hasNextPage)

}