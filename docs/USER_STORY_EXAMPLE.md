# Beispiel User Story

Dieses Dokument zeigt ein vollständiges Beispiel einer gut geschriebenen User Story für den Factory AI Workflow.

## Gutes Beispiel

### Titel
```
[Story]: Als eingeloggter Benutzer möchte ich mein Passwort ändern können, damit ich meine Kontosicherheit verwalten kann
```

### Epic/Feature
```
Benutzer-Authentifizierung und Sicherheit
```

### User Story
```
Als eingeloggter Benutzer
möchte ich mein Passwort ändern können
damit ich meine Kontosicherheit verwalten kann und mein Konto schützen kann, wenn ich vermute, dass mein Passwort kompromittiert wurde
```

### Akzeptanzkriterien
```markdown
- [ ] Benutzer kann im Profil-Menü auf "Passwort ändern" klicken
- [ ] Ein Modal/Formular öffnet sich mit drei Feldern: "Aktuelles Passwort", "Neues Passwort", "Neues Passwort bestätigen"
- [ ] System validiert, dass das aktuelle Passwort korrekt ist
- [ ] System validiert, dass das neue Passwort den Sicherheitsanforderungen entspricht (mindestens 8 Zeichen, ein Großbuchstabe, eine Zahl, ein Sonderzeichen)
- [ ] System validiert, dass "Neues Passwort" und "Neues Passwort bestätigen" übereinstimmen
- [ ] Bei erfolgreicher Änderung wird eine Bestätigungsmeldung angezeigt
- [ ] Bei erfolgreicher Änderung wird eine Benachrichtigungs-Email an die registrierte Email-Adresse gesendet
- [ ] Bei fehlerhafter Eingabe werden klare Fehlermeldungen angezeigt
- [ ] Das Modal kann mit "Abbrechen" geschlossen werden ohne Änderungen zu speichern
```

### Story Points
```
5 (Mittlerer Aufwand - ca. 1-2 Tage)
```

### Priorität
```
Must Have
```

### Abhängigkeiten
```
#42 (Benutzer-Authentifizierung muss implementiert sein)
#56 (Email-Service muss konfiguriert sein)
```

### Definition of Done
```markdown
- [ ] Code Review von mindestens 2 Entwicklern
- [ ] Unit Tests mit mindestens 80% Coverage
- [ ] Integration Tests für den kompletten Flow
- [ ] E2E Test für UI-Interaktion
- [ ] Dokumentation im API-Docs aktualisiert
- [ ] Sicherheitsreview abgeschlossen (keine kritischen Schwachstellen)
- [ ] Accessibility-Check durchgeführt (WCAG 2.1 Level AA)
```

### Technische Notizen
```markdown
**API Endpunkt:**
- POST /api/user/change-password
- Request Body: { currentPassword: string, newPassword: string }
- Response: { success: boolean, message: string }

**Betroffene Komponenten:**
- Frontend: ProfileMenu.tsx, ChangePasswordModal.tsx
- Backend: UserService.ts, PasswordService.ts, EmailService.ts
- Validation: PasswordValidator.ts

**Sicherheitsaspekte:**
- Passwort muss mit bcrypt gehashed werden (Salt rounds: 12)
- Rate Limiting: Max 5 Versuche pro 15 Minuten
- Aktuelles Passwort muss verifiziert werden bevor Änderung
- Session invalidation bei Passwortänderung (außer aktuelle Session)

**UI/UX Überlegungen:**
- Passwort-Stärke-Anzeige (schwach/mittel/stark)
- "Passwort anzeigen" Toggle für alle Felder
- Klare Validierungs-Hinweise in Echtzeit
- Erfolgs-Animation bei erfolgreicher Änderung
```

---

## Schlechtes Beispiel (NICHT SO!)

### Titel ❌
```
[Story]: Passwort Sachen
```

### User Story ❌
```
Als Benutzer möchte ich Passwort ändern können
```

### Akzeptanzkriterien ❌
```markdown
- [ ] Passwort ändern funktioniert
- [ ] Es sieht gut aus
```

### Warum ist das schlecht?

1. **Unklarer Titel:** "Passwort Sachen" sagt nichts aus
2. **Keine Begründung:** Fehlendes "damit" - kein Business Value erkennbar
3. **Keine Details:** Keine spezifischen, testbaren Kriterien
4. **Nicht messbar:** "sieht gut aus" ist subjektiv und nicht überprüfbar

---

## Tipps für gute User Stories

### INVEST-Prinzip

Eine gute User Story ist:
- **I**ndependent (Unabhängig)
- **N**egotiable (Verhandelbar)
- **V**aluable (Wertvoll)
- **E**stimable (Schätzbar)
- **S**mall (Klein)
- **T**estable (Testbar)

### Format

Nutze immer das Format:
```
Als [Rolle]
möchte ich [Ziel]
damit [Nutzen/Business Value]
```

### Akzeptanzkriterien

