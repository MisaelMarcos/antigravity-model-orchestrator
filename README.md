# ⚡ Antigravity Model Orchestrator

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Antigravity](https://img.shields.io/badge/Platform-Google%20Antigravity-orange.svg)](https://antigravity.google)
[![Token Savings](https://img.shields.io/badge/Frontier%20Tokens%20Saved-80%25--90%25-brightgreen.svg)]()

> **Automatic Model Orchestration (Planner-Executor) & Instant Architecture Mapping (`AGENTS.md`) for Google Antigravity.**
>
> Economize de **80% a 90%** dos seus tokens caros de raciocínio (**Gemini 4 Argon** / **Claude Opus / Sonnet 5.5**) delegando varreduras, buscas e edições multi-arquivo para subagentes ultrarrápidos **Gemini 3.8 Flash** (`Model: "flash"`), mantendo 100% da qualidade arquitetural e revisão de código no modelo principal.

---

[🇧🇷 Português](#-versão-em-português) | [🇺🇸 English](#-english-version)

---

## 🇧🇷 Versão em Português

### 🎯 O Problema
Modelos de fronteira e raciocínio profundo (como **Gemini 4 Argon** ou **Claude Opus / Sonnet 5.5**) são brilhantes em arquitetura e planejamento. No entanto:
1. **Consumo massivo de contexto**: Fazer o modelo principal ler dezenas de arquivos, logs de compilação ou árvores de diretórios queima a janela de contexto muito rápido.
2. **Custo e Lentidão**: Cada iteração com dezenas de milhares de tokens no modelo principal custa caro e introduz latência perceptível.
3. **Perda de Foco**: Modelos de raciocínio se perdem em tarefas mecânicas (adicionar um campo repetitivo em 5 arquivos, rodar linter, consertar imports quebrados).

### 💡 A Solução: Padrão Arquiteto-Executor (Planner-Executor)
O **Antigravity Model Orchestrator** implementa automaticamente uma divisão clara de responsabilidades:
- **Modelo Principal (Lead Architect & Reviewer):** Atua como Arquiteto Líder (**Gemini 4 Argon** / **Claude Opus / Sonnet 5.5**). Planeja, desenha contratos técnicos, inspeciona diffs reais e conversa com o desenvolvedor.
- **Subagentes Flash (`Gemini 3.8 Flash`, `Model: "flash"`):** Executam o trabalho braçal em contextos isolados — pesquisas em arquivos, edições cirúrgicas, execução de testes no terminal e criação de logs.
- **Mapa Arquitetural Automático (`AGENTS.md`):** Garante que todo projeto tenha um arquivo `AGENTS.md` enxuto (30 a 60 linhas) na raiz, permitindo que qualquer subagente compreenda a stack imediatamente sem queimar tokens varrendo o disco repetidamente.
- **Consciência Temporal e de Versão (Guardrail Anti-Desatualização):** Impede que os modelos assumam sintaxes ou versões antigas de corte pré-treinamento, ancorando operações em 2026 e inspecionando versões reais instaladas (`package.json`, `requirements.txt`).

---

### 📊 Tabela Comparativa de Economia de Tokens

| Tipo de Tarefa | Abordagem Tradicional (Apenas Modelo Principal) | Com Model Orchestrator (Argon/Opus 5.5 + Gemini 3.8 Flash) | Economia de Tokens Nobres |
| :--- | :--- | :--- | :--- |
| **Pesquisa em Código / Diagnóstico** | Lê 8 a 15 arquivos no contexto primário (~45.000 tokens) | Flash pesquisa em sandbox isolada; reporta apenas caminhos e assinaturas (~800 tokens para o principal) | **~98%** |
| **Refatoração Multi-Arquivo** | Carrega todos os arquivos no contexto primário (~60.000 tokens) | Argon/Opus planeja a spec (1.500 tokens) → Flash executa e roda testes → Argon revisa diff (1.200 tokens) | **~85%** |
| **Criação de Features Novas** | 100.000+ tokens acumulados rapidamente com logs de terminal | Argon/Opus desenha a arquitetura → Flash subagente implementa → Argon valida diff cirúrgico | **~80% a 90%** |
| **Descoberta de Arquitetura de Projeto** | Mapeamento manual repetido a cada nova sessão (~10.000 tokens) | Leitura direta do `AGENTS.md` conciso pré-gerado (~500 tokens) | **~95%** |

---

### 🚀 Instalação em 1 Comando

#### Windows (PowerShell)
Abra o PowerShell e execute:
```powershell
irm https://raw.githubusercontent.com/MisaelMarcos/antigravity-model-orchestrator/main/install.ps1 | iex
```

#### macOS / Linux (Bash)
Abra o terminal e execute:
```bash
curl -fsSL https://raw.githubusercontent.com/MisaelMarcos/antigravity-model-orchestrator/main/install.sh | bash
```

#### Instalação Manual ou via Git
Se preferir clonar o repositório:
```bash
git clone https://github.com/MisaelMarcos/antigravity-model-orchestrator.git
cd antigravity-model-orchestrator

# Windows:
.\install.ps1

# macOS / Linux:
chmod +x install.sh && ./install.sh
```

---

### 🛠️ Como Funciona na Prática

1. **Ativação Automática**: Uma vez instalado, as regras globais (`~/.gemini/config/rules/model-orchestration.md` e `~/.gemini/GEMINI.md`) são ativadas em todas as sessões.
2. **Comando Slash `/model-orchestrator`**:
   - Digite `/model-orchestrator` em qualquer workspace do Antigravity.
   - O agente verifica a integridade das regras e gera o `AGENTS.md` (30–60 linhas) caso ainda não exista.
3. **Contrato de Retorno Rígido**:
   - Todo subagente Flash é obrigado a retornar um resumo compacto (≤40 linhas) com arquivos alterados, diffs essenciais e status dos testes (`PASS`/`FAIL`).
   - O modelo primário realiza **code review real** antes de apresentar a solução final, garantindo 0% de perda de qualidade.

---

## 🇺🇸 English Version

### 🎯 The Problem
Frontier reasoning models (**Gemini 4 Argon**, **Claude Opus / Sonnet 5.5**) excel at architectural decisions, deep logic, and complex planning. However:
1. **Context Bloat**: Reading dozens of files, build logs, and directory structures fills up precious context windows fast.
2. **High Latency & Costs**: Multi-turn frontier calls with large context introduce lag and burn through token budgets.
3. **Mechanical Distractions**: Using reasoning tokens for mechanical edits, linter formatting, or terminal testing is deeply inefficient.

### 💡 The Solution: Planner-Executor Pattern
**Antigravity Model Orchestrator** automates an optimal separation of concerns:
- **Primary Model (Lead Architect & Reviewer):** Stays high-level (**Gemini 4 Argon** / **Claude Opus / Sonnet 5.5**). Designs specifications, formulates steps, reviews compact diffs, and orchestrates.
- **Flash Subagents (`Gemini 3.8 Flash`, `Model: "flash"`):** Run isolated in the background to handle multi-file reads, targeted searches, code replacements, and build/test commands.
- **Automatic `AGENTS.md` Project Index:** Automatically bootstraps and maintains a concise (30–60 line) architecture index at the root of every workspace. Subagents and primary models immediately understand the codebase without blind file scans.
- **Temporal & Version Awareness (Anti-Staleness):** Enforces 2026 modern ecosystem context and mandates checking actual installed dependency versions rather than assuming legacy syntax.

---

### 📊 Token & Cost Efficiency Breakdown

| Task Type | Monolithic (Primary Model Only) | Model Orchestrator (Argon/Opus 5.5 + Gemini 3.8 Flash) | Frontier Token Savings |
| :--- | :--- | :--- | :--- |
| **Codebase Research & Search** | Dumps 8–15 full files into primary context (~45k tokens) | Flash searches in sandbox; returns exact file paths and signatures (~800 tokens to primary) | **~98%** |
| **Multi-File Refactoring** | Streams all touched files into main conversation (~60k tokens) | Primary designs spec (1.5k tokens) → Flash applies edits & tests → Primary reviews diff (1.2k tokens) | **~85%** |
| **Full-Stack Feature Work** | 100k+ tokens rapidly accumulated with build errors and terminal logs | Primary designs architecture → Flash subagent implements → Primary reviews concise diff | **~80% to 90%** |
| **Project Architecture Discovery** | Re-discovering directories and commands every session (~10k tokens) | Surgical read of concise 40-line `AGENTS.md` index (~500 tokens) | **~95%** |

---

### 🚀 One-Line Installation

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/MisaelMarcos/antigravity-model-orchestrator/main/install.ps1 | iex
```

#### macOS / Linux (Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/MisaelMarcos/antigravity-model-orchestrator/main/install.sh | bash
```

---

### 📁 Repository Structure

```text
antigravity-model-orchestrator/
├── plugin.json                                 # Antigravity Plugin manifest
├── rules/
│   ├── AGENTS.md                               # Plugin rule definition
│   └── model-orchestration.md                  # Global standalone rule (with trigger)
├── skills/
│   └── model-orchestrator/
│       ├── SKILL.md                            # Slash command / Skill definition
│       └── resources/
│           └── model-orchestration.md          # Packaged rule resource
├── install.ps1                                 # 1-click Windows installer
├── install.sh                                  # 1-click Unix/macOS installer
├── README.md                                   # Documentation (PT-BR & EN)
└── LICENSE                                     # MIT License
```

---

### 🛡️ Subagent Return Contract (Quality Guardrail)

To prevent the "telephone game" and ensure strict engineering rigor:
- Every execution subagent (`Model: "flash"`) returns a **concise report (≤40 lines)** containing:
  1. **Modified Files & Line Ranges** (`path/to/file:L10-L45`).
  2. **Compact Diff / Key Snippets** of the core changes (excluding noisy terminal logs).
  3. **Verification Status** (build/test command run and PASS/FAIL result).
- **Mandatory Review**: The Primary Model inspects the diff before concluding, guaranteeing zero compromise in software quality.

---

### 📄 License

Distributed under the [MIT License](LICENSE). Built for the Google Antigravity developer community.
