# ==============================================================================
# Model Orchestrator Installer for Windows PowerShell
# Installs Antigravity Global Rule & Skill for Model Orchestration
# ==============================================================================

[CmdletBinding()]
param(
    [string]$RepoUrl = "https://raw.githubusercontent.com/MisaelMarcos/antigravity-model-orchestrator/main"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   Antigravity Model Orchestrator - Installer (Windows)   " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

$geminiHome = "$env:USERPROFILE\.gemini"
$configDir = "$geminiHome\config"
$rulesDir = "$configDir\rules"
$skillsDir = "$configDir\skills\model-orchestrator"
$skillResDir = "$skillsDir\resources"
$geminiMd = "$geminiHome\GEMINI.md"

# 1. Create Directories
$dirsToCreate = @($rulesDir, $skillResDir)
foreach ($dir in $dirsToCreate) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "[+] Created directory: $dir" -ForegroundColor Green
    }
}

$isLocal = $PSScriptRoot -and (Test-Path "$PSScriptRoot\rules\model-orchestration.md")

function Install-FileContent {
    param(
        [string]$RelativePath,
        [string]$DestinationPath
    )

    if ($isLocal) {
        $sourcePath = Join-Path $PSScriptRoot $RelativePath
        Copy-Item -Path $sourcePath -Destination $DestinationPath -Force
        Write-Host "[+] Installed (local): $DestinationPath" -ForegroundColor Green
    } else {
        $url = "$RepoUrl/$($RelativePath -replace '\\', '/')"
        try {
            Invoke-RestMethod -Uri $url -OutFile $DestinationPath
            Write-Host "[+] Installed (remote): $DestinationPath" -ForegroundColor Green
        } catch {
            Write-Error "Failed to download $url : $_"
        }
    }
}

# 2. Install Rule & Skill
Write-Host "`n[1/3] Installing Global Rule & Skill..." -ForegroundColor Yellow
Install-FileContent "rules\model-orchestration.md" "$rulesDir\model-orchestration.md"
Install-FileContent "skills\model-orchestrator\SKILL.md" "$skillsDir\SKILL.md"
Install-FileContent "skills\model-orchestrator\resources\model-orchestration.md" "$skillResDir\model-orchestration.md"

# 3. Configure ~/.gemini/GEMINI.md
Write-Host "`n[2/3] Updating ~/.gemini/GEMINI.md..." -ForegroundColor Yellow
$ruleContent = Get-Content -Raw "$skillResDir\model-orchestration.md"
if (-not (Test-Path $geminiMd)) {
    Set-Content -Path $geminiMd -Value $ruleContent -Encoding UTF8
    Write-Host "[+] Created $geminiMd with Model Orchestrator rules." -ForegroundColor Green
} else {
    $existing = Get-Content -Raw $geminiMd
    if ($existing -notmatch "Automatic Model Orchestration & Project Mapping") {
        Add-Content -Path $geminiMd -Value "`n`n$ruleContent" -Encoding UTF8
        Write-Host "[+] Appended Model Orchestrator rules to $geminiMd." -ForegroundColor Green
    } else {
        Write-Host "[*] Model Orchestration rules already present in $geminiMd." -ForegroundColor DarkGray
    }
}

# 4. Success summary
Write-Host "`n[3/3] Installation Complete!" -ForegroundColor Cyan
Write-Host @"
----------------------------------------------------------
[+] Global rule installed: ~/.gemini/config/rules/model-orchestration.md
[+] Skill installed:       ~/.gemini/config/skills/model-orchestrator/
[+] Instructions linked:   ~/.gemini/GEMINI.md

How to use:
  1. Open any project in Antigravity.
  2. Type '/model-orchestrator' or ask your agent to start coding.
  3. AGENTS.md will be automatically maintained and subagents will
     run on Gemini Flash, saving 80-90% of your frontier tokens!
----------------------------------------------------------
"@ -ForegroundColor White
