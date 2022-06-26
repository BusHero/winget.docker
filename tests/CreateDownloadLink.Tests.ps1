BeforeAll {
	. $PSScriptRoot/../scripts/CreateDownloadLink.ps1
}

Describe 'Test the generation of downloadable links' {
	It 'Download preview version' -ForEach @(
		@{ Major = 1; Minor = 3; Patch = 1661; Url = 'https://github.com/microsoft/winget-cli/releases/download/v.1.3.1661-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 3; Patch = 1391; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1391-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 2; Patch = 3411; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.2.3411-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Minor = 4; Patch = 11391; Url = 'https://github.com/microsoft/winget-cli/releases/download/v-0.4.11391-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Minor = 1; Patch = 4331; Url = 'https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 3; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 2; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 1; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.1.12701/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 0; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.0.12576/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Minor = 4; Url = 'https://github.com/microsoft/winget-cli/releases/download/v-0.4.11391-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Minor = 3; Url = 'https://github.com/microsoft/winget-cli/releases/download/v-0.3.11201-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Minor = 2; Url = 'https://github.com/microsoft/winget-cli/releases/download/v-0.2.10971-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Minor = 1; Url = 'https://github.com/microsoft/winget-cli/releases/download/v0.1.42241-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 0; Url = 'https://github.com/microsoft/winget-cli/releases/download/v-0.4.11391-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
	) {
		Get-DownloadLink -Major $Major -Minor $Minor -Patch $Patch -Preview | Should -Be $Url
	}

	It 'Download existing tag' -ForEach @(
		@{ Major = 1; Minor = 3; Patch = 1681; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 3; Patch = 1611; Url = 'https://github.com/microsoft/winget-cli/releases/download/v.1.3.1611/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 2; Patch = 10271; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 1; Patch = 12701; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.1.12701/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 0; Patch = 12576; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.0.12576/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 3; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 2; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 1; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.1.12701/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Minor = 0; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.0.12576/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
		@{ Major = 1; Url = 'https://github.com/microsoft/winget-cli/releases/download/v1.3.1681/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' }
	) {
		Get-DownloadLink -Major $Major -Minor $Minor -Patch $Patch | Should -Be $Url
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
}