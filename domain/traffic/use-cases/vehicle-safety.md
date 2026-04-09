# Use Cases: Fordon och Säkerhet (Traffic)

## UC-TR-03: Räckviddsanalys (BEV Digital Twin)
**Beskrivning:** Systemet beräknar räckvidd baserat på batterihälsa, laddning och yttertemperatur.

### Gherkin Scenario
```gherkin
Feature: BEV Range Analysis
  Scenario: Utvärdering av batteristatus vid minusgrader
    Given att "BUSS-101" har en aktuell SoC på "85%"
    And batteridegraderingen är "4%"
    And väderprognosen indikerar "-5 grader"
    When AI-agenten beräknar räckvidden för "Linje 676" tur och retur (140 km)
    Then ska systemet uppskatta räckvidden till "180 km"
    And systemet ska markera räckvidden som "Godkänd (Grön)" för passet
    And systemet ska visa kompatibla laddnätverk: "OppCharge Tekniska, CCS2 Norrtälje"
```

## UC-TR-04: Daglig Säkerhetskontroll
**Beskrivning:** Föraren loggar fordonets status innan avfärd.

### Gherkin Scenario
```gherkin
Feature: Säkerhetskontroll
  Scenario: Genomförande av kontroll med anmärkning
    Given att jag står vid "BUSS-101"
    When jag utför "Säkerhetskontroll" i appen
    And jag markerar "Däck", "Bromsar" som "Godkända"
    And jag markerar "Vindrutetorkare" som "Defekt"
    And jag fyller i "Vänster fram lämnar ränder"
    Then sparas kontrollen med tidsstämpel
    And en händelse "VehicleInspectionReported" skickas till depå-agenten
```
