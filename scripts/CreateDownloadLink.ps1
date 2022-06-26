function Get-Tags {
	$TempGitRepo = "${env:TEMP}\winget"
	New-Item -Path $TempGitRepo -ItemType Directory -Force | Out-Null
	git init $TempGitRepo --bare --quiet
	git -C $TempGitRepo fetch -q --tags 'https://github.com/microsoft/winget-cli.git'
	git -C $TempGitRepo tag --list --sort=-refname --sort=-creatordate
}

function CreateDownloadLink {
	param (
		$Major,
		$Minor,
		$Patch,
		[switch]$Latest
	)
	if ($latest) {
		$tag = (Get-Tags)[0]
		"https://github.com/microsoft/winget-cli/releases/download/$tag/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
	}
	else {
		$tags = Get-Tags
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
			throw "Tag ${Major}.${Minor}.${Patch} doesn't exist"
		}
	}
}