# Use Cases: HR & Bemanningsplanering (v2.0)

## UC-HR-06: Automatiserad Förartilldelning (Rostering)
**Beskrivning:** Systemet bemannar omlopp med rätt förare utifrån kompetens och lagkrav.

### Gherkin Scenario
```gherkin
Feature: Automated Rostering
  Scenario: Bemanning av dubbeldäckar-omlopp
    Given ett tomt omlopp för "Linje 676" som kräver "Fordonstyp: Dubbeldäckare"
    When "Bemannings-agenten" söker i HR-databasen
    Then filtreras förare utan "D-körkort", "YKB" eller "Typ-utbildning" bort
    And förare med vilotidsbrott exkluderas
    And omloppet tilldelas "DRIVER-007"
```

## UC-HR-07: Autonom ersättare vid sjukdom
**Beskrivning:** Agenten hanterar hela flödet från sjukanmälan till bekräftad ersättare.

### Gherkin Scenario
```gherkin
Feature: Disruption Management (HR)
  Scenario: Hitta ersättningsförare via SMS
    Given förare "DRIVER-007" registrerar sjukanmälan 04:30 för pass kl 06:00
    When "Störnings-agenten" aktiveras
    Then ändras passet till "UNSTAFFED"
    And erbjudande skickas sekventiellt till kandidat-lista
    When "CANDIDATE-02" svarar "JA"
    Then tilldelas passet till "CANDIDATE-02"
    And trafikledaren meddelas: "Pass 06:00 löst."
```
