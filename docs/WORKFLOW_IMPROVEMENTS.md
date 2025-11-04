# 🔧 Workflow Verbesserungen & Erweiterungen

Dieses Dokument beschreibt Verbesserungen und Erweiterungen für den Factory AI User Story Workflow.

## ✅ Implementierte Verbesserungen

### 1. Git Push mit Retry-Mechanismus

**Skript:** `.github/scripts/git-push-with-retry.sh`

**Features:**
- Exponentielles Backoff (2s, 4s, 8s, 16s)
- Bis zu 4 Retry-Versuche bei Netzwerkfehlern
- Validierung des Branch-Namens (muss mit `claude/` beginnen)
- Detaillierte Fehlerausgaben

**Verwendung im Workflow:**
```yaml
- name: 📤 Push changes with retry
  run: .github/scripts/git-push-with-retry.sh "${{ needs.plan-implementation.outputs.branch_name }}"
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### 2. Git Fetch mit Retry-Mechanismus

**Skript:** `.github/scripts/git-fetch-with-retry.sh`

**Features:**
- Exponentielles Backoff (2s, 4s, 8s, 16s)
- Bis zu 4 Retry-Versuche
- Unterstützt sowohl vollständigen Fetch als auch Branch-spezifischen Fetch

**Verwendung im Workflow:**
```yaml
- name: 🔄 Fetch latest changes with retry
  run: .github/scripts/git-fetch-with-retry.sh "${{ needs.plan-implementation.outputs.branch_name }}"
```

## 🚀 Empfohlene zusätzliche Verbesserungen

### 3. Workflow Status Checks

Füge Status-Checks am Anfang hinzu:

```yaml
check-prerequisites:
  name: 🔍 Check Prerequisites
  runs-on: ubuntu-latest
  outputs:
    has_api_key: ${{ steps.check.outputs.has_api_key }}
  steps:
    - name: Check API Key
      id: check
      run: |
        if [ -z "${{ secrets.ANTHROPIC_API_KEY }}" ]; then
          echo "❌ ANTHROPIC_API_KEY is not set!"
          echo "has_api_key=false" >> $GITHUB_OUTPUT
          exit 1
        else
          echo "✅ ANTHROPIC_API_KEY is configured"
          echo "has_api_key=true" >> $GITHUB_OUTPUT
        fi
```

### 4. Fehler-Benachrichtigungen

Füge Error-Handling für jeden Job hinzu:

```yaml
- name: 💬 Comment on Issue - Error
  if: failure()
  uses: actions/github-script@v6
  with:
    script: |
      github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: context.issue.number,
        body: `❌ **Fehler in Phase: ${{ github.job }}**\n\n` +
              `Der Workflow ist fehlgeschlagen. Bitte überprüfe die Logs:\n` +
              `🔗 [Workflow Run](${context.payload.repository.html_url}/actions/runs/${context.runId})\n\n` +
              `**Nächste Schritte:**\n` +
              `1. Überprüfe die Fehlerdetails in den Workflow-Logs\n` +
              `2. Korrigiere das Problem\n` +
              `3. Re-trigger den Workflow mit dem Label \`retry-factory-workflow\``
      });
```

### 5. Workflow Re-Trigger Support

Ermögliche manuelles Re-Triggering:

```yaml
on:
  issues:
    types: [opened, labeled]
  workflow_dispatch:
    inputs:
      issue_number:
        description: 'Issue number to process'
        required: true
        type: number
  push:
    branches: [main]
    paths:
      - ".github/workflows/userstory-factory-workflow.yml"
