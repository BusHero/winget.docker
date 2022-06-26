BeforeAll {
	. $PSScriptRoot/../scripts/CreateDownloadLink.ps1
}

Describe 'Test the generation of downloadable links' {
	It 'Download preview version' {
		$url = Get-DownloadLink -Major 1 -Minor 3 -Patch 1661 -Preview 
		$url | Should -Be 'https://github.com/microsoft/winget-cli/releases/download/v.1.3.1661-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
	}

	It 'Fail if the preview flag is not specified for the non preview version' {
		{ Get-DownloadLink -Major 1 -Minor 3 -Patch 1661 } | Should -Throw "Tag 1.3.1661 doesn't exist"
	}

	It 'Download latest' {
		$url = Get-DownloadLink -Latest
		$url | Should -Be 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
	}

	It 'Fail non existing tag' {
		{ Get-DownloadLink -Major 1 -Minor 2 -Patch 1671 } | Should -Throw "Tag 1.2.1671 doesn't exist" 
	}

	It 'Download existing tag' -ForEach @(
		@{ Major = 1; Minor = 3; Patch = 1681; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 3; Patch = 1611; Url = 'https://github.com/microsoft/winget-cli/releases/download/v.1.3.1611/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 2; Patch = 10271; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 1; Patch = 12701; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.1.12701/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 0; Patch = 12576; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.1.12576/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
	) {
		$url = Get-DownloadLink -Major $Major -Minor $Minor -Patch $Patch
		$url | Should -Be $url

	}
}