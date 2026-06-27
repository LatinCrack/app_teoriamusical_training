# Script de PowerShell para ejecutar Flutter en un entorno aislado y local
$ProjectRoot = $PSScriptRoot
$SdkBinPath = "$ProjectRoot\flutter_sdk\bin"
$LocalPubCache = "$ProjectRoot\.pub_cache"

# Crear directorio de caché local si no existe
if (!(Test-Path -Path $LocalPubCache)) {
    New-Item -ItemType Directory -Path $LocalPubCache | Out-Null
}

# Configurar variables de entorno locales de la sesión de PowerShell
$env:PUB_CACHE = $LocalPubCache
$env:PATH = "$SdkBinPath;" + $env:PATH

# Auto-detectar si el comando debe correrse dentro de la carpeta de la aplicación
$OriginalLocation = Get-Location
$AppDir = "$ProjectRoot\music_theory_app"
$RunningInRoot = ($OriginalLocation.Path -eq $ProjectRoot)

if ($RunningInRoot -and (Test-Path -Path "$AppDir\pubspec.yaml")) {
    Set-Location -Path $AppDir
}

Write-Host "--- Entorno Aislado de Flutter Activo ---" -ForegroundColor Green
Write-Host "PUB_CACHE: $env:PUB_CACHE" -ForegroundColor Yellow
Write-Host "Flutter SDK en: $SdkBinPath" -ForegroundColor Yellow
Write-Host "Directorio de Ejecución: $((Get-Location).Path)" -ForegroundColor Yellow
Write-Host "Ejecutando comando: flutter $args" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Green

# Ejecutar el comando pasándole los argumentos recibidos
& "$SdkBinPath\flutter.bat" $args

# Restaurar la ubicación original al terminar
if ($RunningInRoot) {
    Set-Location -Path $OriginalLocation
}
