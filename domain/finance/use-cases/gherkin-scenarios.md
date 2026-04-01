# Use Cases: Finance Domain

Dessa use cases fungerar som grund för vårt Gherkin-baserade ramverk för enhetstester.

## UC-FIN-01: Automatiserad Fakturering av Körtur
**Aktör:** Billing Engine
**Förmåga:** Accounts Receivable
**Beskrivning:** När en tur avslutas ska systemet automatiskt generera ett fakturaunderlag baserat på avtalade tariffer och bonusar.

### Gherkin Scenario
```gherkin
Feature: Automatiserad Fakturering
  As a CFO
  I want completed bus tours to result in an invoice
  So that I can maintain a positive cash flow

  Scenario: Lyckad fakturering av avslutad tur
    Given an active contract exists for line "676" with tariff "15.00" SEK/km
    And a passenger bonus of "2.00" SEK per boarding exists
    When a "TrafficTourCompleted" event is received for tour "TOUR-123"
    And the tour distance was "73" km
    And there were "25" total boardings
    Then a new invoice should be created in the ledger
    And the total amount should be "1145.00" SEK
    And the invoice status should be "PENDING_PAYMENT"
```

## UC-FIN-02: Matchning av Inbetalning (Bankgirot)
**Aktör:** Bank Gateway
**Förmåga:** Treasury / Accounts Receivable
**Beskrivning:** Inkommande filer från Bankgirot ska automatiskt stämmas av mot utestående kundfakturor.

### Gherkin Scenario
```gherkin
Feature: Bankavstämning
  As a Treasurer
  I want incoming bank payments to be matched against invoices
  So that I know which customers have paid

  Scenario: Automatisk matchning av full betalning
    Given an outstanding invoice "INV-500" exists with amount "1145.00" SEK
    When a payment file is received from "Bankgirot"
    And the file contains a payment of "1145.00" SEK with reference "INV-500"
    Then the invoice "INV-500" should be marked as "PAID"
    And a matching entry should be created in the General Ledger
    And the cash account balance should increase by "1145.00" SEK
```

## UC-FIN-03: Inläsning av Leverantörsfaktura (Yttre Ring)
**Aktör:** Invoicing Gateway
**Förmåga:** Accounts Payable
**Beskrivning:** En inkommande PDF eller e-faktura ska valideras och konverteras till det interna standardformatet.

### Gherkin Scenario
```gherkin
Feature: Fakturaingestion
  Scenario: Validering av inkommande PDF
    Given a raw invoice file is received via email
    When the Invoicing Gateway parses the file
    Then it should extract vendor "Scania Verkstad AB"
    And the total amount "5000.00" SEK including "1000.00" SEK VAT
    And the internal "Inner Ring" invoice command should be published to the bus
```
