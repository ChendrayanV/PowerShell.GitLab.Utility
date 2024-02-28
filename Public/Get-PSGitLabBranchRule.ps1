function Get-PSGitLabBranchRule {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $OrganizationName,

        [Parameter(Mandatory)]
        $PrivateToken,
        
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]
        $ProjectFullPath
    )
    
    $query = @{
        query = @"
            query {
                project(fullPath: "$($ProjectFullPath)") {
                branchRules {
                    nodes {
                    name
                    isDefault
                    isProtected
                    matchingBranchesCount
                    createdAt
                    updatedAt
                    branchProtection {
                        allowForcePush
                        codeOwnerApprovalRequired
                        mergeAccessLevels {
                        nodes {
                            accessLevel
                            accessLevelDescription
                            user {
                            name
                            }
                            group {
                            name
                            }
                        }
                        }
                        pushAccessLevels {
                        nodes {
                            accessLevel
                            accessLevelDescription
                            user {
                            name
                            }
                            group {
                            name
                            }
                        }
                        }
                        unprotectAccessLevels {
                        nodes {
                            accessLevel
                            accessLevelDescription
                            user {
                            name
                            }
                            group {
                            name
                            }
                        }
                        }
                    }
                    externalStatusChecks {
                        nodes {
                        id
                        name
                        externalUrl
                        }
                    }
                    approvalRules {
                        nodes {
                        id
                        name
                        type
                        approvalsRequired
                        eligibleApprovers {
                            nodes {
                            name
                            }
                        }
                        }
                    }
                    }
                }
                }
            }
                    
"@
    } | ConvertTo-Json 

    $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
    
    if ($response.errors) {
        $response.errors
    }
    else {
        $response.data.project.branchRules.nodes
    }
}