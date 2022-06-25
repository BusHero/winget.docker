function CreateDownloadLink {
	param (
		$Major,
		$Minor,
		$Patch,
		[switch]$Latest
	)
	if ($latest) {
		git -C winget fetch -t https://github.com/microsoft/winget-cli.git
		$tag = (git -C winget tag -l --sort=-creatordate)[1]
		"https://github.com/microsoft/winget-cli/releases/download/$tag/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
	}
	else {
		git -C winget fetch -t https://github.com/microsoft/winget-cli.git
		$tags = git -C winget tag -l --sort=-creatordate | Select-Object -Skip 1
		$tags = foreach ($tag in $tags) {
			$tag -match "v[\.-]?(?'major'\d+)\.(?'minor'\d+)\.(?'patch'\d+)(?'preview'-preview)?" | Out-Null
			@{
				Tag       = $tag
				Major     = $Matches.Major;
				Minor     = $Matches.Minor;
				Patch     = $Matches.Patch;
				IsPreview = if ($Matches.Preview) { $true } else { $false }
			}
		}
		$foo = $tags | Where-Object { $_.Major -eq $Major -and $_.Minor -eq $Minor -and $_.Patch -eq $Patch }
		if ($foo) {
			$tag = $foo.Tag
			"https://github.com/microsoft/winget-cli/releases/download/$tag/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
		}
		else {
			throw 'Non existing version'
		}
	}
}