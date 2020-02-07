function Publish-AWS-S3($dir, $bucket)
{
	'aws s3 sync ./' + $dir + '/dist s3://www.positron.iquipsys.net/' + $bucket | cmd
}

task Init {
    Invoke-Task -Task Clone -Workspace
    Invoke-Task -Task InstallDep -Workspace
}

task InstallDep {
    Install-NpmDependencies -Path .
}

# This works for Angularjs version of packages
task BuildAngularJs {
    # Proper sequence defined in $AngularJs variable it important!
    Invoke-Task -Task Build -Component $AngularJs
}

# This works for Angular version of packages
task BuildAngular {
    # Proper sequence defined in $Angular variable it important!
    $Angular | ForEach-Object {
		Write-Host "Building:" $_
		cd $_
		npm i
		npm run build:prod
		cd ..
	}
}

task Collect {
	if (Test-Path -Path ".\dist") {
		Remove-Item -LiteralPath "dist" -Recurse -Force
	}
	New-Item -itemtype "directory" -Path . -Name "dist" -Force
	$dist.keys | ForEach-Object {
		Copy-Item $global:dist[$_] -Destination "dist\${_}" -Recurse
	}
	New-Item .\dist\index.html
	Set-Content .\dist\index.html '<head>
	<meta http-equiv="refresh" content="1;URL=/home/index.html" />
	</head>'
}

task Build {
	Invoke-Task -Task BuildAngularJs
	Invoke-Task -Task BuildAngular
	Invoke-Task -Task Collect
}

task Clean {
    Invoke-Task -Task Clean -All
}

task Publish-S3 {
	$Name = (Get-Item -Path ".\").Name
	$FullName = (Get-Item -Path ".\").FullName
	If ($FullName -eq (Find-Workspace)) {
		$global:Buckets.keys | ForEach-Object -Process {
			Publish-AWS-S3 $_ $global:Buckets[$_]
		}
	}
	Elseif ($global:Buckets.ContainsKey($Name)) {
		Publish-AWS-S3 $Name $global:Buckets[$Name]
	}
}

