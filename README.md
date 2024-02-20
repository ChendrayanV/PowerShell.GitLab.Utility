# Introduction

`PowerShell.GitLab.Utility` is a PowerShell module designed to streamline and automate interactions with GitLab via PowerShell. As a Minimal Viable Product (MVP), this module aims to provide a foundational set of functionalities to manage GitLab resources, such as projects, repositories, issues, and merge requests, directly from your PowerShell command line.

## Features

The MVP version includes the following core features:

### Query

1. Issues
2. Merge Requests 
3. Pipeline 
4. Project: Board, Issues 

### Mutation

1. **Create:** MR, Issues, Project Board, Snippet
2. **Delete:** Pipeline, Project Board, Snipppet

## Installation

To install the PowerShell.GitLab.Utility module, run the following command in your PowerShell terminal:

```PowerShell
Install-Module -Name PowerShell.GitLab.Utility
```

Ensure that your execution policy allows for the installation of modules. You might need to adjust it by executing:

```PowerShell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```


## Usage 

```PowerShell
Import-Module PowerShell.GitLab.Utility
```

### Example Commands

***Retrieve GitLab Snippet***

```PowerShell
Get-PSGitLabSnippet -OrganizationName 'gitlab.com' -PrivateToken 'GITLAB-TOKEN' -ProjectId 'gid://gitlab/Project/SNIPPETID'
```

***Retrieve GitLab Pipeline Information***

```PowerShell
Get-PSGitLabPipeline -OrganizationName 'gitlab.com' -PrivateToken 'GITLAB-TOKEN' -ProjectFullPath "workwave/psgitlab"
```

## Configuration 


Before using the module, configure it with your GitLab personal access token and instance URL. This can be done by setting up a configuration file or directly providing the token and URL in your commands.

Please refer to the module's documentation for detailed instructions on configuration and advanced usage.

## Contributing

As an **M**inimal **V**iable **P**roduct, PowerShell.GitLab.Utility is open for contributions and feedback. Whether adding new features, fixing bugs, or improving documentation, your contributions are welcome! 

## License

This project is licensed under the MIT License - see the LICENSE file for details.

> Please note: This module is not officially affiliated with GitLab Inc. It is a community-driven project aimed at providing a convenient way for PowerShell users to interact with GitLab.
