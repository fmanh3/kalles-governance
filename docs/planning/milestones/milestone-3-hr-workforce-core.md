# Milstolpe 3: HR & Workforce Core

## Status: Påbörjad 🏃‍♂️

## Mål
Att etablera en regelstyrd HR-plattform som hanterar personalplanering, regelefterlevnad (kör- och vilotider) och automatiserad lönehantering.

## Fokusområden

### 1. Compliance & Guardrails
*   [ ] Implementera motor för kontroll av dygns- och veckovila.
*   [ ] Integrera HR-kontrollen som en blockerande händelse i planeringsflödet.

### 2. Workforce Planning
*   [ ] Skapa datamodell för förare, tjänster (shifts) och stationeringsorter.
*   [ ] Möjliggöra koppling mellan förare och buss via Pub/Sub händelser.

### 3. Payroll Engine (Version 1.0)
*   [ ] Implementera logik för grundläggande OB-tillägg enligt kollektivavtal.
*   [ ] Hantering av övertid och garantilön.

### 4. Frånvarohantering
*   [ ] Implementera flöde för sjukanmälan och dess påverkan på schemat.

## DoD (Definition of Done)
*   HR-förmågor är dokumenterade och godkända i Governance.
*   Kör- och vilotider valideras automatiskt mot Gherkin-scenarier.
*   Löneunderlag genereras korrekt baserat på utförda pass.
*   Tjänsten är driftsatt i GCP Cloud Run och kommunicerar via Pub/Sub.
