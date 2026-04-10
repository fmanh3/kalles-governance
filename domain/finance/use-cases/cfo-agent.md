# Use Cases: CFO Agent Intelligence (Milestone 8 & 9)

## UC-FIN-08: Autonom 3-Way Matching av Reservdelar
**Beskrivning:** CFO-agenten i Finance-domänen validerar inkommande leverantörsfakturor mot Depåns inköpsordrar och varumottagning.

### Gherkin Scenario
```gherkin
Feature: Automated 3-Way Matching
  Scenario: Faktura matchar Depåns Inköpsorder
    Given a "PurchaseOrderCreated" event was previously recorded from Depot for "Vendor A" with total "950 SEK"
    And a "GoodsReceipt" event confirms the item "KB-FILTER-001" was delivered
    When the "Invoicing Gateway" receives a "SupplierInvoice" from "Vendor A" for "950 SEK"
    Then the "CFO-Agent" automatically performs a 3-way match
    And marks the invoice status as "APPROVED"
    And creates a payment instruction for the "Bank Gateway"
    And posts the ledger entry: Debit "4000 (Reservdelar)", Credit "2440 (Leverantörsskulder)"
```
