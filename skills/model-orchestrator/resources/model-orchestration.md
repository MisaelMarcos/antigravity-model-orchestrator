# Automatic Model Orchestration & Project Mapping (Quality-First Planner-Executor)

Act as the **Lead Architect & Orchestrator** when running on a reasoning/frontier model (e.g., Argon, Claude Opus). Preserve the primary conversation context and minimize expensive token consumption by delegating context-heavy work exclusively to **`Model: "flash"`** subagents via `invoke_subagent` (never use `Model: "pro"`), while maintaining 100% architectural and code review quality.

---

## 1. Automatic Project Architecture Map (`AGENTS.md` Bootstrap in All Projects)

Every project workspace MUST have a concise (`30–60 lines`) `AGENTS.md` at its root acting as an instant architectural index so neither the Primary Model nor subagents waste tokens rediscovering the codebase structure.

- **Check on First Code Task:** When working in any workspace, check if `<workspace_root>/AGENTS.md` exists.
- **Auto-Create via Flash:** If `AGENTS.md` does not exist, delegate to a subagent (`TypeName: "self"`, `Model: "flash"`) to scan the repository structure and create `<workspace_root>/AGENTS.md` containing:
  1. **Stack & Architecture Overview** (1–3 lines).
  2. **Key Directories & Core Files** (exact relative paths for routes/controllers, database/repositories, services/integrations, frontend pages/components, types/schemas).
  3. **Conventions & Patterns** (auth, DB access, state management, styling).
  4. **Run / Build / Test Commands**.
- **Keep Updated:** Whenever a major new module, table, or architectural pattern is added, instruct the execution subagent to update `AGENTS.md`.

---

## 2. Decision Tree (Evaluate on Every Request)

### A. Execute Directly in Primary Model (Do NOT spawn a subagent)
- Conceptual questions, architectural advice, or explanations.
- Quick, localized edits (modifying 1–2 functions in a known file where the target line range is already known).
- **Surgical Reads:** The Primary Model may read specific line ranges (`StartLine` / `EndLine`, ≤120 lines) to verify critical logic, but MUST NOT browse multiple files or read huge full files to search for code.

### B. Routine / Well-Defined Multi-File Tasks (1-Step Delegation to `Model: "flash"`)
- **When:** The pattern already exists in the codebase (e.g., adding a standard field, fixing types/lints across files, running tests and fixing broken imports, mechanical refactors).
- **How:** Spawn `invoke_subagent` (`TypeName: "self"`, `Model: "flash"`) with clear acceptance criteria to research, implement, test, and return the summary + key diffs in a single pass.

### C. Complex / Architectural Tasks (2-Step Workflow: Flash Research → Argon/Opus Plan → Flash Execute)
- **When:** New business logic, database schema design, complex bug investigation, or cross-stack features.
- **Step 1 — Targeted Research (`TypeName: "research"`, `Model: "flash"`):** Instruct the subagent to locate all relevant files and return **exact file paths, line numbers, function signatures, SQL schemas, and TypeScript interfaces** (no vague summaries).
- **Step 2 — Architecture & Specification (Primary Model - Argon/Opus):** Design the exact technical solution (files to edit, exact logic, edge cases). Perform surgical line reads (`StartLine`/`EndLine`) if needed to confirm subtle details.
- **Step 3 — Execution & Testing (`TypeName: "self"`, `Model: "flash"`):** Pass the unambiguous specification to the `flash` subagent to apply edits and run verification commands/tests.

---

## 3. Quality-Preserving Subagent Return Contract (Mandatory Code Review)

To avoid context bloat while ensuring the Primary Model performs a **real code review** (preventing "telephone game" quality loss):
- Instruct every execution subagent (`Model: "flash"`) to return a **concise report (≤40 lines)** containing:
  1. **Modified Files & Line Ranges** (`path/to/file:L10-L45`).
  2. **Compact Diff / Key Code Snippets** of the core logic changed (excluding noisy terminal logs or unchanged boilerplate).
  3. **Verification Status** (build/test command run and PASS/FAIL result).
- **Primary Model Review:** Always inspect the returned diff/snippets (or run a targeted `git diff` / surgical `read_file` on critical sections) to verify correctness before presenting the final answer to the user.
