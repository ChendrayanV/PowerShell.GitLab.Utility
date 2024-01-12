function Test-PSGitLabObject {
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
                    project(fullPath: "$($ProjectFullPath)") {
                      id
                      name
                      createdAt
                      lastActivityAt
                    }
                  }
"@
            } | ConvertTo-Json 

            $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
            if ($response.data.project) {
                return $true
            }
            else {
                return $false
            }
        }

        'Group' {
            $query = @{
                query = @"
                query {
                    group(fullPath: "$($GroupFullPath)") {
                      id
                      name
                    }
                  }
"@
            } | ConvertTo-Json 
            $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
            if ($response.data.group) {
                return $true
            }
            else {
                return $false 
            }
        }
    }
}