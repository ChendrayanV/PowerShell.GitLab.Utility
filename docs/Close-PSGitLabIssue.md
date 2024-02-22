---
external help file: PowerShell.GitLab.Utility-help.xml
Module Name: PowerShell.GitLab.Utility
online version: https://docs.gitlab.com/ee/api/graphql/reference/#mutationupdateissue
schema: 2.0.0
---

# Close-PSGitLabIssue

## SYNOPSIS
A PowerShell cmdlet to close the GitLab issue.

## SYNTAX

```
Close-PSGitLabIssue [[-OrganizationName] <Object>] [[-PrivateToken] <Object>] [[-ProjectFullPath] <Object>]
 [-IID] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
A PowerShell cmdlet to close the GitLab issue.

## EXAMPLES

### EXAMPLE 1
```
Close-PSGitLabIssue -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXX' -ProjectFullPath 'group/projectpath' -IID 1
```

## PARAMETERS

### -OrganizationName
{{ Fill OrganizationName Description }}

```yaml
Type: Object
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
Type: Object
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
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IID
{{ Fill IID Description }}

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

[https://docs.gitlab.com/ee/api/graphql/reference/#mutationupdateissue](https://docs.gitlab.com/ee/api/graphql/reference/#mutationupdateissue)

