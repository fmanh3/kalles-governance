# Milstolpe 2: Finansiell Grundplatta

## Status: Påbörjad 🏃‍♂️

## Mål
Att etablera de fundamentala ekonomiska funktionerna i systemet, med fokus på precision, spårbarhet och automatiserad fakturering.

## Fokusområden

### 1. Förmågor och Use Cases (Governance)
*   [x] Kartlägga finansiella förmågor (Huvudbok, Reskontra, Likviditet).
*   [x] Definiera Use Cases och Gherkin-scenarier för testning.
*   [ ] Etablera enhetstest-ramverk för finansiell logik.

### 2. Billing Engine & Contracts
*   [ ] Implementera kontraktshantering för linje 676 (km-tariffer + bonusar).
*   [ ] Automatisera fakturaskapande baserat på `TrafficTourCompleted` händelser.

### 3. Inre och Yttre Ringen (Fakturaingestion)
*   [ ] Designa kontraktet för "Inre ringen" (standardiserat fakturaformat).
*   [ ] Implementera en Gateway för att transformera externa fakturor till det interna formatet.

### 4. Reskontra & Betalning
*   [ ] Skapa register för kunder och leverantörer.
*   [ ] Implementera grundläggande betalningsbevakning mot bankflöden.

## DoD (Definition of Done)
*   Ekonomiska flöden är dokumenterade i Governance.
*   Fakturor kan genereras automatiskt från trafik-events.
*   Finansiell logik är verifierad med enhetstester baserade på Gherkin-scenarier.
*   Data sparas persistent i Cloud SQL.
