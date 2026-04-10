# Milstolpe 8: Finansiell Intelligens (CFO Agent)

## Status: Påbörjad 🏃‍♂️

## Mål
Att transformera Finance-domänen till en proaktiv affärspartner genom att implementera agenter som hanterar likviditetsvarningar, automatiska bokslut, vitesbestridanden och dynamiska avskrivningar.

## Fokusområden

### 1. Treasury & Liquidity Intelligence
*   [ ] Implementera `TreasuryAgent` för kassaflödesprognoser.
*   [ ] Logik för att varna för likviditetsbrist inför lönekörningar.

### 2. Reporting & Asset Management
*   [ ] Automatiserad periodisering av ofakturerade turer (Accrued Revenue).
*   [ ] Implementera dynamisk avskrivning baserad på batteridegradering (BEV-fokus).

### 3. Controlling & Revenue Assurance
*   [ ] Bygga `ControllingAgent` för att validera SL-viten mot trafikincidenter.
*   [ ] Automatiskt bestridande flöde vid Force Majeure.

### 4. Datamodell (Finance DB)
*   [ ] Tabell `assets`: Fordonsvärden och avskrivningslogg.
*   [ ] Tabell `penalties`: Logg över viten och bestridanden.
*   [ ] Tabell `accruals`: Månatliga periodiseringsposter.

## DoD (Definition of Done)
*   CFO-förmågor är dokumenterade och pusshade till Governance.
*   Nya tabeller är migrerade i Cloud SQL.
*   Gherkin-scenarier för likviditetsvarning och avskrivning är verifierade med enhetstester.
*   Finance-tjänsten i GCP kan varna för kassaflödesbrist via loggar/API.
