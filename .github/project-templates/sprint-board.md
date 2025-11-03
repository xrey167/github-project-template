# Sprint Board Vorlage

Diese Vorlage beschreibt eine empfohlene GitHub Projects (Beta) Sprint-Board-Konfiguration. Kopiere die Inhalte in ein neues Projekt-Board, um ein konsistentes Sprint-Setup sicherzustellen.

## 📁 Grundstruktur

| Spalte | Zweck |
| --- | --- |
| 📝 Backlog | Langfristige Ideen & ungeplante Anforderungen |
| 🎯 Sprint Backlog | Verpflichtete Tickets für den aktuellen Sprint |
| 🚧 In Progress | Tickets mit aktiver Bearbeitung |
| ✅ Code Review | Fertige Tickets, die auf Review warten |
| 🧪 QA / Testing | Tickets im Test oder zur Abnahme |
| 🎉 Done | Abgeschlossene Tickets (Definition of Done erfüllt) |

## ⚙️ Attribute (Project Fields)

| Feld | Typ | Beschreibung |
| --- | --- | --- |
| Status | Single Select | Werte: Backlog, Sprint Backlog, In Progress, Code Review, QA / Testing, Done |
| Team | Single Select | Zuordnung zu Funktions-Teams (z. B. Frontend, Backend, DevOps) |
| Priorität | Single Select | Werte: High, Medium, Low |
| Sprint | Iteration | Zweiwöchige Sprints (Start / Enddatum pflegen) |
| Story Points | Number | Aufwandsschätzung in Story Points |
| Blocker | Text | Kurze Beschreibung aktueller Blocker |

## 🔄 Automatisierungen

1. **Status über Label synchronisieren**  
   Nutze das Workflow "Auto Assign" (`.github/workflows/auto-assign.yml`), um bei Label-Änderungen automatische Zuordnungen vorzunehmen.

2. **Spaltenwechsel automatisieren**  
   - Pull Request geöffnet → Status = `Code Review`  
   - Pull Request gemerged → Status = `Done`  
   - CI fehlgeschlagen → Kommentar und Status = `In Progress`

3. **Sprint-Rollover**  
   Nutze das Iterationsfeld, um Tickets automatisch in den nächsten Sprint zu verschieben, falls sie nicht abgeschlossen wurden.

## 🚀 Setup-Schritte

1. Neues Projekt im gewünschten GitHub-Repository erstellen (`Projects` → `New project`).
2. Unter *Templates* auf **Import from clipboard** klicken und die Tabellen & Automations aus diesem Dokument verwenden.
3. Die gewünschten Board-Spalten anlegen und oben genannte Project Fields hinzufügen.
4. Optional: Automatische Regeln erstellen (`Project` → `Workflows`), um Statuswechsel zu automatisieren.
5. In der `auto-assign.yml` das Feld `project-url` auf die URL des neuen Boards anpassen.

## ✅ Definition of Done pro Ticket

- Akzeptanzkriterien erfüllt & dokumentiert
- Tests (Unit / Integration) wurden erfolgreich ausgeführt
- Code Review & QA sind abgeschlossen
- Dokumentation (falls nötig) aktualisiert
- Deployment vorbereitet bzw. durchgeführt

Nutze dieses Board als Ausgangspunkt und passe Spalten, Felder und Automatisierungen an die Bedürfnisse deines Teams an.
