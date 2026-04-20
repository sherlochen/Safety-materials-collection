param(
    [string]$WorkspacePath = "F:\Cursor project",
    [string]$TargetFolder = "safety_knowledge_pack"
)

$ErrorActionPreference = "Stop"

function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Get-AllFiles {
    param([string]$RootPath)
    if (-not (Test-Path -LiteralPath $RootPath)) {
        return @()
    }
    return Get-ChildItem -LiteralPath $RootPath -Recurse -File | Sort-Object FullName
}

function Get-UrlMatches {
    param([string]$Content)
    if ([string]::IsNullOrWhiteSpace($Content)) {
        return @()
    }
    $pattern = "https?://[^\s\)\]`"'>]+"
    $matches = [regex]::Matches($Content, $pattern)
    return $matches.Value | Sort-Object -Unique
}

$targetPath = Join-Path $WorkspacePath $TargetFolder
$autoDir = Join-Path $targetPath "_auto"
$reportsDir = Join-Path $autoDir "reports"
$archiveDir = Join-Path $autoDir "archive"
$statePath = Join-Path $autoDir "maintenance_state.json"
$manifestPath = Join-Path $autoDir "manifest.csv"
$reportPath = Join-Path $autoDir "weekly_update_report.md"
$indexPath = Join-Path $autoDir "folder_index.md"
$desktopReminderPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "SafetyPack_Weekly_Reminder.txt"

Ensure-Directory -Path $targetPath
Ensure-Directory -Path $autoDir
Ensure-Directory -Path $reportsDir
Ensure-Directory -Path $archiveDir

# 1) 固定目录自愈（自动整理基础结构）
$mustHaveDirs = @(
    "fusa",
    "sotif",
    "ai_safety",
    "ads_regulation",
    "data_loop_sotif_scenario_library"
)
foreach ($dir in $mustHaveDirs) {
    Ensure-Directory -Path (Join-Path $targetPath $dir)
}

