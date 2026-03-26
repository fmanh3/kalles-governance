# Feature: Automatiserad Avräkning (Automated Billing)
# Domän: kalles-finance
# Policy-ref: "Automatisera avvikelseapportering" (GEMINI.md)

@critical @compliance-finance
Egenskap: Automatiserad fakturering av trafikleverans
  Som ekonomi-ansvarig på Kalles Buss
  Vill jag att systemet automatiskt genererar fakturaunderlag baserat på faktiskt körda turer
  För att minimera manuell administration och säkerställa korrekt kassaflöde.

  Scenario: En utförd tur genererar en bokföringspost
    Givet att turen "TOUR-999" på linje 676 har markerats som `COMPLETED` i kalles-traffic
    När `kalles-finance/billing-engine` tar emot händelsen `TrafficTourCompleted`
    Så ska en ny fordran skapas i kundreskontran
    Och en motsvarande post bokföras i huvudboken (General Ledger) enligt BAS-kontoplanen.
