# Use Cases: CFO Optimization & Energy Management

Dessa use cases beskriver samspelet mellan Finance och Energy-Depot domänerna.

## UC-FIN-08: Elpris-optimerad Laddning
**Aktör:** CFO Agent (Treasury) & Energy Agent
**Beskrivning:** CFO-agenten bevakar elpriser och instruerar depån att ladda vid lägsta kostnad.

### Gherkin Scenario
```gherkin
Feature: Energy Cost Optimization
  Scenario: Tidstyrd nattladdning vid högt morgonpris
    Given elpriset för imorgon kl 07:00 är "4.50 SEK/kWh"
    And elpriset inatt kl 02:00 är "0.45 SEK/kWh"
    When CFO-agenten publicerar ett "EnergyOptimizationStrategy" event
    Then depå-systemet ska schemalägga full laddning av alla anslutna bussar kl 02:00
    And snabbladdning vid Tekniska Högskolan ska minimeras under peak-timmar
```

## UC-FIN-09: Lönsamhetsanalys per Linje (Unit Economics)
**Aktör:** CFO Agent (Controller)
**Beskrivning:** Automatisk beräkning av marginal per rutt.

### Gherkin Scenario
```gherkin
Feature: Unit Economics
  Scenario: Beräkna dagsmarginal för Linje 676
    Given intäkter från SL för perioden är "450 000 SEK"
    And personalkostnader (Payroll) för samma period är "180 000 SEK"
    And energikostnaden (från Energy domänen) är "45 000 SEK"
    When Controller-agenten kör analysen
    Then rapporten ska visa en bruttomarginal på "225 000 SEK"
    And systemet ska flagga om marginalen understiger "40%"
```
