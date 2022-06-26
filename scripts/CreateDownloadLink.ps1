$DonwloadableLinkTemplate = 'https://github.com/microsoft/winget-cli/releases/download/{0}/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' 

function Get-Tags {
	param(
		$Major,
		$Minor,
		$Patch,
		$AllowPreview = $false
	)
	$TempGitRepo = "${env:TEMP}\winget"
	New-Item -Path $TempGitRepo -ItemType Directory -Force | Out-Null
	git init $TempGitRepo --bare --quiet
	git -C $TempGitRepo fetch -q --tags 'https://github.com/microsoft/winget-cli.git'
	$tags = git -C $TempGitRepo tag --list --sort=-refname --sort=-creatordate

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
	if ($null -ne $Major) {
		$tags = @($tags | Where-Object { $_.Major -eq $Major }) 
	}
	if ($null -ne $Minor) {
		$tags = @($tags | Where-Object { $_.Minor -eq $Minor }) 
	}
	if ($null -ne $Patch) {
		$tags = @($tags | Where-Object { $_.Patch -eq $Patch }) 
	}
	if ($false -eq $AllowPreview) {
		$tags = @($tags | Where-Object { $false -eq $_.IsPreview }) 
	}
	return $tags
}

function Get-DownloadLink {
	param (
		$Major,
		$Minor,
		$Patch,
		[switch]$Latest,
		[switch]$Preview
	)
	if ($latest) {
		$tag = @(Get-Tags)[0]
		return $DonwloadableLinkTemplate -f $tag.Tag
	}

	$tags = @(Get-Tags -Major $Major -Minor $Minor -Patch $Patch -AllowPreview $Preview.IsPresent)
	if ($null -eq $tags -or $tags.Count -eq 0) {
		throw "Tag ${Major}.${Minor}.${Patch} doesn't exist"
	}
	
	$tag = $tags[0]
	if ($tag) {
		return $DonwloadableLinkTemplate -f $tag.Tag
	}
}