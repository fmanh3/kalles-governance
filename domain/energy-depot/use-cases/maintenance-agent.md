# Use Cases: Maintenance Agent

## UC-DEPOT-01: Autonomt Skapande av Arbetsorder från Förare
**Beskrivning:** Agenten översätter en förares felanmälan till ett faktiskt reparationsjobb.
### Gherkin Scenario
```gherkin
Feature: Arbetsorderhantering
  Scenario: Trasigt säte skapar arbetsorder
    Given a "VehicleDamageReported" event is received for asset "BUSS-101"
    And the description is "Trasigt säte 4B"
    When the "Maintenance-Agent" processes the event
    Then an internal "WorkOrder" is created with status "PLANNED"
    And the required internal item is identified as "KB-SEAT-04"
```

## UC-DEPOT-02: Dynamiskt Leverantörsval
**Beskrivning:** Agenten beställer reservdelar genom att väga pris mot hur akut bussen behövs i trafik.

### Gherkin Scenario
```gherkin
Feature: Dynamiskt Leverantörsval
  Scenario: Tids-kritiskt inköp för aktivt omlopp
    Given a "WorkOrder" requires internal item "KB-FILTER-001"
    And inventory "stock_level" is "0"
    And "BUSS-101" is needed in traffic within "24 hours"
    And the supplier catalog lists "Vendor A" (1 day lead time, 950 SEK) and "Vendor B" (3 days lead time, 800 SEK)
    When the "Maintenance-Agent" generates a "PurchaseOrder"
    Then it selects "Vendor A" to prioritize lead time
    And publishes a "PurchaseOrderCreated" event to the Event Bus
```
