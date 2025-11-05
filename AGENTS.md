# 🤖 AI Agents Configuration

Diese Datei dokumentiert die AI-Agent-Integration für automatisierte Code-Reviews, Qualitätsprüfungen und intelligente Entwicklungsunterstützung in diesem Repository.

## 📋 Übersicht der integrierten AI-Agents

### 🚀 Factory Droid
- **Purpose**: Automatisierte Code-Analyse und Bug-Detection
- **Provider**: [Factory AI](https://factory.ai)
- **Integration**: GitHub Action ``Factory-AI/droid-code-review@v1``
- **Trigger**: Pull Requests (opened, synchronize, reopened)

### 🧠 Claude Code Assistant  
- **Purpose**: Intelligente Code-Reviews und Best-Practice-Empfehlungen
- **Provider**: [Anthropic](https://anthropic.com)
- **Integration**: GitHub Action ``anthropics/claude-code-action@v1``
- **Trigger**: Pull Requests und Security-Labels

## ⚙️ Agent-Konfiguration

### 🔑 Erforderliche Secrets

Fügen Sie diese Secrets in Ihren Repository-Einstellungen hinzu:
**Settings → Secrets and variables → Actions**

``````yaml
# Factory AI Configuration
FACTORY_API_KEY: "your-factory-ai-api-key"
# Erhältlich bei: https://app.factory.ai/settings/api-keys

# Anthropic Configuration  
ANTHROPIC_API_KEY: "your-anthropic-api-key"
# Erhältlich bei: https://console.anthropic.com/settings/keys

# GitHub Token (automatisch verfügbar)
GITHUB_TOKEN: `${{ secrets.GITHUB_TOKEN }}

# Auto-Assignment & Project Board
PROJECT_TOKEN: "github_pat_..." # Personal Access Token mit project scope

🎯 Droid Agent Konfiguration
Automatische Erkennung für:

✅ Dead/unreachable code
✅ Control flow bugs (missing breaks, infinite loops)
✅ Async/await errors und Promise-Handling
✅ React-specific issues (state mutations, hook rules)
✅ Operator mistakes und type coercion
✅ Array/loop errors und off-by-one errors
✅ Null/undefined errors
✅ Resource management issues
✅ Security vulnerabilities (SQL injection, XSS)
✅ Concurrency problems
✅ Error handling deficiencies
✅ Recursion issues
✅ Regex problems
File Pattern Configuration:

include-patterns: |
  **/*.ts        # TypeScript files
  **/*.tsx       # TypeScript React files
  **/*.js        # JavaScript files
  **/*.jsx       # JavaScript React files
  **/*.py        # Python files
  **/*.java      # Java files
  **/*.go        # Go files
  **/*.rs        # Rust files

exclude-patterns: |
  **/node_modules/**    # Dependencies
  **/dist/**           # Build output
  **/build/**          # Build output
  **/*.test.ts         # Test files
  **/*.spec.ts         # Spec files
  **/coverage/**       # Coverage reports

🧠 Claude Agent Konfiguration
Review Focus Areas:

Code Quality: Clean code principles, readability, maintainability
Best Practices: Language-specific conventions, design patterns
Bug Detection: Logic errors, edge cases, potential runtime issues
Security: Vulnerability detection, secure coding practices
Performance: Optimization opportunities, efficiency improvements
Architecture: Component design, separation of concerns
Testing: Test coverage gaps, test quality suggestions

Custom Task Configuration:


task: |
  Perform a thorough code review focusing on:
  1. Code quality and best practices
  2. Potential bugs and logic errors
  3. Security vulnerabilities
  4. Performance optimizations
  5. TypeScript/JavaScript specific issues
  6. React/Vue/Angular specific patterns (if applicable)
  7. Test coverage suggestions
  
  Please provide constructive feedback with specific suggestions for improvement.

🤖 Automated Assignment & AI Integration
👥 Auto-Assignment Workflow
Das Repository verfügt über intelligente Auto-Assignment-Funktionen, die nahtlos mit den AI-Agents zusammenarbeiten:

Automatische Zuweisung basierend auf Labels

Assignment Rules:
'bug'              → @maintainer1, @qa-lead
'security'         → @security-team, @maintainer1  
'frontend'         → @frontend-team
'backend'          → @backend-team
'documentation'    → @docs-team
'sprint-planning'  → @product-owner, @scrum-master
'ai-agents'        → @ai-specialist, @maintainer1

Integration mit AI Code Review

Workflow Coordination:
1. PR wird erstellt → Auto-Assignment aktiviert
2. Label-basierte Zuweisung → Reviewer werden automatisch hinzugefügt
3. AI-Agents starten Review → Droid & Claude analysieren Code
4. Human Review beginnt → Basierend auf AI-Findings
5. Approval Process → AI + Human validation


🎯 Project Board Automation
Automatisches Hinzufügen zu Project Boards

Trigger Labels:
- sprint-planning  → Wird zu Sprint Board hinzugefügt
- bug             → Wird zu Bug Tracking Board hinzugefügt
- enhancement     → Wird zu Feature Board hinzugefügt
- ai-review       → Wird zu AI Review Board hinzugefügt


🔒 Security-Focused AI Review
Trigger Conditions
Der Security Review wird automatisch aktiviert bei:

Pull Requests mit Label security
Pull Requests mit Label authentication
Änderungen an sicherheitskritischen Dateien
Security Scan Areas

Security Focus Areas:
1. SQL injection vulnerabilities
2. XSS attack vectors  
3. Authentication/authorization flaws
4. Input validation issues
5. Sensitive data exposure
6. Insecure cryptographic practices
7. API security issues
8. Environment variable leaks
9. Dependency vulnerabilities
10. CORS misconfigurations

Severity Rating System
CRITICAL: Immediate security risk, blocks deployment
HIGH: Significant vulnerability, requires urgent fix
MEDIUM: Potential security concern, should be addressed
LOW: Security improvement opportunity
🚦 Workflow Activation
Automatic Triggers

on:
  pull_request:
    types: [opened, synchronize, reopened]
  issues:
    types: [opened]


Conditional Execution
Droid Review: Runs on all PRs (except Dependabot)
Claude Review: Runs on all PRs (except Dependabot)
Security Review: Runs only when security labels are present
Auto-Assignment: Runs on all Issues and PRs
Exclusions
Dependabot PRs are automatically excluded
Draft PRs can be excluded (optional configuration)
🛠️ Setup & Installation
1. API Keys erhalten
Factory AI API Key:

Registrierung bei Factory AI
Navigate to Settings → API Keys
Erstellen Sie einen neuen API Key
Fügen Sie ihn als FACTORY_API_KEY Secret hinzu
Anthropic API Key:

Registrierung bei Anthropic Console
Navigate to Settings → API Keys
Erstellen Sie einen neuen API Key
Fügen Sie ihn als ANTHROPIC_API_KEY Secret hinzu
Project Token:

GitHub Settings → Developer settings → Personal access tokens
Generate new token mit repo und project scopes
Fügen Sie ihn als PROJECT_TOKEN Secret hinzu
2. Repository Secrets konfigurieren

# Via GitHub CLI
gh secret set FACTORY_API_KEY --body "your-factory-api-key"
gh secret set ANTHROPIC_API_KEY --body "your-anthropic-api-key"
gh secret set PROJECT_TOKEN --body "your-project-token"

# Oder über GitHub UI:
# Settings → Secrets and variables → Actions → New repository secret

3. Team-Konfiguration anpassen
Bearbeiten Sie .github/workflows/auto-assign.yml und passen Sie die Team-Member an:

# Ersetzen Sie diese Platzhalter mit echten GitHub Usernames
const assignmentRules = {
  'bug': ['IHR_QA_LEAD', 'IHR_MAINTAINER'],
  'security': ['IHR_SECURITY_TEAM'],
  'frontend': ['IHR_FRONTEND_TEAM'], 
  'backend': ['IHR_BACKEND_TEAM'],
  'ai-agents': ['IHR_AI_SPECIALIST']
};


4. Project Board URLs anpassen

# In auto-assign.yml
project-url: https://github.com/IHR_USERNAME/IHR_REPO/projects/1

📊 Monitoring & Analytics
AI Review Metriken
Review Coverage: Percentage of PRs reviewed by AI
Issue Detection Rate: Number of issues found per PR
False Positive Rate: Incorrectly flagged issues
Resolution Time: Time from issue detection to fix
Assignment Accuracy: Correct reviewer assignments
Performance Tracking

# Beispiel-Metriken Dashboard
metrics:
  - droid_reviews_total
  - claude_reviews_total
  - security_issues_detected
  - auto_assignments_successful
  - review_response_time
  - developer_satisfaction_score


🆘 Troubleshooting
Häufige Probleme
1. API Key Fehler

Error: Invalid API key or insufficient permissions

Lösung: Überprüfen Sie API Key und Berechtigungen

2. Auto-Assignment schlägt fehl

Error: User not found or insufficient permissions

Lösung: GitHub Usernames prüfen, Team-Access validieren

3. Project Board Access

Error: Resource not accessible by integration

Lösung: PROJECT_TOKEN Berechtigung und Scope prüfen

4. Workflow schlägt fehl

Error: Required secret not found

Lösung: Stellen Sie sicher, dass alle Secrets konfiguriert sind

Debug-Modus aktivieren

# Fügen Sie zu Workflow hinzu für erweiterte Logs
env:
  ACTIONS_RUNNER_DEBUG: true
  ACTIONS_STEP_DEBUG: true


🔄 Workflow-Integration Übersicht
Zusammenspiel der Workflows:
Issue/PR erstellt → Auto-Assignment Workflow startet
Labels zugewiesen → Team-Member automatisch assigned
PR Code Changes → AI Code Review (Droid + Claude) startet
Security Labels → Enhanced Security Review aktiviert
Project Boards → Automatische Zuordnung zu Boards
Sprint Planning → User Stories zu aktuellem Sprint
Workflow-Abhängigkeiten:

graph LR
    A[New PR/Issue] --> B[Auto-Assignment]
    B --> C[AI Code Review]
    C --> D[Human Review]
    D --> E[Approval]
    E --> F[Merge]
    
    B --> G[Project Board]
    G --> H[Sprint Planning]

📚 Best Practices
Für Entwickler:
Aussagekräftige Labels verwenden
PR-Beschreibungen für besseren AI-Context
Security-Labels bei sicherheitskritischen Changes
Test-Coverage für AI-Review-Qualität
Für Maintainer:
Team-Mapping aktuell halten
API-Limits überwachen
Review-Qualität regelmäßig bewerten
Workflow-Performance optimieren
📚 Zusätzliche Ressourcen
Factory AI Documentation
Anthropic Claude API Docs
GitHub Actions Documentation
GitHub Projects Documentation
Diese AI-Agent-Integration mit Auto-Assignment bringt Ihr Repository auf die nächste Stufe der Automatisierung! 🚀

Für Support und Fragen zur AI-Integration, erstellen Sie ein Issue mit dem Label ai-agents