# 2) 生成文件清单（用于快速审计）
$files = Get-AllFiles -RootPath $targetPath | Where-Object { $_.FullName -notlike "*\_auto\*" }
$manifestRows = foreach ($f in $files) {
    [PSCustomObject]@{
        relative_path = $f.FullName.Replace($targetPath + "\", "")
        size_bytes    = $f.Length
        last_write    = $f.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
    }
}
$manifestRows | Export-Csv -Path $manifestPath -NoTypeInformation -Encoding UTF8

# 3) 对 Markdown 做链接可达性抽检（自动更新质量检查）
$mdFiles = $files | Where-Object { $_.Extension -eq ".md" }
$allUrls = New-Object System.Collections.Generic.HashSet[string]
foreach ($md in $mdFiles) {
    $content = Get-Content -LiteralPath $md.FullName -Raw -Encoding UTF8
    $urls = Get-UrlMatches -Content $content
    foreach ($u in $urls) { [void]$allUrls.Add($u) }
}

$urlCheckRows = @()
foreach ($url in ($allUrls | Sort-Object)) {
    $ok = $false
    $statusText = ""
    try {
        $resp = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 15 -ErrorAction Stop
        $ok = $true
        $statusText = [string]$resp.StatusCode
    } catch {
        $statusText = $_.Exception.Message
    }

    $urlCheckRows += [PSCustomObject]@{
        url    = $url
        ok     = $ok
        status = $statusText
    }
}

$urlOkCount = ($urlCheckRows | Where-Object { $_.ok }).Count
$urlFailRows = $urlCheckRows | Where-Object { -not $_.ok }

# 4) 读取上次状态并生成变更统计
$previousState = $null
if (Test-Path -LiteralPath $statePath) {
    try {
        $previousState = Get-Content -LiteralPath $statePath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        $previousState = $null
    }
}

$currentMap = @{}
foreach ($row in $manifestRows) {
    $currentMap[$row.relative_path] = $row.last_write
}

$prevMap = @{}
if ($previousState -and $previousState.file_state) {
    foreach ($item in $previousState.file_state.PSObject.Properties) {
        $prevMap[$item.Name] = [string]$item.Value
    }
}

$added = @($currentMap.Keys | Where-Object { -not $prevMap.ContainsKey($_) } | Sort-Object)
$removed = @($prevMap.Keys | Where-Object { -not $currentMap.ContainsKey($_) } | Sort-Object)
$changed = @(
    $currentMap.Keys |
    Where-Object { $prevMap.ContainsKey($_) -and $prevMap[$_] -ne $currentMap[$_] } |
    Sort-Object
)

# 5) 生成目录索引（自动整理视图）
$indexLines = @()
$indexLines += "# Safety Pack Folder Index"
$indexLines += ""
$indexLines += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$indexLines += ""
foreach ($f in $files | Sort-Object FullName) {
    $rel = $f.FullName.Replace($targetPath + "\", "")
    $indexLines += "- $rel"
}
$indexLines | Set-Content -LiteralPath $indexPath -Encoding UTF8

# 6) 生成周报
$runStamp = Get-Date -Format "yyyy-MM-dd_HHmmss"
$datedReportPath = Join-Path $reportsDir ("weekly_update_report_{0}.md" -f $runStamp)
$reportLines = @()
$reportLines += "# Weekly Maintenance Report"
$reportLines += ""
$reportLines += "- Run time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$reportLines += "- Target: $targetPath"
$reportLines += "- Total files: $($files.Count)"
$reportLines += "- Markdown files: $($mdFiles.Count)"
$reportLines += "- URL checks: $($urlCheckRows.Count) total / $urlOkCount ok / $($urlFailRows.Count) failed"
$reportLines += ""
$reportLines += "## File Changes Since Last Run"
$reportLines += ""
$reportLines += "- Added: $($added.Count)"
$reportLines += "- Changed: $($changed.Count)"
$reportLines += "- Removed: $($removed.Count)"
$reportLines += ""

if ($added.Count -gt 0) {
    $reportLines += "### Added"
    foreach ($x in $added) { $reportLines += "- $x" }
    $reportLines += ""
}
if ($changed.Count -gt 0) {
    $reportLines += "### Changed"
    foreach ($x in $changed) { $reportLines += "- $x" }
    $reportLines += ""
}
if ($removed.Count -gt 0) {
    $reportLines += "### Removed"
    foreach ($x in $removed) { $reportLines += "- $x" }
    $reportLines += ""
}

$reportLines += "## URL Check Failures"
$reportLines += ""
if ($urlFailRows.Count -eq 0) {
    $reportLines += "- None"
} else {
    foreach ($row in $urlFailRows) {
        $reportLines += "- $($row.url)"
    }
}
$reportLines | Set-Content -LiteralPath $datedReportPath -Encoding UTF8
$reportLines | Set-Content -LiteralPath $reportPath -Encoding UTF8

# 6.1) 周报保留策略：只保留最近20周，旧报归档
$allReports = Get-ChildItem -LiteralPath $reportsDir -Filter "weekly_update_report_*.md" -File |
    Sort-Object LastWriteTime -Descending
$keepCount = 20
if ($allReports.Count -gt $keepCount) {
    $toArchive = $allReports | Select-Object -Skip $keepCount
    foreach ($item in $toArchive) {
        $dest = Join-Path $archiveDir $item.Name
        Move-Item -LiteralPath $item.FullName -Destination $dest -Force
    }
}

# 7) 写入新状态
$stateObj = [PSCustomObject]@{
    last_run   = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    file_state = [PSCustomObject]$currentMap
}
$stateObj | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $statePath -Encoding UTF8

# 8) 任务完成提醒：桌面提醒 + 弹窗通知
$reminderLines = @()
$reminderLines += "Safety Pack weekly maintenance completed."
$reminderLines += "Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$reminderLines += "Latest report: $reportPath"
$reminderLines += "Snapshot report: $datedReportPath"
$reminderLines += "Index: $indexPath"
$reminderLines | Set-Content -LiteralPath $desktopReminderPath -Encoding UTF8

try {
    $wshell = New-Object -ComObject WScript.Shell
    [void]$wshell.Popup(
        "Safety Pack weekly update completed.`nLatest report: $reportPath",
        8,
        "Safety Pack Maintenance",
        64
    )
} catch {
    # Notification is best-effort; script should still succeed.
}

Write-Output "Maintenance completed."
Write-Output "Report: $reportPath"
Write-Output "Snapshot report: $datedReportPath"
Write-Output "Index : $indexPath"
Write-Output "Manifest: $manifestPath"
Write-Output "Desktop reminder: $desktopReminderPath"
