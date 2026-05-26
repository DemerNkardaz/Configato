# Получаем путь к родительской папке относительно расположения скрипта
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# Получаем все папки, кроме корневой
$dirs = Get-ChildItem -Recurse -Directory | Where-Object { $_.FullName -ne $root }

foreach ($dir in $dirs) {
	# Проверяем, пуста ли папка (не считая .gitkeep если он уже есть)
	$items = Get-ChildItem -Path $dir.FullName -Force | Where-Object { $_.Name -ne ".gitkeep" }
	if ($items.Count -eq 0) {
		$gitkeepPath = Join-Path $dir.FullName ".gitkeep"
		if (-not (Test-Path $gitkeepPath)) {
			New-Item -Path $gitkeepPath -ItemType File | Out-Null
			Write-Host "Добавлен .gitkeep в пустую папку: $($dir.FullName)"
		}
	}
}
