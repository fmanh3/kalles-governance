# Use Cases: Driver Operations

## UC-DRV-01: Felanmälan från Förarapp
**Beskrivning:** Föraren agerar bolagets ögon och rapporterar skador via appen som maskinen inte kan upptäcka.

### Gherkin Scenario
```gherkin
Feature: Visuell Felanmälan
  Scenario: Förare rapporterar skadegörelse
    Given driver "DRIVER-007" is logged into the Driver App
    And is assigned to "BUSS-101"
    When the driver submits a "Damage Report" with category "Interior" and text "Trasigt säte 4B"
    Then the app publishes a "VehicleDamageReported" event
    And the driver UI confirms the report has been sent to Depot
```
