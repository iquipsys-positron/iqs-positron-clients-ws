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
task Build {
    # Proper sequence defined in $All variable it important!
    Invoke-Task -Task Build -Component $AngularJs
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

