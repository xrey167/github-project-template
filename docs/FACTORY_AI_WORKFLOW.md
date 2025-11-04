# 🏭 Factory AI User Story Workflow

## Übersicht

Der Factory AI User Story Workflow automatisiert die komplette Umsetzung von User Stories - von der Planung bis zur Erstellung eines Pull Requests. Der Workflow nutzt Claude AI (via Anthropic's Claude Code Action) um alle Schritte intelligent und automatisch durchzuführen.

## 🎯 Was macht dieser Workflow?

Wenn eine User Story in GitHub erstellt wird, durchläuft sie automatisch folgende Phasen:

### 1. ✅ Validierung

- Prüft ob das Issue das Label `user-story` hat
- Extrahiert alle relevanten Informationen aus dem Issue

### 2. 📋 Planung

- Analysiert die User Story und Akzeptanzkriterien
- Identifiziert betroffene Dateien und Komponenten
- Erstellt einen detaillierten Implementierungsplan
- Speichert den Plan in `docs/implementation-plans/story-{number}-plan.md`
- Erstellt einen Feature-Branch im Format `claude/github-userstory-factory-workflow-{node-id}`

### 3. 🔨 Implementierung

- Implementiert die User Story gemäß dem Implementierungsplan
- Folgt den Best Practices und Code-Standards des Projekts
- Fügt Dokumentation und Kommentare hinzu
- Committed die Änderungen mit aussagekräftiger Commit-Message

### 4. 🧪 Test-Entwicklung

- Schreibt umfassende Unit Tests
- Erstellt Integration Tests wenn nötig
- Führt alle Tests aus und stellt sicher, dass sie durchlaufen
- Strebt hohe Code Coverage an (mindestens 80%)

### 5. ✅ Akzeptanzkriterien-Prüfung

- Überprüft jedes Akzeptanzkriterium
- Erstellt einen detaillierten Akzeptanzreport
- Speichert den Report in `docs/acceptance-reports/story-{number}-acceptance-report.md`
- Führt finale Tests aus (Lint, Unit, Integration, Build)

### 6. 🔀 Pull Request Erstellung

- Erstellt automatisch einen Pull Request
- Verlinkt den PR mit dem ursprünglichen Issue
- Fügt alle relevanten Labels hinzu
- Kommentiert im Issue mit dem PR-Link

## 🚀 Wie nutzt man den Workflow?

### Voraussetzungen

1. **GitHub Repository Secrets einrichten:**

   ```
   ANTHROPIC_API_KEY - API Key für Claude AI
   GITHUB_TOKEN - Wird automatisch von GitHub bereitgestellt
   ```

2. **User Story Template nutzen:**
   - Erstelle ein neues Issue mit dem "User Story" Template
   - Fülle alle erforderlichen Felder aus:
     - Epic/Feature
     - User Story (Als... möchte ich... damit...)
     - Akzeptanzkriterien (als Checkliste)
     - Story Points
     - Priorität
     - Definition of Done

### Workflow starten

1. **Issue erstellen:**

   ```
   - Gehe zu GitHub Issues
   - Klicke auf "New Issue"
   - Wähle "📖 User Story" Template
   - Fülle alle Felder aus
   - Stelle sicher, dass das Label "user-story" gesetzt ist
   - Erstelle das Issue
   ```

2. **Workflow läuft automatisch:**
   - Der Workflow startet automatisch bei Issue-Erstellung
   - Verfolge den Fortschritt in den Issue-Kommentaren
   - Überwache die Workflow-Runs unter "Actions"

3. **Review des Pull Requests:**
   - Wenn der Workflow abgeschlossen ist, wird ein PR erstellt
   - Review den Code, die Tests und die Dokumentation
   - Prüfe den Akzeptanzkriterien-Report
   - Approve und merge den PR wenn alles passt

## 📊 Workflow-Status verfolgen

Der Workflow kommentiert automatisch im Issue nach jedem Schritt:

```
🏭 Factory AI Workflow gestartet
✅ Planungsphase abgeschlossen
🌿 Branch erstellt: claude/github-userstory-factory-workflow-...

✅ Implementierungsphase abgeschlossen
➡️ Als nächstes: Tests schreiben

✅ Tests geschrieben und ausgeführt
➡️ Als nächstes: Akzeptanzkriterien prüfen

✅ Akzeptanzkriterien geprüft
➡️ Als nächstes: Pull Request erstellen

🎉 Pull Request erstellt!
```

## 📁 Generierte Dateien

Nach dem Workflow-Durchlauf findest du folgende neue Dateien:

```
docs/
├── implementation-plans/
│   └── story-{number}-plan.md          # Implementierungsplan
└── acceptance-reports/
    └── story-{number}-acceptance-report.md  # Akzeptanzreport
```

### Implementierungsplan Format

```markdown
# Implementierungsplan: User Story #123

## User Story

[User Story Text]

## Akzeptanzkriterien

[Liste der Kriterien]

## Betroffene Dateien

- file1.ts
- file2.ts

## Implementierungsschritte

1. Schritt 1
2. Schritt 2
   ...

## Zu erstellende Tests

- Test 1
- Test 2

## Akzeptanzkriterien Checkliste

- [ ] Kriterium 1
- [ ] Kriterium 2
```

### Akzeptanzreport Format

```markdown
# Akzeptanzkriterien Report: User Story #123

## User Story

[User Story Text]

## Akzeptanzkriterien Status

### Kriterium 1

- ✅ Status: Erfüllt
- Beschreibung: [Wie wurde es erfüllt]
- Beweis: [Code-Referenz oder Test]

### Kriterium 2

...

## Zusammenfassung

- Erfüllte Kriterien: X/Y
- Status: ✅ Bereit für Review

## Nächste Schritte

[Was muss noch getan werden]
```

## 🔧 Konfiguration

### Workflow anpassen

Der Workflow kann in `.github/workflows/userstory-factory-workflow.yml` angepasst werden:

```yaml
env:
  NODE_VERSION: "18" # Node.js Version ändern
```

### Claude AI Task anpassen

Jede Phase des Workflows nutzt eine spezifische Task-Beschreibung für Claude AI. Diese können in den jeweiligen Steps angepasst werden:

- **Planung:** `plan-implementation` Job
- **Implementierung:** `implement-story` Job
- **Tests:** `write-tests` Job
- **Akzeptanzkriterien:** `verify-acceptance-criteria` Job

## 🛡️ Best Practices

### Gute User Stories schreiben

1. **Klar und spezifisch:**

   ```
   ✅ Als Benutzer möchte ich mein Passwort ändern können, damit ich meine Kontosicherheit verwalten kann
   ❌ Als Benutzer möchte ich Sachen machen
   ```

2. **Konkrete Akzeptanzkriterien:**

   ```
   ✅
   - [ ] Benutzer kann auf "Passwort ändern" Button klicken
   - [ ] Formular wird mit aktueller Email vorausgefüllt
   - [ ] Neues Passwort muss bestätigt werden

   ❌
   - [ ] Passwort ändern funktioniert
   ```

3. **Angemessene Story Points:**
   - 1-3: Kleine Änderungen, wenige Stunden
   - 5-8: Mittlere Features, 1-2 Tage
   - 13+: Große Features, sollten aufgeteilt werden

### Review-Prozess

1. **Code Review:**
   - Prüfe die Implementierung auf Code-Qualität
   - Stelle sicher, dass Best Practices befolgt wurden
   - Überprüfe die Lesbarkeit und Wartbarkeit

2. **Test Review:**
   - Prüfe die Test-Coverage
   - Stelle sicher, dass alle Edge Cases getestet sind
   - Führe die Tests lokal aus

3. **Dokumentation Review:**
   - Lies den Implementierungsplan
   - Prüfe den Akzeptanzkriterien-Report
   - Stelle sicher, dass alle Kriterien erfüllt sind

## 🐛 Troubleshooting

### Workflow startet nicht

**Problem:** Der Workflow wird nicht getriggert

**Lösungen:**

- Stelle sicher, dass das Label `user-story` gesetzt ist
- Prüfe ob der Workflow aktiviert ist unter "Actions"
- Überprüfe die Repository-Permissions

### API Key Fehler

**Problem:** `ANTHROPIC_API_KEY` fehlt oder ist ungültig

**Lösungen:**

- Prüfe ob das Secret korrekt in den Repository-Settings gesetzt ist
- Stelle sicher, dass der API Key gültig ist
- Überprüfe die API Key Quota bei Anthropic

### Branch Push schlägt fehl

**Problem:** Git push schlägt mit 403 Fehler fehl

**Lösungen:**

- Der Branch-Name muss mit `claude/` beginnen und mit der Session-ID enden
- Stelle sicher, dass die Permissions korrekt sind
- Prüfe ob Branch Protection Rules den Push blockieren

### Tests schlagen fehl

**Problem:** Tests durchlaufen nicht erfolgreich

**Lösungen:**

- Prüfe die Test-Logs für Details
- Führe die Tests lokal aus: `npm run test:unit`
- Stelle sicher, dass alle Dependencies installiert sind
- Überprüfe ob die Implementierung die Tests erfüllt

### Pull Request kann nicht erstellt werden

**Problem:** PR-Erstellung schlägt fehl

**Lösungen:**

- Stelle sicher, dass Commits auf dem Branch existieren
- Prüfe ob ein PR mit dem gleichen Branch bereits existiert
- Überprüfe die Branch-Namen-Konventionen
- Stelle sicher, dass der base branch (main) existiert

## 🔄 Workflow-Integration

### Mit anderen Workflows

Der Factory AI Workflow integriert sich mit anderen Workflows im Repository:

```
User Story Issue erstellt
    ↓
Factory AI Workflow
    ↓
Pull Request erstellt
    ↓
AI Code Review (droid-code-review, claude-code-action)
    ↓
CI/CD Pipeline (lint, test, build)
    ↓
Manual Review & Approval
    ↓
Merge to main
    ↓
Deployment
```

### Automatische Labels

Der Workflow fügt automatisch folgende Labels zum PR hinzu:

- `user-story` - Kennzeichnet als User Story Implementation
- `automated` - Kennzeichnet als automatisch erstellt
- `factory-ai` - Kennzeichnet als Factory AI generiert

## 📈 Metriken und Monitoring

### Wichtige Metriken verfolgen

- **Workflow-Erfolgsrate:** Wie viele User Stories werden erfolgreich implementiert?
- **Durchlaufzeit:** Wie lange dauert es von Issue-Erstellung bis PR?
- **Code-Qualität:** Test Coverage, Lint-Fehler, etc.
- **Review-Zeit:** Wie lange dauern Reviews der automatisch erstellten PRs?

### GitHub Actions Logs

Alle Workflow-Runs werden unter "Actions" gespeichert:

```
Repository → Actions → Factory AI User Story Workflow
```

Hier kannst du:

- Logs jedes Jobs einsehen
- Fehler debuggen
- Performance analysieren
- Workflow-Historie verfolgen

## 🎓 Beispiel: Kompletter Workflow-Durchlauf

### 1. User Story erstellen

```markdown
**Epic:** Benutzer-Authentifizierung

**User Story:**
Als Benutzer
möchte ich mein Passwort zurücksetzen können
damit ich wieder Zugriff auf mein Konto erhalte, wenn ich es vergessen habe

**Akzeptanzkriterien:**

- [ ] Benutzer kann auf "Passwort vergessen?" Link klicken
- [ ] Email-Feld wird angezeigt zur Eingabe der registrierten Email
- [ ] System sendet Reset-Link an die angegebene Email
- [ ] Reset-Link ist 24 Stunden gültig
- [ ] Benutzer kann neues Passwort eingeben und bestätigen
- [ ] System validiert Passwort-Stärke
- [ ] Erfolgsmeldung wird angezeigt nach Reset

**Story Points:** 5

**Priorität:** Must Have
```

### 2. Workflow läuft automatisch

```
[00:00] ✅ Validierung abgeschlossen
[00:01] 📋 Implementierungsplan erstellt
[00:02] 🌿 Branch: claude/github-userstory-factory-workflow-abc123
[00:05] 🔨 Implementierung abgeschlossen
[00:08] 🧪 Tests geschrieben (Coverage: 85%)
[00:10] ✅ Alle Akzeptanzkriterien erfüllt (7/7)
[00:12] 🔀 Pull Request #42 erstellt
```

### 3. Generierte Dateien

**`docs/implementation-plans/story-15-plan.md`**

- Detaillierter Plan für Password-Reset Feature
- Betroffene Dateien: auth.service.ts, email.service.ts, etc.
- API-Endpunkte: POST /api/auth/forgot-password
- Komponenten: ForgotPasswordForm, ResetPasswordForm

**`docs/acceptance-reports/story-15-acceptance-report.md`**

- Alle 7 Akzeptanzkriterien erfüllt ✅
- Test Coverage: 85%
- Status: Bereit für Review

### 4. Pull Request Review

**PR #42: feat: implement password reset functionality**

- 12 geänderte Dateien
- +450 Zeilen Code
- +320 Zeilen Tests
- Alle Checks passing ✅

### 5. Merge und Deployment

- Code Review approved
- PR gemerged
- CI/CD Pipeline deployt zu Staging
- Feature ist live! 🎉

## 🤝 Contributing

Verbesserungsvorschläge für den Workflow sind willkommen!

1. Fork das Repository
2. Erstelle einen Feature Branch
3. Mache deine Änderungen am Workflow
4. Teste den Workflow gründlich
5. Erstelle einen Pull Request mit Beschreibung der Änderungen

## 📚 Weiterführende Links

- [GitHub Actions Dokumentation](https://docs.github.com/en/actions)
- [Anthropic Claude API](https://docs.anthropic.com/)
- [GitHub Issues Best Practices](https://docs.github.com/en/issues)
- [User Story Writing Guide](https://www.atlassian.com/agile/project-management/user-stories)

## 🆘 Support

Bei Problemen oder Fragen:

1. Prüfe die Troubleshooting-Sektion oben
2. Schaue in die Workflow-Logs unter "Actions"
3. Erstelle ein Issue mit dem Label `workflow-support`
4. Kontaktiere das Team

---

**Version:** 1.0.0
**Letzte Aktualisierung:** 2025-11-04
