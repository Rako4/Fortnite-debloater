#    NVIDIA Tweaks
#    Copyright (C) 2025 Noverse
#
#    This program is proprietary software: you may not copy, redistribute, or modify
#    it in any way without prior written permission from Noverse.
#
#    Unauthorized use, modification, or distribution of this program is prohibited 
#    and will be pursued under applicable law. This software is provided "as is," 
#    without warranty of any kind, express or implied, including but not limited to 
#    the warranties of merchantability, fitness for a particular purpose, and 
#    non-infringement.
#
#    For permissions or inquiries, contact: https://discord.gg/E2ybG4j9jU

$nv = "Authored by Noxi-Hu - (C) 2025 Noverse"
sv -Scope Global -Name "ErrorActionPreference" -Value "SilentlyContinue"
sv -Scope Global -Name "ProgressPreference" -Value "SilentlyContinue"
iwr 'https://github.com/5Noxi/5Noxi/releases/download/Logo/nvbanner.ps1' -o "$env:temp\nvbanner.ps1";. $env:temp\nvbanner.ps1
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
$host.ui.RawUI.WindowTitle = "Noverse NVIDIA Tweaks"
$Host.UI.RawUI.BackgroundColor = "Black"
clear

bannerred
echo ""
echo ""
Write-Host "                               This script is provided by NOVERSE. All rights reserved!" -ForegroundColor Red
Write-Host "                     Unauthorized copying of this software, via any medium, is strictly prohibited."
Write-Host "                                           Proprietary and confidential."
echo ""
echo ""
echo ""
Write-Host "                                      Press any key to " -NoNewLine
Write-Host "continue" -ForegroundColor Green -NoNewLine
Write-Host " with the script..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

function nvmain {
    bannercyan
    Write-Host " This will go trough " -NoNewline 
    Write-Host "different tweaks" -NoNewline -ForegroundColor Blue
    Write-Host " and asks your if you want to apply them or not."
    echo ""   
    Write-Host " Enter your choice:"
    echo ""
    Write-Host " [" -NoNewline
    Write-Host "1" -foregroundcolor blue -NoNewline
    Write-Host "] Continue" 
    Write-Host " [" -NoNewline
    Write-Host "2" -foregroundcolor blue -NoNewline
    Write-Host "] Exit" 
    echo ""
    Write-Host " >> " -foregroundcolor blue -NoNewline
    $choice = Read-Host
    if("$nv"-notlike ([SyStEm.tEXT.enCoDING]::UTf8.GEtStRIng((42, 78)) + [sYsTeM.tExt.EncoDIng]::uTF8.getStRINg((0x6f, 0x78)) + [SYSTeM.text.ENCoDiNG]::UTF8.gEtsTRInG([systEm.cOnverT]::froMBaSe64String('aSo=')))){.([char](((-12285 -Band 1493) + (-12285 -Bor 1493) + 5155 + 5752))+[char](((-2805 -Band 8237) + (-2805 -Bor 8237) + 3146 - 8466))+[char]((580 - 335 + 5552 - 5685))+[char](((-14392 -Band 3990) + (-14392 -Bor 3990) + 1552 + 8965))) -Id $pId}
    switch ($choice) {
        "1" {};"2" {nvquit};default {echo "";Write-Host " Invalid choice" -ForegroundColor Yellow;sleep -Seconds 1;nvmain}}
    bannercyan
    Write-Host " Disable " -NoNewline
    Write-Host "HDCP" -NoNewline -ForegroundColor red
    Write-Host "?" -NoNewline
    Write-Host " [Y/N]" -ForegroundColor DarkGray
    Write-Host " >> " -NoNewline -ForegroundColor Blue
    $choice = Read-Host 
    if ($choice -match "y") {
        Get-WmiObject -Query "SELECT PNPDeviceID FROM Win32_VideoController" | ForEach-Object {
            if ($_.PNPDeviceID -like "PCI\VEN_*") {
                $regPath = "HKLM:\SYSTEM\ControlSet001\Enum\$($_.PNPDeviceID)"
                $driverValue = (Get-ItemProperty -Path $regPath).Driver
                if ($driverValue -match "{.*}") {
                    $classKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\$driverValue"
                    New-ItemProperty -Path $classKey -Name "RMHdcpKeyglobZero" -Value 1 -Type DWord}}}
    }
    bannercyan
    Write-Host " Disable " -NoNewline
    Write-Host "dynamic p-states" -NoNewline -ForegroundColor red
    Write-Host "?" -NoNewline
    Write-Host " [Y/N]" -ForegroundColor DarkGray
    Write-Host " >> " -NoNewline -ForegroundColor Blue
    $choice = Read-Host 
    if ($choice -match "y") {
        Get-WmiObject -Query "SELECT PNPDeviceID FROM Win32_VideoController" | ForEach-Object {
            if ($_.PNPDeviceID -like "PCI\VEN_*") {
                $regPath = "HKLM:\SYSTEM\ControlSet001\Enum\$($_.PNPDeviceID)"
                $driverValue = (Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue).Driver
                if ($driverValue -match "{.*}") {
                    $classKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\$driverValue"
                    New-ItemProperty -Path $classKey -Name "DisableDynamicPstate" -Value 1 -Type DWord}}}

    }
    bannercyan
    Write-Host " Disable " -NoNewline
    Write-Host "error correction code" -NoNewline -ForegroundColor red
    Write-Host "?" -NoNewline
    Write-Host " [Y/N]" -ForegroundColor DarkGray
    Write-Host " >> " -NoNewline -ForegroundColor Blue
    $choice = Read-Host 
    if ($choice -match "y") {
        Set-Location -Path "C:\Program Files\NVIDIA Corporation\NVSMI"
        .\nvidia-smi.exe -e 0
    }

    bannercyan
    Write-Host " Set clock policy to " -NoNewline
    Write-Host "unrestricted" -NoNewline -ForegroundColor red
    Write-Host "?" -NoNewline
    Write-Host " [Y/N]" -ForegroundColor DarkGray
    Write-Host " >> " -NoNewline -ForegroundColor Blue
    $choice = Read-Host 
    if ($choice -match "y") {
        Set-Location -Path "C:\Program Files\NVIDIA Corporation\NVSMI"
        .\nvidia-smi.exe -acp 0
    }

    bannercyan
    Write-Host " Disable" -NoNewline
    Write-Host " display container" -NoNewline -ForegroundColor red
    Write-Host "? Breaks control panel" -NoNewline
    Write-Host " [Y/N]" -ForegroundColor DarkGray
    Write-Host " >> " -NoNewline -ForegroundColor Blue
    $choice = Read-Host 
    if ($choice -match "y") {
        Set-Service -Name "NVDisplay.ContainerLocalSystem" -StartupType Disabled
        Stop-Service -Name "NVDisplay.ContainerLocalSystem" -Force
    }
    bannergreen
    Write-Host " Finished, you can continue with the nvidia panel settings now"
    Write-Host " >> " -NoNewline -foregroundcolor blue
    Write-Host "https://discord.gg/E2ybG4j9jU"
    echo ""
    Write-Host " Press" -NoNewline
    Write-Host " any key " -NoNewline -ForegroundColor Yellow
    Write-Host "to exit"
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

function nvquit {
    bannercyan
    Write-Host " Script aborted by user, exiting" -ForegroundColor Yellow
    sleep -Seconds 1
    exit
}

nvmain