$test = if (Get-Command winget1 -ErrorAction Ignore) { $true } else { $false }
if ($test) { exit 0 } else { exit 1 }

