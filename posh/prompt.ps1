function Prompt {
	$ExitCodeBackup = $LASTEXITCODE
	$TimeString = Get-Date -Format "HH:MM:ss"
	$CurrentLocation = $executionContext.SessionState.Path.CurrentLocation
	$RolePrompt = if (Test-IsAdmin) { "#" } else { "$" }


	if (Get-GitStatus -Force) {
		$VcsPrompt = "─$(Write-VcsStatus)"
	}
	else {
		$VcsPrompt = ""
	}


	$LASTEXITCODE = $ExitCodeBackup

	return "┬─[$TimeString]─[$CurrentLocation]$VcsPrompt$([System.Environment]::NewLine)╰─>$($RolePrompt * ($nestedPromptLevel + 1)) ";
}
