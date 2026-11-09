---
name: model-orchestrator
description: Configure automatic model orchestration (Argon/Opus as Lead Architect & Reviewer + Gemini Flash as Subagent Executor) and bootstrap/update the concise AGENTS.md project architecture map to save 80-90% of frontier tokens without quality loss.
---

# Model Orchestrator Skill

This skill enforces high-quality, token-efficient model orchestration for Antigravity:
1. **Lead Architect / Orchestrator**: The primary model (Argon/Opus) handles planning, architecture design, and final code reviews.
2. **Subagent Delegation**: Bulk research, multi-file edits, code generation, linting, and test execution are delegated to lightweight, high-speed **`Model: "flash"`** subagents.
3. **Automatic Project Mapping (`AGENTS.md`)**: Bootstraps and maintains a concise 30–60 line architecture index in any active workspace root.

## Instructions When Invoked (`/model-orchestrator`)

When the user runs `/model-orchestrator`, execute these three steps:

### Step 1: Ensure Global Rules are Active
1. Check if `~/.gemini/config/rules/model-orchestration.md` exists. If not, copy it from `./resources/model-orchestration.md` (adding frontmatter `trigger: always_on`).
2. Check `~/.gemini/GEMINI.md`. If the model orchestration rule is not referenced or present, ensure it is documented or referenced there.

### Step 2: Bootstrap or Refresh `<workspace_root>/AGENTS.md`
1. Check if the active workspace has an `AGENTS.md` at its root.
2. If `AGENTS.md` does not exist (or if the user requested a refresh / update):
   - Invoke a `Model: "flash"` subagent (`TypeName: "self"` or `TypeName: "research"`) to scan the project files, frameworks, build commands, and folder structure.
   - Subagent generates a concise 30–60 line `<workspace_root>/AGENTS.md` with:
     - **Stack & Architecture Overview** (1–3 lines).
     - **Key Directories & Core Files** (exact paths for routes, db/repositories, services, frontend, types).
     - **Conventions & Patterns** (auth, DB access, state, styling).
     - **Run / Build / Test Commands**.
   - Review and save `<workspace_root>/AGENTS.md`.

### Step 3: Verify & Report Status
1. Confirm that `AGENTS.md` is created/updated.
2. Report to the user:
   - Global model orchestration status (Enabled).
   - `AGENTS.md` status in the workspace (Indexed with line count).
   - Reminder: All heavy multi-file edits, tests, and scans will automatically route to fast Flash subagents while keeping the primary model clean and focused on architecture and code review.
