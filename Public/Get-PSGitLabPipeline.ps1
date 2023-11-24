function Get-PSGitLabPipeline {
    <#
    .SYNOPSIS
        A PowerShell cmdlet to retrieve GitLab issues (Project Scope)
    .DESCRIPTION
        A PowerShell cmdlet to retrieve GitLab issues (Project Scope)
    .NOTES
        Author : Chendrayan Venkatesan
        Email  : Chendrayan.Exchange@hotmail.com
    .LINK
        https://docs.gitlab.com/ee/api/graphql/reference/#projectissue
    .EXAMPLE
        Get-PSGitLabPipeline -OrganizationName 'gitlab.com' -PrivateToken 'XXXXX' -ProjectFullPath 'group/projectfullpath' 
        
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
                    pipelines(first: 100, after: null) {
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
    
    $collection = @()
    while ($true) {
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json'     
        $query = @{
            query = @"
                query {
                    project(fullPath: "$($ProjectFullPath)") {
                        pipelines(first: 100, after: "$($response.data.project.pipelines.pageInfo.endCursor)") {
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
        $collection += $response
        if ($response.data.project.pipelines.pageInfo.hasNextPage -eq $false) {
            break
        }
    }
    $collection.data.project.pipelines.nodes
}

