# HR & Workforce Domain: Förmågekartläggning

## Vision
Att säkerställa en laglydig, hållbar och effektiv personalförsörjning som garanterar rätt lön i rätt tid och efterlevnad av alla säkerhetsföreskrifter.

## Kärnförmågor (Capabilities)

### 1. Workforce Planning (Bemanningsplanering)
*   **Tjänstekonstruktion:** Skapande av arbetspass (tjänster) baserat på tidtabeller.
*   **Compliance-kontroll:** Realtidsvalidering mot kör- och vilotider (t.ex. EU-förordning 561/2006).
*   **Resursoptimering:** Balansering av heltidstjänster, behovsanställda och övertid.

### 2. Absence & Health (Frånvaro & Hälsa)
*   **Sjukanmälan:** Självbetjäning för förare och automatisk kaskad till bemanningsplanering (behov av ersättare).
*   **Semesterplanering:** Hantering av lagstadgad semester och branschspecifika regler.
*   **Rehabilitering:** Spårbarhet kring långtidsfrånvaro och rehabflöden.

### 3. Driver Operations (Förarstöd)
*   **Digitalt tidkort:** In- och utcheckning mot tilldelat pass.
*   **Avvikelsehantering:** Rapportering av förseningar som påverkar arbetstid.

### 4. Payroll Engine (Lönemotor)
*   **Lönearter:** Hantering av grundlön, garantilön och premiekompensation.
*   **OB-beräkning:** Automatisk uträkning av obekväm arbetstid (enkel, kvalificerad, natt).
*   **Övertidsregler:** Hantering av dygnsövertid, veckoövertid och fyllnadstid.
*   **Traktamenten:** Beräkning baserat på körningar utanför stationeringsorten.

## Externa Gränssnitt
| Part | Integration | Syfte |
| :--- | :--- | :--- |
| **Skatteverket** | API / Fil | Arbetsgivardeklaration på individnivå (AGI) |
| **Fora/Collectum** | Fil | Pensionsrapportering och försäkringar |
| **Bankgirot** | ISO 20022 | Utbetalningsfiler för löner |
| **Facket (Kommunal)** | Portal | Granskning av schemaläggning och avtalsbrott |
