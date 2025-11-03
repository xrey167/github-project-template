# GitHub Project Template

Ein produktionsreifes Template für moderne JavaScript/TypeScript-Projekte mit klaren Prozessen, Workflows und Best Practices.

## 💡 Features

- 🗂️ Strukturierte Ordner für Code, Tests, Dokumentation und Skripte
- 🧩 Issue- & PR-Vorlagen, Sprint-Board-Konfiguration und Auto-Assign-Workflow
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

## 🔐 Benötigte Secrets

| Secret              | Beschreibung                                                  |
| ------------------- | ------------------------------------------------------------- |
| `FACTORY_API_KEY`   | API Key für `Factory-AI/droid-code-review@v1`                 |
| `ANTHROPIC_API_KEY` | API Key für `anthropics/claude-code-action@v1`                |
| `PROJECT_TOKEN`     | Personal Access Token mit Zugriffsrechten auf GitHub Projects |

Weitere Anforderungen siehe `ci.yml` und `auto-assign.yml`.

## 🤝 Contributing

Bitte beachte die Richtlinien in [`CONTRIBUTING.md`](./CONTRIBUTING.md). Stelle sicher, dass Linting und Tests vor jedem Commit erfolgreich sind.

## 📄 Lizenz

Dieses Projekt steht unter der [MIT License](./LICENSE).
