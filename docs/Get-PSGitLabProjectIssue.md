---
external help file: PowerShell.GitLab.Utility-help.xml
Module Name: PowerShell.GitLab.Utility
online version: https://docs.gitlab.com/ee/api/graphql/reference/#projectissue
schema: 2.0.0
---

# Get-PSGitLabProjectIssue

## SYNOPSIS
A PowerShell cmdlet to retrieve GitLab issues (Project Scope)

## SYNTAX

```
Get-PSGitLabProjectIssue [[-OrganizationName] <String>] [[-PrivateToken] <String>]
 [[-ProjectFullPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
A PowerShell cmdlet to retrieve GitLab issues (Project Scope)

## EXAMPLES

### EXAMPLE 1
```
Get-PSGitLabProjectIssue -OrganizationName 'gitlab.com' -PrivateToken 'XXXXX' -ProjectFullPath 'group/projectfullpath'
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author : Chendrayan Venkatesan
Email  : Chendrayan.Exchange@hotmail.com

## RELATED LINKS

[https://docs.gitlab.com/ee/api/graphql/reference/#projectissue](https://docs.gitlab.com/ee/api/graphql/reference/#projectissue)

