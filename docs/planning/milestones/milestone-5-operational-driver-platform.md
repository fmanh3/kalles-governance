# Milstolpe 5: Den Operativa Förarplattformen

## Status: Planerad 🗓️

## Mål
Att transformera förarapplikationen från en statisk vy till ett operativt verktyg med djup integration mot HR och Traffic, vilket möjliggör fullständig hantering av arbetsdagen.

## Fokusområden

### 1. HR: Utökad Planering & Frånvaro
*   [ ] Uppdatera databas-schema för att stödja semestrar och ledighetsansökningar.
*   [ ] Implementera API-endpoints för att hämta förarens hela schema (månadsvy).
*   [ ] Bygga logik för att hantera digital incheckning och "On Duty"-status.

### 2. Traffic: Fordonspark & Realtid
*   [ ] Skapa ett fordonsregister med metadata (typ, kapacitet, krav).
*   [ ] Exponera realtids-SOC och position via BFF för den specifika buss en förare ska ta över.
*   [ ] Definiera överlämningspunkter (Handover points) på linje 676.

### 3. Customer Success: Den Interaktiva Appen
*   [ ] **Kalender-komponent:** Implementera en interaktiv kalender i React.
*   [ ] **Detaljvyer:** Skapa "modaler" eller undersidor för fordonsinfo och passdetaljer.
*   [ ] **API-integration:** Koppla knapparna (Incheckning, Sjuk, Ledighet) till riktiga anrop genom BFF till domäntjänsterna.

## DoD (Definition of Done)
*   Föraren kan se samtliga pass i en kalender.
*   Knappen "Sjukanmäl" uppdaterar status i databasen live.
*   Föraren kan se batteristatus och typ på bussen de ska köra.
*   Pipelinen i GitHub verifierar den nya interaktiva logiken.
