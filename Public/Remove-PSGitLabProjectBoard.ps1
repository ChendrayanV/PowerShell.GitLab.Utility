function Remove-PSGitLabProjectBoard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]     
        $OrganizationName,

        [Parameter(Mandatory)]
        $PrivateToken,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]
        $BoardId
    )
    
    
    
    process {
        foreach ($Id in $BoardId) {
            $Query = @{
                query = @"
                mutation {
                    destroyBoard(input: {id: "$($Id)"}) {
                      board {
                        id
                        name
                      }
                      errors
                    }
                  }
                  
"@
            } | ConvertTo-Json -Compress

            $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 

            if ($response.errors) {
                Write-Error -Message $($response.errors.message) -InformationAction Continue
            }
            else {
                $response.data.destroyBoard
            }
        }
    }
    
}