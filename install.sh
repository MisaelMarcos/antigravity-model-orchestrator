#!/usr/bin/env bash
# ==============================================================================
# Model Orchestrator Installer for macOS / Linux
# Installs Antigravity Global Rule & Skill for Model Orchestration
# ==============================================================================

set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/MisaelMarcos/antigravity-model-orchestrator/main"
GEMINI_HOME="$HOME/.gemini"
CONFIG_DIR="$GEMINI_HOME/config"
RULES_DIR="$CONFIG_DIR/rules"
SKILLS_DIR="$CONFIG_DIR/skills/model-orchestrator"
SKILL_RES_DIR="$SKILLS_DIR/resources"
GEMINI_MD="$GEMINI_HOME/GEMINI.md"

echo ""
echo -e "\033[1;36m==========================================================\033[0m"
echo -e "\033[1;36m   Antigravity Model Orchestrator - Installer (Unix)      \033[0m"
echo -e "\033[1;36m==========================================================\033[0m"
echo ""

# Determine if running locally from cloned repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
IS_LOCAL=0
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/rules/model-orchestration.md" ]; then
    IS_LOCAL=1
fi

# 1. Create directories
mkdir -p "$RULES_DIR" "$SKILL_RES_DIR"
echo -e "\033[0;32m[+] Configured directories in $CONFIG_DIR\033[0m"

install_file() {
    local rel_path="$1"
    local dest_path="$2"

    if [ "$IS_LOCAL" -eq 1 ]; then
        cp "$SCRIPT_DIR/$rel_path" "$dest_path"
        echo -e "\033[0;32m[+] Installed (local): $dest_path\033[0m"
    else
        local url="$REPO_URL/$rel_path"
        curl -fsSL "$url" -o "$dest_path"
        echo -e "\033[0;32m[+] Installed (remote): $dest_path\033[0m"
    fi
}

# 2. Install Rule & Skill
echo -e "\n\033[1;33m[1/3] Installing Global Rule & Skill...\033[0m"
install_file "rules/model-orchestration.md" "$RULES_DIR/model-orchestration.md"
install_file "skills/model-orchestrator/SKILL.md" "$SKILLS_DIR/SKILL.md"
install_file "skills/model-orchestrator/resources/model-orchestration.md" "$SKILL_RES_DIR/model-orchestration.md"

# 3. Configure ~/.gemini/GEMINI.md
echo -e "\n\033[1;33m[2/3] Updating ~/.gemini/GEMINI.md...\033[0m"
if [ ! -f "$GEMINI_MD" ]; then
    cat "$SKILL_RES_DIR/model-orchestration.md" > "$GEMINI_MD"
    echo -e "\033[0;32m[+] Created $GEMINI_MD with Model Orchestrator rules.\033[0m"
else
    if ! grep -q "Automatic Model Orchestration & Project Mapping" "$GEMINI_MD"; then
        echo -e "\n" >> "$GEMINI_MD"
        cat "$SKILL_RES_DIR/model-orchestration.md" >> "$GEMINI_MD"
        echo -e "\033[0;32m[+] Appended Model Orchestrator rules to $GEMINI_MD.\033[0m"
    else
        echo -e "\033[0;90m[*] Model Orchestration rules already present in $GEMINI_MD.\033[0m"
    fi
fi

# 4. Success summary
echo -e "\n\033[1;36m[3/3] Installation Complete!\033[0m"
cat << 'EOF'
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
EOF
