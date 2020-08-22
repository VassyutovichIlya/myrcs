function Test-IsAdmin {
	<#
		.SYNOPSIS
		Check if PowerShell run elevated (e.g. as admin or not)

		.DESCRIPTION
		This is a complete new approach to check if the Shell runs elevated or not.
		It runs on PowerShell and PowerShell Core, and it supports macOS or Linux as well.

		.EXAMPLE
		PS C:\> Test-IsAdmin

		.NOTES
		Rewritten function to support PowerShell Desktop and Core on Windows, macOS, and Linux
		Mostly used within other functions and in the personal PowerShell profiles.

		Version: 1.0.1

		GUID: a59bfa91-7206-4892-bc2a-acf666b35364

		Author: Joerg Hochwald

		Companyname: Alright IT GmbH

		Copyright: Copyright (c) 2019, Alright IT GmbH - All rights reserved.

		License: https://opensource.org/licenses/BSD-3-Clause

		Releasenotes:
		1.0.1 2019-05-09: Add some comments to the code
		1.0.0 2019-05-09: Initial Release of the rewritten function

		THIS CODE IS MADE AVAILABLE AS IS, WITHOUT WARRANTY OF ANY KIND. THE ENTIRE RISK OF THE USE OR THE RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.
	 #>
	  
	[CmdletBinding(ConfirmImpact = 'None')]
	[OutputType([bool])]
	param ()
	  
	process {
		if ($PSVersionTable.PSEdition -ne "Core") {
			Write-Warning "Only PoSh-Core is supported"
			return
		}
  
		if ($PSVersionTable.Platform -eq "Unix") {
			if ((id -u) -eq 0) {
				return $true
			}
			else {
				return $false
			}
		}
		if ($PSVersionTable.Platform -eq "Win32NT") {
			# For PowerShell Core on Windows the same approach as with the Desktop work just fine
			# This is for future improvements :-)
			$CurrentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
			$CurrentPrincipal = [Security.Principal.WindowsPrincipal]$CurrentIdentity
			$AdministratorRole = [Security.Principal.WindowsBuiltInRole] "Administrator"
			return $CurrentPrincipal.IsInRole($AdministratorRole)
		}
		else {
			# Unable to figure it out!
			Write-Warning -Message "Unknown PowerShell platform `"$($PSVersionTable.Platform)`""
  
			return
		}
	}
}
