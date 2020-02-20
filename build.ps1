param(
    [switch] $CleanDist = $true,
    [switch] $RebuildShell = $false,
    [switch] $RebuildBuildImages = $false,
    [switch] $RebuildFailed = $false
)
# This variable for using different .dockerignore files for different Dockerfiles
$env:DOCKER_BUILDKIT=1
# Variables
. .\variables.ps1
$NgShell = 'iqs-libs-clientshell-angular'
$NgImageExists = docker images ${NgImage} -q
$NgxImageExists = docker images ${NgxImage} -q
$global:iqsBuildErrors = @()
$Sources = $Dists
if (Test-Path -Path ".\.iqsBuildErrors.json") {
    if ($RebuildFailed) {
        $CleanDist = $false
        $Sources = Get-Content ./.iqsBuildErrors.json | ConvertFrom-Json
    }
    Remove-Item ./.iqsBuildErrors.json -Force
}

if (($NgImageExists -and $RebuildBuildImages) -or (-not $NgImageExists)) {
    if ($NgImageExists) {
        docker rmi ${NgImage} --force
    }
    docker build -f ./docker/NgBuild.Dockerfile -t ${NgImage} .
}
if (($NgxImageExists -and $RebuildBuildImages) -or (-not $NgxImageExists)) {
    if ($NgxImageExists) {
        docker rmi ${NgxImage} --force
    }
    docker build -f ./docker/NgxBuild.Dockerfile -t ${NgxImage} .
}

function Ng-Build {
    param(
        [switch] $IsShell = $false,
        [string] $Dir,
        [Parameter(Mandatory=$false)][string] $Dist
    )
    Write-Host "Building ${Dir}" -ForegroundColor Black -BackgroundColor White
    cd $Dir
    # remove container if it exists
    if (docker ps -q -a -f name=$NgContainer) {
        docker rm $NgContainer --force
    }
    docker run -t -d --name $NgContainer $NgImage
    docker cp . ${NgContainer}:/usr/src/app/${Dir}
    if (-Not $IsShell) {
        docker exec ${NgContainer} /bin/sh -c "mkdir ${NgShell}"
        docker cp ../${NgShell}/dist ${NgContainer}:/usr/src/app/${NgShell}/dist
        docker cp ../iqs-libs-unsupported-angular ${NgContainer}:/usr/src/app
    }
    docker exec ${NgContainer} /bin/sh -c "cd ${Dir} && gulp build 2>&1 | tee /var/log/gulp.log"
    if (docker exec ${NgContainer} /bin/sh -c "grep -r 'error' /var/log/gulp.log") {
        Write-Host "Error during build: ${Dir}" -ForegroundColor White -BackgroundColor Red
        New-Item -itemtype directory "../.logs/$Dist" -Force
        docker cp ${NgContainer}:"/var/log/gulp.log" "../.logs/$Dist/"
        $global:iqsBuildErrors += @{ dir = $Dir; type = 'ng'; dist = $Dist }
    } else {
        if (-Not $IsShell) {
            docker cp ${NgContainer}:/usr/src/app/${Dir}/dist ../dist/${Dist}
        } else {
            if (Test-Path -Path ".\dist") {
                Remove-Item -LiteralPath "dist" -Recurse -Force
            }
            docker cp ${NgContainer}:/usr/src/app/${Dir}/dist .
        }
    }
    docker stop $NgContainer
    docker rm $NgContainer
    cd ..
}

function Ngx-Build {
    param(
        [string] $Dir,
        [string] $Dist
    )
    Write-Host "Building ${Dir}" -ForegroundColor Black -BackgroundColor White
    cd $Dir
    # remove container if it exists
    if (docker ps -q -a -f name=$NgxContainer) {
        docker rm $NgxContainer --force
    }
    docker run --memory 2048m -t -d --name $NgxContainer $NgxImage
    tar -cf "${Dir}.tar" --exclude=node_modules --exclude=.git --exclude=coverage --exclude=dist --exclude="${Dir}.tar" *
    docker cp ./$Dir.tar ${NgxContainer}:/usr/src/app
    Remove-Item -LiteralPath "${Dir}.tar"
    docker exec ${NgxContainer} /bin/sh -c "tar -xf ${Dir}.tar"
    docker exec ${NgxContainer} /bin/sh -c "npm i && npm run build:prod"
    if (docker exec ${NgxContainer} /bin/sh -c "cd /root/.npm/_logs && ls") {
        Write-Host "Error during build: ${Dir}" -ForegroundColor White -BackgroundColor Red
        New-Item -itemtype directory "../.logs/$Dist" -Force
        docker cp ${NgxContainer}:"/root/.npm/_logs/" "../.logs/$Dist/"
        $global:iqsBuildErrors += @{ dir = $Dir; type = 'ngx'; dist = $Dist }
    } else {
        docker cp ${NgxContainer}:/usr/src/app/dist/${Dir} ../dist/${Dist}
    }
    docker stop $NgxContainer
    docker rm $NgxContainer
    cd ..
}

if (!(Test-Path -Path "${NgShell}/dist") -or $RebuildShell) {
    Ng-Build -Dir:$NgShell -IsShell
}

if (Test-Path -Path ".\dist") {
    if ($CleanDist) {
        Remove-Item -LiteralPath "dist" -Recurse -Force
    }
}
New-Item -itemtype "directory" -Path . -Name "dist" -Force
if (!(Test-Path -Path ".\dist\index.html" -PathType Leaf)) {
    New-Item .\dist\index.html
    Set-Content .\dist\index.html '<head><meta http-equiv="refresh" content="1;URL=/home/index.html" /></head>'
}

$Sources | ForEach-Object {
    if ($_.type -eq 'ng') {
        Ng-Build -Dir:$_.dir -Dist:$_.dist
    } else {
        Ngx-Build -Dir:$_.dir -Dist:$_.dist
    }
}

if ($global:iqsBuildErrors.Count) {
    Write-Host "Some errors happened during build process. Run './build.ps1 -RebuildFailed' to rebuild only failed clients"
    ConvertTo-Json $global:iqsBuildErrors | Out-File -FilePath ./.iqsBuildErrors.json -Force
} else {
    if (docker images ${ClientsImage} -q) {
        docker rmi ${ClientsImage} --force
    }
    docker build --no-cache -f ./docker/Nginx.Dockerfile -t ${ClientsImage} .
}
