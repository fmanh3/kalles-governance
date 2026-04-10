# Use Cases: Trafikplanering och Omlopp (v2.0)

## UC-TR-05: Automatisk Tidtabellsimport
**Beskrivning:** Systemet importerar SL:s data och beräknar peak-behov.

### Gherkin Scenario
```gherkin
Feature: Tidtabellsingestion
  Scenario: Automatisk import av ny vintertidtabell
    Given en ny "Vintertidtabell" publiceras på SL:s API via "NeTEx"
    When "Integrations-agenten" validerar datamängden för "Linje 676"
    Then skapas en intern representation av alla avgångar
    And systemet beräknar Peak Requirement till "18 fordon"
```

## UC-TR-06: BEV-medveten Omloppsplanering
**Beskrivning:** Agenten bygger omlopp som tar hänsyn till kyla och laddningskurvor.

### Gherkin Scenario
```gherkin
Feature: Vehicle Scheduling
  Scenario: Skapande av ett säkert elbuss-omlopp vid kyla
    Given en lista med avgångar för "Linje 676"
    And fordonstyp "Buss 8042" med specifik laddningskurva
    And väderprognos indikerar "-5 grader"
    When "Omlopps-agenten" pusslar ihop avgångarna
    Then planeras "Snabbladdning 15 minuter vid Tekniska" in varannan tur
    And SoC understiger aldrig "15%"
    And laddtid synkroniseras med "Förarens lagstadgade rast"
```
