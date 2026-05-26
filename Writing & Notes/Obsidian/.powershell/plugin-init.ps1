# install-plugins.ps1
$pluginsDir = ".obsidian\plugins"
$communityList = Invoke-RestMethod "https://raw.githubusercontent.com/obsidianmd/obsidian-releases/master/community-plugins.json"

function Try-Download($repo, $version, $file, $out) {
    foreach ($tag in @($version, "v$version", "release-$version")) {
        $url = "https://github.com/$repo/releases/download/$tag/$file"
        try {
            Invoke-WebRequest $url -OutFile $out -ErrorAction Stop
            return $true
        } catch {}
    }
    return $false
}

Get-ChildItem "$pluginsDir\*\manifest.json" | ForEach-Object {
    $pluginDir = $_.DirectoryName
    $pluginId  = Split-Path $pluginDir -Leaf
    $manifest  = $_ | Get-Content | ConvertFrom-Json

    if (Test-Path "$pluginDir\main.js") {
        Write-Host "⏭ $pluginId (уже есть)"
        return
    }

    $entry = $communityList | Where-Object { $_.id -eq $pluginId }
    if (-not $entry) {
        Write-Host "⚠ $pluginId — не в community list"
        return
    }

    $version = $manifest.version
    Write-Host "⬇ $pluginId @ $version..."

    $ok = Try-Download $entry.repo $version "main.js" "$pluginDir\main.js"
    if (-not $ok) { Write-Host "  ✗ не скачался" }
    Try-Download $entry.repo $version "styles.css" "$pluginDir\styles.css" | Out-Null
}

Write-Host "✅ Готово"
Read-Host -Prompt "Нажмите Enter для выхода"