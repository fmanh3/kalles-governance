# Milstolpe 9: Det Optimerade Imperiet

## Status: Planerad 🗓️

## Mål
Att integrera Finance med den nya Energy-Depot domänen för att realisera kostnadsbesparingar via elpris-hedging och fördjupa bolagets lönsamhetsanalys (Unit Economics).

## Fokusområden

### 1. Energy-Depot Mikrotjänst
*   [ ] Etablera tjänsten `kalles-energy-depot`.
*   [ ] Implementera `ChargerAgent` som kan styra laddningscykler via events.
*   [ ] Datamodell för depå-platser och laddstatus.

### 2. CFO Agent: Energy Strategist
*   [ ] Logik för att hämta elpriser (Nordpool simulation).
*   [ ] Beslutsalgoritm för att optimera laddning vs. körtid.

### 3. Autonom Rapportering & Skatt
*   [ ] Momsredovisnings-modul (sammanställning av GL-poster).
*   [ ] SIE4-exportör för revision och skattedeklaration.

### 4. Unit Economics
*   [ ] Korsdomän-analys: Intäkt - Lön - El = Marginal per omlopp.

## DoD (Definition of Done)
*   En ny mikrotjänst (Energy-Depot) snurrar i GCP.
*   CFO-agenten kan beordra laddning baserat på simulerade elpriser.
*   Momsrapport genereras automatiskt vid månadsskifte.
*   GitHub är synkat med den nya domänen.
