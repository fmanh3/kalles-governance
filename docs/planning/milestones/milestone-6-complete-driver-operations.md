# Milstolpe 6: Den Kompletta Förarupplevelsen

## Status: Påbörjad 🏃‍♂️

## Mål
Att leverera ett operativt system som täcker förarens alla behov: profilhantering, behörighetskontroll, fordonsstatus (BEV), dynamisk ruttinformation och interaktiv planering.

## Fokusområden

### 1. HR: Profil & Kvalifikationer
*   [ ] Utöka `drivers` databas med anställningsinfo, ICE och bankdata.
*   [ ] Implementera `certifications`-tabell (D-körkort, YKB, Typ-utbildning).
*   [ ] Bygga API för att exponera förarens profil och licensstatus.

### 2. Traffic: Fordon, Säkerhet & BEV-analys
*   [ ] Utöka `vehicles` med fysiska mått, mätarställning och batteridegradering.
*   [ ] Implementera `safety_inspections` logg med händelsestyrd koppling till depå.
*   [ ] Bygga räckvidds-agent (Level 2 Digital Twin) som tar hänsyn till väder/temperatur.

### 3. Customer Success: Den Operativa Appen (v2.0)
*   [ ] **Profil-vy:** Sida för anställningsdata och licenser.
*   [ ] **Inspektions-flöde:** Interaktiv checklista för säkerhetskontroll.
*   [ ] **Rutt-vy:** Integration av Leaflet-karta med ruttlinje och trafikvarningar (Trafikverket API).
*   [ ] **Ladd-vy:** Visualisering av laddningskurva och beräknad SoC vid avgång.

## DoD (Definition of Done)
*   Föraren kan se sin fullständiga profil och licensstatus.
*   Säkerhetskontrollen loggas och triggar depå-händelser.
*   Räckvidd beräknas dynamiskt baserat på parametrar (SoC, Temp, Degradation).
*   Appen visar rutt på karta med realtidsstörningar.
*   All data är synkad i molnet och verifierad i GCP.
