# ADR 006: BEV Digital Twin & Rotation Strategy

## Status
**Föreslagen** (2026-04-02)

## Kontext
Drift av elbussar kräver en tät koppling mellan fordonets fysiska förmåga och det operativa schemat. Faktorer som väder (temperatur), topografi och laddinfrastruktur påverkar räckvidden dynamiskt. För att stödja framtida optimering krävs en modell som kan hantera både statiska egenskaper och realtidsdata.

## Beslut
Vi inför begreppet **Digital Tvilling** för varje fordon i systemet. Modellen delas upp i två delar:

### 1. Statisk Metamodell (The Identity)
Lagras i Traffic-domänens fordonsregister:
*   **Batterikapacitet (kWh):** Nominell och användbar.
*   **Modellspecifik förbrukning (kWh/km):** Baslinje vid standardförhållanden.
*   **Laddningskurva:** Max effekt vid olika SoC-nivåer.
*   **Kravprofil:** Behöver föraren specifik utbildning (t.ex. ledbuss-cert)?

### 2. Dynamisk Tvilling (The State)
Uppdateras via telemetri från simulatorn/bussen:
*   **Current SoC (%):** Aktuell laddnivå.
*   **Estimated Range (km):** Beräknad kvarvarande räckvidd baserat på nuvarande förbrukning och **yttertemperatur**.
*   **Health Status:** Eventuella larm som påverkar omloppet.

## Strategi för Omloppssynkronisering
*   **Initialt (Milstolpe 5):** Vi använder statiska omlopp där buss och förare följer en förbestämd plan.
*   **Framtida tillväxt:** Omloppen ska kunna "brytas" och omplaneras dynamiskt om en buss räckvidd understiger nästa planerade körtur + säkerhetsmarginal (t.ex. 20% SoC).

## Konsekvenser
*   **Traffic-domänen** måste kunna ta emot väderdata (temperatur) som en parameter i räckviddsberäkningen.
*   **BFF:en** ska aggregera både förarens pass och bussens dynamiska status för att ge föraren en varning om energin inte räcker för hela passet.
