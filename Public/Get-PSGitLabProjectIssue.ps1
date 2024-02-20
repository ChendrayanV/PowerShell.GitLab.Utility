function Get-PSGitLabProjectIssue {
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
        Get-PSGitLabProjectIssue -OrganizationName 'gitlab.com' -PrivateToken 'XXXXX' -ProjectFullPath 'group/projectfullpath' 
        
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
    
    do {
        
        $query = @{
            query = @"
                query {
                    project(fullPath: "$($ProjectFullPath)") {
                        issues (first: 20, after: "$($endCursor)") {
                            pageInfo {
                                hasNextPage
                                endCursor
                            }
                            nodes {
                                id
                                iid
                                createdAt
                                closedAt
                                weight
                                confidential
                                state
                                severity
                                title
                                labels {
                                    nodes {
                                        title
                                    }   
                                }
                            }
                        }
                    }
                }
"@
        } | ConvertTo-Json 
    
        $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        $response.data.project.issues.nodes
        $endCursor = $response.data.project.issues.pageInfo.endCursor
        $hasNextPage = $response.data.project.issues.pageInfo.hasNextPage

    } while ($hasNextPage)
}