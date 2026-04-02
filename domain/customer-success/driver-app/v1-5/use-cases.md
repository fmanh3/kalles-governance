# Use Cases: Den Operativa Förarplattformen (v1.5)

## UC-DRV-04: Fullständig Kalender & Tjänstelista
**Beskrivning:** Föraren kan se alla sina tilldelade pass för innevarande och kommande månad, inklusive pick-up punkter.

### Gherkin Scenario
```gherkin
Feature: Förarkalender
  Scenario: Se kommande arbetspass
    Given driver "STINA-01" is logged in
    And has 3 assigned shifts in the next 7 days
    When I open the Calendar View
    Then I should see "3" shifts highlighted
    And clicking a shift should show "Start/Slut tid", "Linje 676" and "Pick-up: Norrtälje RC"
```

## UC-DRV-05: Fordonsmetadata & Check-in
**Beskrivning:** Innan passets start kan föraren se detaljerad info om tilldelad buss och utföra en digital check-in.

### Gherkin Scenario
```gherkin
Feature: Fordonskontroll & Incheckning
  Scenario: Kontrollera bussens status innan körning
    Given I am at pick-up location "Norrtälje RC"
    And bus "BUSS-101" is assigned to my shift
    When I select the bus in the app
    Then I should see "State of Charge: 85%"
    And "Kapacitet: 55 passagerare"
    And "Typ: Ledbuss (El)"
    And clicking "Check-in" should update my status to "ON_DUTY"
```

## UC-DRV-06: Ledighetsansökan & Sjukanmälan
**Beskrivning:** Interaktiv hantering av frånvaro som direkt påverkar HR-databasen.

### Gherkin Scenario
```gherkin
Feature: Frånvarohantering
  Scenario: Ansöka om semester
    Given I want to be off between "2026-06-01" and "2026-06-14"
    When I submit a "Leave Request" in the app
    Then a new request should be created in the HR system with status "PENDING"
    And my manager should be notified
```
