# Feature: Trafikstyrning i Realtid (Real-time Fleet Tracking)
# Domän: kalles-traffic
# Policy-ref: "BussAnkommitHållplats" (GEMINI.md) / NIS2 Incident Rapportering

@critical @compliance-nis2
Egenskap: Realtidspositionering för bussflottan
  Som trafikledare på Kalles Buss
  Vill jag se exakt position och status för varje buss på linje 676 (Norrtälje-Tekniska)
  För att kunna optimera trafiken och uppfylla SL:s kvalitetskrav.

  Scenario: En buss skickar en positionsuppdatering
    Givet att bussen "BUSS-101" kör på linje 676
    Och att systemet för trafikstyrning är anslutet till event-bussen
    När bussen skickar en `BusPositionUpdated` händelse med:
      | lat      | 59.758 |
      | lng      | 18.703 |
      | speed    | 75     |
      | battery  | 82     |
    Så ska händelsen valideras mot Zod-schemat
    Och publiceras på Pub/Sub-topiken `traffic-telemetry`
    Samt loggas med en unik spårbarhets-ID (Correlation ID) för NIS2-efterlevnad.
