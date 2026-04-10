# Use Cases: CFO Agent Intelligence (Milestone 8)

Dessa use cases driver den intelligenta logiken i Finance-domänens agenter.

## UC-FIN-04: Proaktiv Likviditetsvarning
**Aktör:** Treasury-Agent
**Beskrivning:** Prognostisera kassaflödesbrist inför löneutbetalning.

### Gherkin Scenario
```gherkin
Feature: Proaktiv Likviditetsplanering
  As a CFO Agent
  I want to forecast cash flow shortages
  So that the CEO can take action before we default on payments

  Scenario: Identifiera likviditetsbrist inför lönekörning
    Given the current cash balance is "1 500 000 SEK"
    And upcoming approved AP invoices before the 25th total "800 000 SEK"
    And the preliminary Payroll run for the 25th totals "1 200 000 SEK"
    And no incoming SL payments are scheduled before the 26th
    When the "Treasury-Agent" runs the daily liquidity forecast
    Then a "LiquidityWarningEvent" should be published
    And the agent should propose a mitigation strategy: "Pausa betalning av faktura INV-992 (E.ON) till förfallodagen"
    And the CEO dashboard should display a critical alert
```

## UC-FIN-05: Autonomt Månadsbokslut och Periodisering
**Aktör:** Reporting-Agent
**Beskrivning:** Automatisk periodisering av intäkter vid månadsskifte.

### Gherkin Scenario
```gherkin
Feature: Autonomt Månadsbokslut
  Scenario: Periodisering av obetalda SL-intäkter vid månadsskifte
    Given the date is the "last day of the month"
    When the "Reporting-Agent" initiates the month-end close
    And queries the "Billing Engine" for completed but unbilled tours
    Then the agent calculates the accrued revenue to "450 000 SEK"
    And creates a ledger entry: Debit "1790 (Upplupna intäkter)", Credit "3000 (Försäljning)"
```

## UC-FIN-06: Automatiserat Bestridande av Viten
**Aktör:** Controlling-Agent
**Beskrivning:** Matcha SL-viten mot trafikloggar för att identifiera felaktiga avdrag.

### Gherkin Scenario
```gherkin
Feature: Viteshantering och Intäktssäkring
  Scenario: Bestridande av vite pga extremt väder
    Given an incoming deduction note from SL for "Delayed Tour TOUR-123" amounting to "5000 SEK"
    When the "Controlling-Agent" queries the Traffic Domain for "TOUR-123"
    And finds an incident log: "Extreme weather / Road blocked by snow"
    Then the agent should categorize the penalty as "Force Majeure"
    And automatically draft a dispute email to SL quoting contract paragraph "4.2.1"
```

## UC-FIN-07: Dynamisk Avskrivning av Batterier
**Aktör:** Reporting-Agent / Asset Manager
**Beskrivning:** Avskrivning baserad på faktisk batteridegradering.

### Gherkin Scenario
```gherkin
Feature: Värdering av Anläggningstillgångar
  Scenario: Avskrivning baserad på faktisk batteridegradering
    Given an asset "BUSS-101" with a current booked value of "3 000 000 SEK"
    When the "Reporting-Agent" performs month-end asset valuation
    And fetches telemetry data showing "0.5% battery degradation" over the month
    Then the agent calculates the monthly depreciation to "15 000 SEK"
    And records a ledger entry: Debit "7830 (Avskrivningar)", Credit "1249 (Ackumulerade avskrivningar)"
```
