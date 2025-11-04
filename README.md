# GitHub Project Template

Ein produktionsreifes Template für moderne JavaScript/TypeScript-Projekte mit klaren Prozessen, Workflows und Best Practices.

## 💡 Features

- 🗂️ Strukturierte Ordner für Code, Tests, Dokumentation und Skripte
- 🧩 Issue- & PR-Vorlagen, Sprint-Board-Konfiguration und Auto-Assign-Workflow
- 🏭 **Factory AI User Story Workflow** - Automatische Umsetzung von User Stories mit Claude AI
- 🤖 Integrierte AI Code Reviews (`Factory-AI/droid-code-review`, `anthropics/claude-code-action`)
- 🚀 CI/CD Pipeline mit Linting, Tests, Build, CodeQL und Deployment-Platzhaltern
- 🛡️ Sicherheits- und Qualitätschecks (ESLint, Prettier, Vitest, Playwright, Husky)

## 🚀 Schnellstart

```bash
git clone https://github.com/xrey167/github-project-template.git
cd github-project-template
npm install
npm run lint
npm test
npm run build
```

## 🧱 Projektstruktur

```text
github-project-template/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   ├── project-templates/
│   └── pull_request_template.md
├── docs/
├── scripts/
├── src/
├── tests/
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── README.md
├── package.json
└── .env.example
```

Details zur Nutzung findest du in `docs/TEMPLATE_USAGE.md`.

## 🏭 Factory AI User Story Workflow

Dieses Template enthält einen vollautomatischen Workflow zur Umsetzung von User Stories:

1. **📋 Planung** - Automatische Erstellung eines Implementierungsplans
2. **🔨 Implementierung** - KI-gestützte Code-Implementierung
3. **🧪 Tests** - Automatisches Schreiben von Unit- und Integration-Tests
4. **✅ Akzeptanzkriterien** - Überprüfung aller Kriterien
5. **🔀 Pull Request** - Automatische PR-Erstellung mit vollständiger Dokumentation

### Nutzung

1. Erstelle ein Issue mit dem **"User Story"** Template
2. Fülle alle Felder aus (User Story, Akzeptanzkriterien, Story Points, etc.)
3. Stelle sicher, dass das Label `user-story` gesetzt ist
4. Der Workflow startet automatisch und erstellt einen PR mit der vollständigen Implementierung

**📚 Vollständige Dokumentation:**
- [`docs/FACTORY_AI_WORKFLOW.md`](./docs/FACTORY_AI_WORKFLOW.md) - Nutzungsanleitung
- [`docs/WORKFLOW_IMPROVEMENTS.md`](./docs/WORKFLOW_IMPROVEMENTS.md) - Verbesserungen & Best Practices

## 🔐 Benötigte Secrets

| Secret              | Beschreibung                                                  | Erforderlich für |
| ------------------- | ------------------------------------------------------------- | ---------------- |
| `FACTORY_API_KEY`   | API Key für `Factory-AI/droid-code-review@v1`                 | AI Code Review |
| `ANTHROPIC_API_KEY` | API Key für `anthropics/claude-code-action@v1` und Factory AI Workflow | **Factory AI User Story Workflow**, AI Code Review |
| `PROJECT_TOKEN`     | Personal Access Token mit Zugriffsrechten auf GitHub Projects | Auto-Assign Workflow |

**Wichtig:** Der `ANTHROPIC_API_KEY` ist **zwingend erforderlich** für den Factory AI User Story Workflow!

### API Keys einrichten

1. **Anthropic API Key** (für Factory AI Workflow):
   - Gehe zu https://console.anthropic.com/
   - Erstelle einen neuen API Key
   - Füge ihn als Repository Secret `ANTHROPIC_API_KEY` hinzu

2. **Factory API Key** (optional, für AI Code Reviews):
   - Gehe zu https://factory.ai/
   - Erstelle einen API Key
   - Füge ihn als Repository Secret `FACTORY_API_KEY` hinzu

Weitere Anforderungen siehe `ci.yml`, `auto-assign.yml` und `userstory-factory-workflow.yml`.

## 🤝 Contributing

Bitte beachte die Richtlinien in [`CONTRIBUTING.md`](./CONTRIBUTING.md). Stelle sicher, dass Linting und Tests vor jedem Commit erfolgreich sind.

## 📄 Lizenz

Dieses Projekt steht unter der [MIT License](./LICENSE).
