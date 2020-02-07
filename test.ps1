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