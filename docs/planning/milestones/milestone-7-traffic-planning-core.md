# Milstolpe 7: Autonom Trafikplanering & Störningshantering

## Status: Påbörjad 🏃‍♂️

## Mål
Att transformera systemet från att bara registrera data till att aktivt planera, optimera och självläka verksamheten genom autonoma agenter.

## Fokusområden

### 1. Traffic: Tidtabell & Omlopp
*   [ ] Ingestion-motor för SL GTFS/NeTEx (simulerad v1).
*   [ ] Implementera `Omlopps-agent` med BEV-optimering (SoC, Temp, Degradation).
*   [ ] Logik för att hantera trasig laddinfrastruktur.

### 2. HR: Autonom Bemaning
*   [ ] Implementera `Bemannings-agent` för automatisk förartilldelning.
*   [ ] Bygga flöde för autonom störningshantering vid sjukdom (SMS-simulering).

### 3. Underhåll & FMS
*   [ ] Normalisering av telemetridata (Agnostisk FMS).
*   [ ] Automatiserad bokning av besiktning baserat på mätarställning och datum.

## DoD (Definition of Done)
*   Tidtabeller kan läsas in och konverteras till interna turer.
*   Omlopp skapas automatiskt med hänsyn till BEV-parametrar.
*   Sjukanmälan triggar en autonom process som hittar och tilldelar en ersättare.
*   Alla flöden är verifierade i molnmiljön.
