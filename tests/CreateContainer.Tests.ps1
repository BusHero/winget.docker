Describe 'Create Container' -Skip {
	BeforeAll {
		& $PSScriptRoot\..\scripts\CreateContainer.ps1
	}
	
	It 'Create Container' -Skip {
		$expectedContent = Get-Content .\templates\Dockerfile.template
		$actualContent = Get-Content .\output\Dockerfile
		$actualContent | Should -Be $expectedContent
	}
}