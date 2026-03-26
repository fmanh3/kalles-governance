# ADR-004: Dynamisk Prissättningsmodell för Kollektivtrafik (Trafikavtal)

**Datum:** 2026-03-26
**Status:** Godkänd
**Domän:** Finance (Billing Engine)

## Bakgrund
Svensk upphandlad kollektivtrafik bygger sällan på en fast ersättning per kilometer. Uppdragsgivare som SL, Västtrafik och Skånetrafiken använder komplexa incitamentsavtal med flera rörliga komponenter. För att systemet ska vara skalbart måste vår datamodell klara av:
1. **Grundpriser:** Varierande kilometerpris baserat på fordonstyp (el, biogas, diesel) och linje.
2. **Tidsbaserade tillägg:** Olika tariffer för OB (Obekväm arbetstid), helgdagar/röda dagar och natt-trafik.
3. **Resandeincitament:** Bonus per påstigande resenär, baserat på APC-data (Automatic Passenger Counting) ofta från Trafiklab.
4. **Kvalitetsviten och incitament:** Avdrag för inställda turer, förseningar eller bristande komfort (t.ex. trasig AC eller bristande punktlighet).

## Beslut
Vi bygger ut tabellen `tariffs` i Billing Engine med ett avancerat, JSONB-baserat regelverk (`pricing_rules`). Vi implementerar en regelmotor i koden som evaluerar `TrafficTourCompleted` (och potentiellt kompletterande data som passagerarantal från Trafiklab) mot avtalets aktuella regler.

### Struktur för `pricing_rules` (JSONB)
*   **Time-based Multipliers:** Regler för helg och OB (t.ex. `"weekend_multiplier": 1.25`).
*   **Vehicle Modifiers:** Modifikatorer för fordonsegenskaper (t.ex. `"electric_bonus_per_km": 5.0`).
*   **Passenger Incentives:** Ersättning per påstigande (t.ex. `"boarding_bonus_per_passenger": 1.5`).

## Konsekvenser
*   **Komplexitet:** Beräkningsmotorn måste nu vara medveten om kalendern (t.ex. veta när det är röd dag i Sverige) och kunna slå upp fordonets egenskaper utifrån ID:t vid beräkningstillfället.
*   **Flexibilitet:** Systemet kan representera i stort sett alla svenska trafikavtal utan kodändringar per avtal, vilket möjliggör "Transport-as-Code" och förenklar expansion till nya regioner.
