# GitHub Project Template – Nutzung

Dieses Dokument erklärt, wie du das Repository als Ausgangspunkt für neue Projekte verwendest und anpasst.

## 🚀 Schnellstart

1. **Repository verwenden**
   - Klicke in GitHub auf `Use this template` → `Create a new repository`.
   - Vergib einen Namen, wähle Sichtbarkeit und bestätige.
2. **Lokales Setup**
   ```bash
   git clone <dein-repo-url>
   cd <dein-repo>
   npm install
   ```
3. **Initiale Checks**
   ```bash
   npm run lint
   npm run test
   npm run build
   ```

## 🧩 Was ist enthalten?

| Bereich         | Inhalte                                                 |
| --------------- | ------------------------------------------------------- |
| Planung         | Issue- & PR-Vorlagen, Sprint-Board-Konfiguration        |
| Automatisierung | CI/CD Pipeline, Auto-Assign Workflow, AI Code Review    |
| Qualität        | ESLint, Prettier, Vitest, Playwright, Husky/Lint-Staged |
| Docs            | README, CONTRIBUTING, CODE_OF_CONDUCT, LICENSE          |

## 🔧 Pflichtanpassungen nach dem Klonen

| Schritt               | Beschreibung                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------- |
| `.env.example` prüfen | Relevante Environment-Variablen ergänzen und in `.env` kopieren                             |
| `package.json`        | `name`, `description`, `author`, `repository`-Links anpassen                                |
| Workflows             | Secrets (`FACTORY_API_KEY`, `ANTHROPIC_API_KEY`, `PROJECT_TOKEN`) im Repository hinterlegen |
| Auto-Assign           | In `.github/workflows/auto-assign.yml` Nutzer:innen & Projekt-URL anpassen                  |
| LICENSE               | Falls nicht MIT verwendet werden soll, ersetzen                                             |

## 🛠️ Development-Workflow

1. Branch vom `main` oder `develop` erstellen.
2. Code ändern und lokal `npm run lint` & `npm run test` ausführen.
3. Commit erstellen (`conventional commits` empfohlen).
4. Pull Request öffnen und die PR-Vorlage vollständig ausfüllen.
5. Auf automatisierte Reviews (CI, AI Code Review, Security Checks) warten.
6. Feedback adressieren, erneut testen und mergen.

## 📦 Deployment

- Standardmäßig liefert `ci.yml` Beispiele für Staging- und Production-Deployments. Ergänze dort dein eigenes Skript oder rufe ein Deployment-Tool (z. B. Terraform, Helm, Vercel CLI) auf.
- Nutze `workflow_dispatch`, um manuelle Deployments mit Parameter `environment` anzustoßen.

## 🔒 Security & Compliance

- Aktiviere CodeQL Alerts und Dependabot im neuen Repository.
- Hinterlege Secrets niemals im Code – verwende GitHub Actions Secrets oder ein Secret-Management-System.
- Führe Sicherheitsrelevante Änderungen mit dem Label `security` – dadurch wird der Security Review Workflow ausgelöst.

## 🤖 AI Code Review konfigurieren

| Workflow             | Zweck                                          | Notwendige Secrets                  |
| -------------------- | ---------------------------------------------- | ----------------------------------- |
| `droid-code-review`  | Nutzung von `Factory-AI/droid-code-review@v1`  | `FACTORY_API_KEY`, `GITHUB_TOKEN`   |
| `claude-code-action` | Nutzung von `anthropics/claude-code-action@v1` | `ANTHROPIC_API_KEY`, `GITHUB_TOKEN` |

Passe `include-patterns`/`include-paths` an deine Codebasis an, um Rauschen zu reduzieren.

## 🙋 Support

- Fragen zu Prozessen: siehe `CONTRIBUTING.md`.
- Fragen zur Community: siehe `CODE_OF_CONDUCT.md`.
- Für Fehler oder Verbesserungen: Issue eröffnen und passende Vorlage nutzen.

Viel Erfolg bei der Nutzung des Templates!
