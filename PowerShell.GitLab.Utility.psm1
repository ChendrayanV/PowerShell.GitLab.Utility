$Public = @(Get-ChildItem -Recurse -Path $PSScriptRoot/Public/*.ps1)

foreach ($import in $Public) {
	try {
		. $import.fullname
	}
 catch {
		Write-Error -Message "Failed to import function $($import.fullname): $_" -InformationAction Continue
	}
}

Export-ModuleMember -Function $Public.Basename