Gute Akzeptanzkriterien sind:
- ✅ Spezifisch und konkret
- ✅ Testbar und messbar
- ✅ Aus Nutzersicht geschrieben
- ✅ Vollständig (alle wichtigen Szenarien abgedeckt)
- ✅ Mit klarem Erwartungswert

### Story Points Orientierung

- **1-2 Punkte:** Sehr kleine Änderung, wenige Stunden
  - Beispiel: Button-Text ändern, CSS-Anpassung

- **3 Punkte:** Kleine Änderung, halber Tag
  - Beispiel: Neues Formularfeld hinzufügen, einfache Validierung

- **5 Punkte:** Mittlere Änderung, 1-2 Tage
  - Beispiel: Neue Feature-Komponente, API-Integration

- **8 Punkte:** Größere Änderung, 2-3 Tage
  - Beispiel: Komplexes Feature mit mehreren Komponenten

- **13+ Punkte:** Sehr große Änderung - **sollte aufgeteilt werden!**
  - Beispiel: Komplette neue Module, große Refactorings

### Häufige Fehler vermeiden

❌ **Zu vage:**
```
- [ ] System funktioniert gut
```

✅ **Spezifisch:**
```
- [ ] System verarbeitet 1000 Anfragen pro Sekunde ohne Performance-Degradation
```

---

❌ **Technische Details statt User Value:**
```
Als Entwickler möchte ich Redis cachen implementieren
```

✅ **User Value fokussiert:**
```
Als Benutzer möchte ich, dass die Produktsuche in unter 1 Sekunde lädt, damit ich schneller einkaufen kann
```

---

❌ **Zu groß und nicht aufteilbar:**
```
Als Benutzer möchte ich ein komplett neues Dashboard mit allen Features
```

✅ **Aufgeteilt in kleinere Stories:**
```
Story 1: Als Benutzer möchte ich meine letzten 5 Aktivitäten im Dashboard sehen
Story 2: Als Benutzer möchte ich meine Statistiken als Chart im Dashboard sehen
Story 3: Als Benutzer möchte ich Quick-Actions im Dashboard haben
```

---

## Checkliste vor Story-Erstellung

Bevor du eine User Story erstellst, prüfe:

- [ ] Titel folgt dem Format: "[Story]: Als [Rolle] möchte ich [Ziel], damit [Nutzen]"
- [ ] User Story hat alle drei Teile: Als... möchte ich... damit...
- [ ] Mindestens 3 konkrete, testbare Akzeptanzkriterien definiert
- [ ] Story Points sind geschätzt (verwende Fibonacci: 1,2,3,5,8,13)
- [ ] Priorität ist gesetzt (Must/Should/Could/Won't Have)
- [ ] Label "user-story" ist gesetzt
- [ ] Abhängigkeiten sind identifiziert und verlinkt
- [ ] Technische Notizen enthalten konkrete Hinweise zur Implementierung
- [ ] Story ist klein genug um in einem Sprint umgesetzt zu werden

---

## Templates für verschiedene Story-Typen

### Frontend Feature
```
Als [Benutzerrolle]
möchte ich [UI-Element/Feature] sehen/nutzen
damit [Aufgabe einfacher wird / Ziel erreicht wird]

Akzeptanzkriterien:
- [ ] UI-Element wird an der richtigen Stelle angezeigt
- [ ] Interaktion funktioniert wie erwartet
- [ ] Responsive Design funktioniert auf allen Geräten
- [ ] Accessibility-Standards sind erfüllt
```

### Backend Feature / API
```
Als [System/Service/App]
möchte ich [Daten abrufen/verarbeiten/speichern]
damit [Funktionalität bereitgestellt werden kann]

Akzeptanzkriterien:
- [ ] API-Endpunkt ist verfügbar unter [URL]
- [ ] Request-Validierung funktioniert korrekt
- [ ] Response-Format entspricht der Spezifikation
- [ ] Error-Handling ist implementiert
- [ ] Performance-Anforderungen sind erfüllt
```

### Bug Fix
```
Als [Benutzerrolle]
möchte ich, dass [Problem] nicht mehr auftritt
damit [normale Nutzung möglich ist]

Akzeptanzkriterien:
- [ ] Bug ist reproduziert und verstanden
- [ ] Root Cause ist identifiziert
- [ ] Fix ist implementiert und getestet
- [ ] Regression Tests sind hinzugefügt
- [ ] Keine neuen Bugs eingeführt
```

### Performance Improvement
```
Als [Benutzerrolle]
möchte ich, dass [Feature/Seite] schneller lädt
damit [bessere User Experience]

Akzeptanzkriterien:
- [ ] Aktuelle Performance ist gemessen (Baseline)
- [ ] Ziel-Performance ist definiert (z.B. <2s Ladezeit)
- [ ] Optimierung ist implementiert
- [ ] Performance-Verbesserung ist messbar nachgewiesen
- [ ] Funktionalität bleibt unverändert
```

---

**Viel Erfolg beim Schreiben deiner User Stories! 🚀**

Bei Fragen oder Unklarheiten, siehe [`docs/FACTORY_AI_WORKFLOW.md`](./FACTORY_AI_WORKFLOW.md)
