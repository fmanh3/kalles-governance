# Milstolpe 3: HR & Workforce Core

## Status: Slutförd ✅ (April 2026)

## Mål
Att etablera en regelstyrd HR-plattform som hanterar personalplanering, regelefterlevnad (kör- och vilotider) och automatiserad lönehantering.

## Prestationer

### 1. Compliance & Guardrails
*   [x] Implementerat motor (`DailyRestPolicy`) för kontroll av 11 timmars dygnsvila.
*   [x] Integrerat HR-kontrollen som en blockerande guardrail i händelseflödet vid pass-tilldelning.

### 2. Workforce Planning
*   [x] Skapat datamodell för förare, tjänster (shifts), tidsloggar och OB-satser.
*   [x] Etablerat koppling mellan förare och pass i molndatabasen.

### 3. Payroll Engine (Version 1.0)
*   [x] Implementerat `PayrollEngine` för automatisk beräkning av grundlön och OB-tillägg (Kväll, Natt, Helg) enligt kollektivavtal.
*   [x] Möjliggjort beräkning av bruttolön baserat på faktiskt arbetade timmar.

### 4. Frånvarohantering
*   [x] Implementerat simulator-endpoint för sjukanmälan som automatiskt avbokar planerade pass.

## DoD (Definition of Done)
*   HR-förmågor är dokumenterade och godkända i Governance. ✅
*   Kör- och vilotider valideras automatiskt mot Gherkin-scenarier. ✅
*   Löneunderlag kan genereras korrekt baserat på utförda pass. ✅
*   Tjänsten är driftsatt i GCP Cloud Run och kommunicerar via Pub/Sub. ✅

