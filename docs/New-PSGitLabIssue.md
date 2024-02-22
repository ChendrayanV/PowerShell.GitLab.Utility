---
external help file: PowerShell.GitLab.Utility-help.xml
Module Name: PowerShell.GitLab.Utility
online version: https://docs.gitlab.com/ee/api/graphql/reference/#mutationcreateissue
schema: 2.0.0
---

# New-PSGitLabIssue

## SYNOPSIS
A PowerShell cmdlet to create a GitLab issue.

## SYNTAX

```
New-PSGitLabIssue [[-OrganizationName] <String>] [[-PrivateToken] <String>] [[-ProjectFullPath] <String>]
 [[-Title] <String>] [<CommonParameters>]
```

## DESCRIPTION
A PowerShell cmdlet to create a GitLab issue.

## EXAMPLES

### EXAMPLE 1
```
New-PSGitLabIssue -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXXX' -ProjectFullPath 'group/projectpath' -Title 'First Issue'
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

### -Title
{{ Fill Title Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author : Chendrayan Venkatesan
Email  : Chendrayan.Exchange@hotmail.com

## RELATED LINKS

[https://docs.gitlab.com/ee/api/graphql/reference/#mutationcreateissue](https://docs.gitlab.com/ee/api/graphql/reference/#mutationcreateissue)

