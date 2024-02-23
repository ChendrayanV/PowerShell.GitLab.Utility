function Compare-PSGitLabProject {
    <#
    .SYNOPSIS
        A PowerShell function to compare two different project (Scalar Properties / fields)
    .DESCRIPTION
        A PowerShell function to compare two different project (Scalar Properties / fields)
    .NOTES
        Author: Chendrayan Venkatesan
        Email : chendrayan.exchange@hotmail.com
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Compare-PSGitLabProject -OrganizationName 'gitlab.com' -PrivateToken 'Token' -ReferenceProjectFullPath 'group/project1' -DifferenceProjectFullPath 'group/project2' 
    #>
    
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $OrganizationName,

        [Parameter(Mandatory)]
        $PrivateToken,
        
        [Parameter(Mandatory)]
        [string]
        $ReferenceProjectFullPath,

        [Parameter(Mandatory)]
        [string[]]
        $DifferenceProjectFullPath
    )
    
    $query = @{
        query = @"
            fragment compareFields on Project {
                id
                name
                starCount
                forksCount
                wikiEnabled
                statistics {
                    commitCount
                }
                archived
                lastActivityAt
                languages {
                    name
                }
                dora {
                    metrics {
                      changeFailureRate
                      date
                      deploymentFrequency
                      timeToRestoreService
                    }
                }
                visibility
                repository {
                    rootRef
                    codeOwnersPath
                }
                pipelineCounts {
                    finished
                    pending
                    running
                }
                codeCoverageSummary {
                    averageCoverage
                    coverageCount
                    lastUpdatedOn
                }
                importStatus
                detailedImportStatus {
                    id
                    lastError
                    lastUpdateAt
                    lastUpdateStartedAt
                    lastSuccessfulUpdateAt
                }
            }
            
            {
                referenceProject: project(fullPath: "$($ReferenceProjectFullPath)") {
                    ...compareFields
                }
                differenceProject: project(fullPath: "$($DifferenceProjectFullPath)") {
                    ...compareFields
                }
            }
"@
    } | ConvertTo-Json 
    $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
    $response.data.psobject.properties.value
}