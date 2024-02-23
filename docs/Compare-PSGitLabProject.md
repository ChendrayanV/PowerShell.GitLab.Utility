---
external help file: PowerShell.GitLab.Utility-help.xml
Module Name: PowerShell.GitLab.Utility
online version:
schema: 2.0.0
---

# Compare-PSGitLabProject

## SYNOPSIS
A PowerShell function to compare two different project (Scalar Properties / fields)

## SYNTAX

```
Compare-PSGitLabProject [-OrganizationName] <Object> [-PrivateToken] <Object>
 [-ReferenceProjectFullPath] <String> [-DifferenceProjectFullPath] <String[]> [<CommonParameters>]
```

## DESCRIPTION
A PowerShell function to compare two different project (Scalar Properties / fields)

## EXAMPLES

### EXAMPLE 1
```
Compare-PSGitLabProject -OrganizationName 'gitlab.com' -PrivateToken 'Token' -ReferenceProjectFullPath 'group/project1' -DifferenceProjectFullPath 'group/project2'
```

## PARAMETERS

### -OrganizationName
{{ Fill OrganizationName Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
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

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReferenceProjectFullPath
{{ Fill ReferenceProjectFullPath Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DifferenceProjectFullPath
{{ Fill DifferenceProjectFullPath Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
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
Author: Chendrayan Venkatesan
Email : chendrayan.exchange@hotmail.com

## RELATED LINKS

[Specify a URI to a help page, this will show when Get-Help -Online is used.]()

