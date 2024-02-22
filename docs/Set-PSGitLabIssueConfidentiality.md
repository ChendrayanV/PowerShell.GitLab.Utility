---
external help file: PowerShell.GitLab.Utility-help.xml
Module Name: PowerShell.GitLab.Utility
online version: https://docs.gitlab.com/ee/api/graphql/reference/#mutationissuesetconfidential
schema: 2.0.0
---

# Set-PSGitLabIssueConfidentiality

## SYNOPSIS
A PowerShell cmdlet to set the GitLab issue confidentiality.

## SYNTAX

```
Set-PSGitLabIssueConfidentiality [[-OrganizationName] <Object>] [[-PrivateToken] <Object>]
 [[-ProjectFullPath] <Object>] [[-IID] <Object>] [[-Confidential] <Object>] [<CommonParameters>]
```

## DESCRIPTION
A PowerShell cmdlet to set the GitLab issue confidentiality.

## EXAMPLES

### EXAMPLE 1
```
Set-PSGitLabIssueConfidentiality -OrganizationName 'gitlab.com' -PrivateToken 'XXXXXXX' -ProjectFullPath 'group/projectpath' -IID 5 -Confidential 'true'
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
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confidential
{{ Fill Confidential Description }}

```yaml
Type: Object
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
Author : Chendrayan Venkatesan
Email  : Chendrayan.Exchange@hotmail.com

## RELATED LINKS

[https://docs.gitlab.com/ee/api/graphql/reference/#mutationissuesetconfidential](https://docs.gitlab.com/ee/api/graphql/reference/#mutationissuesetconfidential)

