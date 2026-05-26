# add-gitkeeps.ps1
# Получаем путь к родительской папке относительно расположения скрипта
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# Получаем все папки, кроме корневой
$dirs = Get-ChildItem -Recurse -Directory | Where-Object { $_.FullName -ne $root.Path }

foreach ($dir in $dirs) {
	$gitkeepPath = Join-Path $dir.FullName ".gitkeep"
	if (-not (Test-Path $gitkeepPath)) {
		New-Item -Path $gitkeepPath -ItemType File | Out-Null
		Write-Host "Добавлен .gitkeep в: $($dir.FullName)"
	}
}
