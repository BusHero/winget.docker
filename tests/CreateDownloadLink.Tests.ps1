BeforeAll {
	. $PSScriptRoot/../scripts/CreateDownloadLink.ps1
}

Describe 'Test the generation of downloadable links' {
	It 'Download normal version' {
		$url = CreateDownloadLink -Major 1 -Minor 2 -Patch 10271 
		$url | Should -Be 'https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
	}

	It 'Download latest' {
		$url = CreateDownloadLink -Latest
		$url | Should -Be 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
	}

	It 'Fail non existing tag' {
		{ CreateDownloadLink -Major 1 -Minor 2 -Patch 1671 } | Should -Throw
	}
}