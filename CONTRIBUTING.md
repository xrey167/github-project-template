# Contributing Guidelines

Vielen Dank, dass du zum Projekt beitragen möchtest! Dieses Dokument fasst den erwarteten Workflow zusammen.

## 📋 Voraussetzungen

- Node.js ≥ 18 & npm ≥ 9 installiert
- Repository geforkt oder mit Schreibrechten versehen
- Husky Hooks werden automatisch über `npm install` eingerichtet

## 🔀 Branching-Modell

- `main`: Produktionsbereit, geschützt
- `develop`: Integrationszweig für den nächsten Release
- Feature Branches: `feature/<kurze-beschreibung>`
- Bugfix Branches: `fix/<ticket-id>`
- Hotfix Branches: `hotfix/<kurze-beschreibung>`

## 🛠️ Entwicklungs-Workflow

1. Branch erstellen und aktuelle Änderungen pullen.
2. Entwicklung durchführen, relevante Tests schreiben.
3. Sicherstellen, dass folgende Kommandos erfolgreich laufen:
   ```bash
   npm run lint
   npm run test
   npm run build
   ```
4. Conventional Commit Message verwenden (`feat:`, `fix:`, `docs:`, ...).
5. Push und Pull Request eröffnen.

## 🧪 Tests & Qualität

- Unit Tests: `npm run test:unit`
- Integration Tests: `npm run test:integration`
- End-to-End Tests: `npm run test:e2e`
- Coverage Report: `npm run test:coverage`
- Type Check: `npm run type-check`

Bitte führe mindestens die relevanten Tests aus, bevor du einen PR erstellst. Bei UI-/E2E-Änderungen Screenshots oder Videos anhängen.

## 🔍 Code Review

- Fülle die PR-Vorlage vollständig aus.
- Weisen mindestens zwei Reviewer zu (oder folge Team-Regel).
- Beachte AI-Feedback aus `droid-code-review` und `claude-code-action`.
- Adressiere Kommentare zeitnah und markiere sie nach Bearbeitung als erledigt.

## 📦 Releases & Deployments

- Release-Kandidaten werden über `develop` aufgebaut.
- Production Deployments erfolgen nur nach Freigabe durch Maintainer.
- Dokumentiere Breaking Changes in den Release Notes.

## 💬 Kommunikation

- Nutze Issues für Bugs/Features mit den vorhandenen Templates.
- Halte Diskussionen konstruktiv und respektvoll (siehe `CODE_OF_CONDUCT.md`).
- Melde Sicherheitslücken privat an das Maintainer-Team.

Wir freuen uns auf deine Beiträge!
