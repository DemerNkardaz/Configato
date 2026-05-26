# Получаем путь к родительской папке относительно расположения скрипта
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# Получаем все .gitkeep файлы рекурсивно
$gitkeeps = Get-ChildItem -Recurse -Filter ".gitkeep"

foreach ($file in $gitkeeps) {
	Remove-Item -Path $file.FullName
	Write-Host "Удален .gitkeep из: $($file.Directory.FullName)"
}
