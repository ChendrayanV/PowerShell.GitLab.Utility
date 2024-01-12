function Get-PSGitLabMergeRequest {
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

        [Parameter(Mandatory, ParameterSetName = 'Project')]
        $ProjectFullPath,

        [Parameter(Mandatory, ParameterSetName = 'Group')]
        $GroupFullPath
    )

    
    switch ($PSCmdlet.ParameterSetName) {
        
        'Project' {
            $query = @{
                query = @"
                    query {
                        project(fullPath:"$($ProjectFullPath)") {
                        mergeRequests(first: 5, after: null) {
                            pageInfo {
                                hasNextPage
                                endCursor
                            }
                            nodes {
                                id
                                iid
                                projectId
                                approved
                                state
                                createdAt
                                author {
                                    name
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
                
                $query = @{
                    query = @"
                        query {
                            group(fullPath:"$($GroupFullPath)") {
                            mergeRequests(first: 5, after: "$($response.data.project.mergeRequests.pageInfo.endCursor)") {
                                pageInfo {
                                    hasNextPage
                                    endCursor
                                }
                                nodes {
                                    id
                                    iid
                                    projectId
                                    approved
                                    state
                                    createdAt
                                    author {
                                        name
                                    }
                                    
                                }
                            }
                            }
                        }
"@
                } | ConvertTo-Json

                $collection += $response
                if ($response.data.project.mergeRequests.pageInfo.hasNextPage -eq $false) {
                    break
                }
            }
            $collection.data.project.mergeRequests.nodes

        }

        'Group' {
            $query = @{
                query = @"
                    query {
                        group(fullPath:"$($GroupFullPath)") {
                        mergeRequests(includeSubgroups:true,first: 5, after: null) {
                            pageInfo {
                                hasNextPage
                                endCursor
                            }
                            nodes {
                                id
                                iid
                                createdAt
                                state
                                approved
                                author {
                                    name
                                }
                                project {
                                    id
                                    name
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
                
                $query = @{
                    query = @"
                        query {
                            group(fullPath:"$($GroupFullPath)") {
                            mergeRequests(includeSubgroups:true,first: 5, after: "$($response.data.group.mergeRequests.pageInfo.endCursor)") {
                                pageInfo {
                                    hasNextPage
                                    endCursor
                                }
                                nodes {
                                    id
                                    iid
                                    createdAt
                                    state
                                    approved
                                    author {
                                        name
                                    }
                                    project {
                                        id
                                        name
                                    }
                                }
                            }
                            }
                        }
"@
                } | ConvertTo-Json

                $collection += $response
                if ($response.data.group.mergeRequests.pageInfo.hasNextPage -eq $false) {
                    break
                }
            }
            $collection.data.group.mergeRequests.nodes

        }
    }
    
}