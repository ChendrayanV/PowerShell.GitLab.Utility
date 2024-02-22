---
external help file: PowerShell.GitLab.Utility-help.xml
Module Name: PowerShell.GitLab.Utility
online version:
schema: 2.0.0
---

# New-PSGitLabBranch

## SYNOPSIS
A short one-line action-based description, e.g.
'Tests if a function is valid'

## SYNTAX

```
New-PSGitLabBranch [[-OrganizationName] <String>] [[-PrivateToken] <String>] [[-ProjectFullPath] <String>]
 [[-BranchName] <String>] [[-SourceBranchName] <String>] [<CommonParameters>]
```

## DESCRIPTION
A longer description of the function, its purpose, common use cases, etc.

## EXAMPLES

### EXAMPLE 1
```
New-PSGitLabBranch -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXX' -ProjectFullPath 'group/projectfullpath' -BranchName 'branchname' -SourceBranchName 'main'
Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
```

## PARAMETERS

### -OrganizationName
{{ Fill OrganizationName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivateToken
{{ Fill PrivateToken Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectFullPath
{{ Fill ProjectFullPath Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BranchName
{{ Fill BranchName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceBranchName
{{ Fill SourceBranchName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Information or caveats about the function e.g.
'This function is not supported in Linux'

## RELATED LINKS

[Specify a URI to a help page, this will show when Get-Help -Online is used.]()

