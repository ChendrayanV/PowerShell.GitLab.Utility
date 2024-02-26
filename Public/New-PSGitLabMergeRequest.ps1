function New-PSGitLabMergeRequest {
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
        $ProjectFullPath,

        [Parameter(Mandatory)]
        $Title,
        
        [Parameter(Mandatory)]
        $SourceBranch,
        
        [Parameter(Mandatory)]
        $TargetBranch
    )
    
    $Query = @{
        query = @"
            mutation {
                mergeRequestCreate(input: {projectPath: "$($ProjectFullPath)", title: "$($Title)", sourceBranch: "$($SourceBranch)", targetBranch: "$($TargetBranch)"}) {
                mergeRequest {
                    id
                    author {
                        name
                    }
                }
                errors
                }
            }
"@
    } | ConvertTo-Json -Compress
        
    $response = Invoke-RestMethod -Uri "https://$($OrganizationName)/api/graphql" -Headers @{Authorization = "Bearer $($PrivateToken)" } -Method Post -Body $query -ContentType 'application/json' 
        
    if ($response.errors) {
        $response.errors
    }
    else {
        $response.data.mergeRequest
    }
}