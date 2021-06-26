#!/usr/bin/env pwsh

$PACKAGES = [ordered]@{
    "com.google.android.gsf.login" = "Google Account Manager";
    "com.google.android.gsf" = "Google Services Framework";
    "com.google.android.gms" = "Google Play Services";
    "com.android.vending" = "Google Play Store";
}

function check_adb {
    # check if adb is installed
    if ((Get-Command "adb" -ErrorAction SilentlyContinue) -eq $null) { 
        Throw "ADB is not installed please install it and try running it again."
    }
}

check_adb

Write-Output "This will install the following packages:"
$PACKAGES.Keys | % {
    Write-Output "  - $($PACKAGES.Item($_)) ($_)"
}
Write-Output "`nPress CTRL+C to ABORT or"
pause
Write-Output ""

$PACKAGES.Keys | % {
    $pkg = $_

    if (Test-Path "${pkg}_*.apk"){
        Write-Output "Installing ${pkg}..."
        & adb install ${pkg}_*.apk
        if ($LASTEXITCODE -ne 0){
            Throw "ERROR!: Something went wrong. Exiting."
        }
    } else {
        Throw "ERROR!: ${pkg}_*.apk was not found. Exiting."
    }
}
