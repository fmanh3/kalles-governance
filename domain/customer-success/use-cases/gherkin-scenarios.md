# Use Cases: Portals (CEO & Driver)

Dessa use cases definierar hur användare interagerar med systemet via frontend.

## UC-CS-01: VD-översikt (Finansiell status)
**Aktör:** VD (CEO)
**Scenario:** Se aktuell likviditet och utestående fakturor.

### Gherkin Scenario
```gherkin
Feature: CEO Dashboard
  As a CEO
  I want a unified view of our financial health
  So that I can make strategic decisions

  Scenario: Visa aktuell likviditetsställning
    Given the Finance domain has "500,000" SEK in bank
    And there are outstanding customer invoices of "150,000" SEK
    When I open the CEO Portal
    Then I should see "Total Liquidity: 650,000 SEK"
    And I should see a list of the "5" latest unpaid invoices
```

## UC-CS-02: Förar-schema och Sjukfrånvaro
**Aktör:** Förare (Driver)
**Scenario:** Se schema och anmäla sjukdom.

### Gherkin Scenario
```gherkin
Feature: Driver Self-Service
  As a Driver
  I want to see my schedule and report sickness easily
  So that I don't have to call into the office

  Scenario: Sjukanmälan via mobilen
    Given I have a shift "SHIFT-101" starting at "08:00" today
    When I click "Report Sick" in the Driver App
    Then my shift "SHIFT-101" should be updated to status "SICK"
    And I should see a confirmation "Sick leave registered"
    And the HR system should automatically trigger a notification to Traffic Control
```

## UC-CS-03: Real-tids Fleet Map
**Aktör:** Ledning / Trafikledare
**Scenario:** Se var bussarna befinner sig.

### Gherkin Scenario
```gherkin
Feature: Live Fleet Map
  Scenario: Se bussens rörelse på kartan
    Given bus "BUSS-101" is currently on tour "TOUR-676"
    And it just published position "59.350, 18.070"
    When I view the Fleet Map in the Portal
    Then I should see "BUSS-101" at coordinates "59.350, 18.070"
    And its status should be "ON_TIME"
```
