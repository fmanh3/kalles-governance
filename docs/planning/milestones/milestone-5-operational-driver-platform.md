# Milstolpe 5: Den Operativa Förarplattformen

## Status: Slutförd ✅ (April 2026)

## Mål
Att transformera förarapplikationen från en statisk vy till ett operativt verktyg med djup integration mot HR och Traffic, vilket möjliggör fullständig hantering av arbetsdagen.

## Prestationer

### 1. HR: Utökad Planering & Frånvaro
*   [x] Uppdaterat databas-schema för att stödja `pickup_location` och `leave_requests`.
*   [x] Implementerat API-endpoints för att hämta förarens hela schema.
*   [x] Etablerat auto-seeding för testföraren `DRIVER-007`.

### 2. Traffic: Fordonspark & Digital Tvilling (Level 1)
*   [x] Skapat ett fordonsregister (Statiska metamodellen) med batterikapacitet och kravprofil.
*   [x] Implementerat realtidsstatus (Dynamisk tvilling) i molndatabasen.
*   [x] Exponerat fordonsdata via BFF.

### 3. Customer Success: Den Interaktiva Appen
*   [x] **v1.5 Portal:** Implementerat flik-baserad navigering (IDAG, SCHEMA, FORDON).
*   [x] **Visual Feedback:** Lagt till tydlig feedback vid incheckning (grön knapp).
*   [x] **Live Data:** Kopplat frontenden till moln-BFF:en utan mockar.

### 4. Molninfrastruktur (GCP)
*   [x] Aktiverat **Cloud SQL Admin API**.
*   [x] Konfigurerat **Unix Sockets** för stabila databasanslutningar.
*   [x] Fullständig utrullning av samtliga 5 tjänster till Cloud Run.

## DoD (Definition of Done)
*   Föraren kan se samtliga pass i en kalender. ✅
*   Knappen "Sjukanmäl" är kopplad till HR-tjänsten. ✅
*   Föraren kan se batteristatus och typ på bussen de ska köra. ✅
*   Data hämtas live från molnet för testanvändaren `DRIVER-007`. ✅

