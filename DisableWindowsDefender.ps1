# Verificar si el script corre como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Reiniciando script como Administrador..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# DefenderToggleMenu.ps1
# Script para activar o desactivar temporalmente Microsoft Defender (protección en tiempo real)

function Show-Menu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "   Microsoft Defender Toggle"
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "1. Desactivar protección en tiempo real"
    Write-Host "2. Activar protección en tiempo real"
    Write-Host "3. Salir"
    Write-Host "=============================="
}

do {
    Show-Menu
    $choice = Read-Host "Selecciona una opción (1-3)"

    switch ($choice) {
        "1" {
            Write-Host "Desactivando protección en tiempo real..." -ForegroundColor Yellow
            Set-MpPreference -DisableRealtimeMonitoring $true
            Write-Host "Defender está DESACTIVADO temporalmente." -ForegroundColor Red
            Pause
        }
        "2" {
            Write-Host "Activando protección en tiempo real..." -ForegroundColor Green
            Set-MpPreference -DisableRealtimeMonitoring $false
            Write-Host "Defender está ACTIVADO." -ForegroundColor Green
            Pause
        }
        "3" {
            Write-Host "Saliendo..." -ForegroundColor Cyan
        }
        default {
            Write-Host "Opción no válida, intenta de nuevo." -ForegroundColor Red
            Pause
        }
    }
} until ($choice -eq "3")
