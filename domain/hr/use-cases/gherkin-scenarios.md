# Use Cases: HR & Workforce

Dessa use cases definierar hur HR-domänen ska interagera med resten av systemet för att säkerställa regelefterlevnad.

## UC-HR-01: Validering av Dygnsvila (Compliance)
**Aktör:** Workforce Planning / Driver
**Beskrivning:** Systemet måste neka tilldelning av ett pass om föraren inte har haft minst 11 timmars sammanhängande vila sedan förra passets slut.

### Gherkin Scenario
```gherkin
Feature: Validering av Dygnsvila
  As an HR Manager
  I want to prevent drivers from being assigned shifts without legal rest
  So that we comply with EU safety regulations

  Scenario: Neka pass-tilldelning vid för kort vila
    Given driver "FÖRARE-007" completed a shift at "2026-03-26T22:00:00Z"
    When a request is made to assign shift "SHIFT-ABC" starting at "2026-03-27T06:00:00Z"
    Then the assignment should be "REJECTED"
    And the reason should be "Insufficient Daily Rest (8h < 11h required)"
```

## UC-HR-02: Automatisk OB-beräkning (Payroll)
**Aktör:** Payroll Engine
**Beskrivning:** Baserat på faktiskt utförd arbetstid ska systemet automatiskt generera löneunderlag med korrekt OB-ersättning.

### Gherkin Scenario
```gherkin
Feature: OB-beräkning
  Scenario: Beräkning av natt-OB
    Given a driver performed a shift from "2026-03-27T22:00:00Z" to "2026-03-28T06:00:00Z"
    And the collective agreement specifies "Night OB" between "22:00" and "06:00"
    When the payroll period is closed
    Then the payroll entry for the driver should include "8.0" hours of "Löneart 1205 (Natt-OB)"
```

## UC-HR-03: Hantering av Sjukfrånvaro
**Aktör:** Presence Gateway / Absence Management
**Beskrivning:** Vid sjukanmälan ska berörda pass flaggas som "OBEMANNAADE" och lönemotorn ska initiera sjuklöneberäkning (karensdag + 80%).

### Gherkin Scenario
```gherkin
Feature: Sjukanmälan
  Scenario: Sjukanmälan med kaskadeffekt
    Given driver "FÖRARE-008" is assigned to shift "SHIFT-123" today
    When "FÖRARE-008" reports sick starting now
    Then shift "SHIFT-123" should be marked as "UNSTAFFED"
    And a notification should be sent to the Traffic Control center
    And a sick leave entry should be created for "FÖRARE-008" in the Payroll system
```