```

### 6. Bessere Branch-Namen mit Sanitization

```yaml
- name: 🌿 Create feature branch with sanitized name
  id: create_branch
  env:
    ISSUE_NUMBER: ${{ github.event.issue.number }}
    ISSUE_TITLE: ${{ github.event.issue.title }}
  run: |
    # Sanitize title for branch name (remove special chars, lowercase)
    SANITIZED_TITLE=$(echo "${ISSUE_TITLE}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | cut -c1-50)
    BRANCH_NAME="claude/github-userstory-factory-workflow-${ISSUE_NUMBER}-${SANITIZED_TITLE}-${{ github.event.issue.node_id }}"

    git config --global user.name "factory-ai-bot"
    git config --global user.email "factory-ai-bot@users.noreply.github.com"
    git checkout -b "$BRANCH_NAME"
    echo "branch_name=$BRANCH_NAME" >> $GITHUB_OUTPUT
```

### 7. Parallel Job Execution für Performance

Optimiere die Job-Abhängigkeiten:

```yaml
# Statt sequentiell alle Jobs auszuführen, können manche parallel laufen
validate-and-plan:
  name: 🔍 Validate & Plan
  # Kombiniere Validierung und Planung in einem Job

analyze-codebase:
  name: 📊 Analyze Codebase
  runs-on: ubuntu-latest
  # Läuft parallel zur Planung, sammelt Kontext
  steps:
    - name: Analyze dependencies
      run: npm list --depth=0
    - name: Check test coverage
      run: npm run test:coverage
```

### 8. Caching für bessere Performance

```yaml
- name: 📦 Cache node_modules
  uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

### 9. Workflow Timeouts

Füge Timeouts hinzu um hängende Jobs zu vermeiden:

```yaml
jobs:
  plan-implementation:
    name: 📋 Plan Implementation
    runs-on: ubuntu-latest
    timeout-minutes: 15  # Timeout nach 15 Minuten

  implement-story:
    name: 🔨 Implement Story
    runs-on: ubuntu-latest
    timeout-minutes: 30  # Längerer Timeout für Implementierung
```

### 10. Summary Report am Ende

```yaml
generate-summary:
  name: 📊 Generate Summary Report
  runs-on: ubuntu-latest
  needs: [validate-user-story, plan-implementation, implement-story, write-tests, verify-acceptance-criteria]
  if: always()
  steps:
    - name: Generate Summary
      uses: actions/github-script@v6
      with:
        script: |
          const summary = `
          ## 🏭 Factory AI Workflow Summary

          | Phase | Status |
          |-------|--------|
          | ✅ Validation | ${{ needs.validate-user-story.result }} |
          | 📋 Planning | ${{ needs.plan-implementation.result }} |
          | 🔨 Implementation | ${{ needs.implement-story.result }} |
          | 🧪 Tests | ${{ needs.write-tests.result }} |
          | ✅ Acceptance | ${{ needs.verify-acceptance-criteria.result }} |

          **Overall Status:** ${{ job.status }}
          `;

          core.summary.addRaw(summary).write();
```

## 📈 Performance Optimierungen

### 1. Selective Checkout

Nur relevante Dateien auschecken:

```yaml
- name: ⬇️ Checkout code (sparse)
  run: |
    git sparse-checkout init --cone
    git sparse-checkout set src tests docs .github
```

### 2. Incremental Testing

Nur geänderte Dateien testen:

```yaml
- name: 🧪 Run tests for changed files
  run: |
    CHANGED_FILES=$(git diff --name-only HEAD~1 | grep -E '\.(ts|tsx|js|jsx)$' || true)
    if [ -n "$CHANGED_FILES" ]; then
      npm run test -- --findRelatedTests $CHANGED_FILES
    fi
```

## 🔐 Sicherheitsverbesserungen

### 1. Secret Scanning vor Commit

```yaml
- name: 🔐 Scan for secrets
  uses: trufflesecurity/trufflehog@main
  with:
    path: ./
    base: HEAD~1
    head: HEAD
```

### 2. Code Quality Checks

```yaml
- name: 📊 Run SonarQube Analysis
  uses: SonarSource/sonarqube-scan-action@master
  env:
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
    SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
```

## 🧪 Testing Verbesserungen

### 1. Visual Regression Tests

```yaml
- name: 📸 Visual Regression Tests
  run: npm run test:visual

- name: 📤 Upload Visual Diffs
  if: failure()
  uses: actions/upload-artifact@v3
  with:
    name: visual-diffs
    path: tests/__image_snapshots__/__diff_output__/
```

### 2. Performance Testing

```yaml
- name: ⚡ Performance Tests
  run: |
    npm run test:perf
    npm run lighthouse -- --preset=perf
```

## 📝 Dokumentation Verbesserungen

### 1. Auto-generate Changelog

```yaml
- name: 📝 Update Changelog
  uses: actions/github-script@v6
  with:
    script: |
      const fs = require('fs');
      const changelog = `
      ## User Story #${{ github.event.issue.number }} - ${new Date().toISOString().split('T')[0]}

      **Feature:** ${{ github.event.issue.title }}

      **Changes:**
      - See PR #${{ needs.create-pull-request.outputs.pr_number }}

      **Acceptance Criteria:** All met ✅
      `;

      fs.appendFileSync('CHANGELOG.md', changelog);
```

### 2. API Documentation Update

```yaml
- name: 📚 Generate API Docs
  run: |
    npm run docs:generate
    git add docs/api/
```

## 🎯 Verwendung der Verbesserungen

### Schnell-Integration

Um die Git-Retry-Skripte zu verwenden, aktualisiere den Workflow:

```yaml
# Ersetze alle `git push` Befehle mit:
- name: 📤 Push changes
  run: .github/scripts/git-push-with-retry.sh "$BRANCH_NAME"

# Ersetze alle `git fetch` Befehle mit:
- name: 🔄 Fetch changes
  run: .github/scripts/git-fetch-with-retry.sh "$BRANCH_NAME"
```

### Schrittweise Integration

1. **Woche 1:** Retry-Mechanismen
2. **Woche 2:** Fehlerbehandlung & Benachrichtigungen
3. **Woche 3:** Performance-Optimierungen
4. **Woche 4:** Sicherheits- & Qualitätschecks

## 📊 Metriken & Monitoring

Tracke diese Metriken für Workflow-Optimierung:

```yaml
- name: 📊 Report Metrics
  run: |
    echo "workflow_duration=${{ steps.start.outputs.time }}" >> metrics.txt
    echo "test_coverage=${{ steps.test.outputs.coverage }}" >> metrics.txt
    echo "lines_changed=${{ steps.diff.outputs.lines }}" >> metrics.txt
```

## 🆘 Troubleshooting Guide

### Problem: Branch Push schlägt fehl mit 403

**Lösung:**
1. Prüfe Branch-Name (muss mit `claude/` beginnen)
2. Verwende git-push-with-retry.sh
3. Prüfe Repository Permissions

### Problem: Workflow timeout

**Lösung:**
1. Erhöhe timeout-minutes
2. Optimiere mit Caching
3. Nutze parallel jobs

### Problem: API Rate Limits

**Lösung:**
1. Implementiere Rate-Limit-Detection
2. Füge delays zwischen API-Calls hinzu
3. Nutze conditional API calls

---

**Maintainer:** Factory AI Bot
**Letzte Aktualisierung:** 2025-11-04
**Version:** 2.0.0
