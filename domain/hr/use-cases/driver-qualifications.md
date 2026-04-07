# Use Cases: Förarprofil och Behörigheter

## UC-HR-04: Verifiering av Förarprofil
**Beskrivning:** Föraren kan se sin anställningsdata, kontaktuppgifter och semesterbalans.

### Gherkin Scenario
```gherkin
Feature: Förarprofil
  Scenario: Visa profil och anställningsdata
    Given att jag är inloggad som "Förare"
    And mitt förar-ID är "DRIVER-007"
    When jag navigerar till "Min Profil"
    Then ska systemet visa "Kontaktuppgifter: kalle@kallesbuss.se", "ICE: Mamma (070-123456)", "Bank: Swedbank 8327-..."
    And systemet ska visa min anställningsform som "Fast"
    And systemet ska visa min depå som "Norrtälje Depå"
    And systemet ska visa mina semesterdagar som "Sparade: 5, Kvar i år: 25"
```

## UC-HR-05: Automatiserad Behörighetskontroll
**Beskrivning:** En regel-agent validerar att föraren har rätt licenser för den planerade bussen.

### Gherkin Scenario
```gherkin
Feature: Behörighetskontroll
  Scenario: Validering av behörighet för dubbeldäckare
    Given att jag är schemalagd på "Linje 676" med fordon "BUSS-201 (Dubbeldäckare)"
    When AI-agenten för behörighetskontroll utvärderar mitt pass
    Then ska systemet verifiera att min körkortsklass innehåller "D"
    And systemet ska verifiera att mitt YKB är "Giltigt"
    And systemet ska verifiera att min utbildning för "Articulated/Double" är "Godkänd"
    And systemet ska visa en grön bock: "Klar för tjänst"
```
