function Get-PSGitLabCICDSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $OrganizationName,

        [Parameter(Mandatory)]
        $PrivateToken,
        
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]
        $ProjectFullPath
    )
    
    process {
        foreach ($Project in $ProjectFullPath) {
            do {
                $query = @{
                    query = @"
                        query {
                            project(fullPath: "$($Project)") {
                            ciCdSettings {
                                    inboundJobTokenScopeEnabled
                                    jobTokenScopeEnabled
                                    keepLatestArtifact
                                    mergePipelinesEnabled
                                    mergeTrainsEnabled
                                    mergeTrainsSkipTrainAllowed
                                    project {
                                        id
                                        name
                                      }
                                }
                            }
                        }
"@
                } | ConvertTo-Json 
                $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
                $response.data.project.ciCdSettings
            } while ($hasNextPage)
            
        }
    }
}