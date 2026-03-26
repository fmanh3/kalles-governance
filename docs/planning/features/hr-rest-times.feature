# Feature: Policy för Dygnsvila (Driver Rest Time Compliance)
# Domän: kalles-hr
# Policy-ref: "Minst 11 timmars dygnsvila mellan arbetspass" (GEMINI.md)

@compliance-hr @safety-critical
Egenskap: Automatisk kontroll av lagstadgad dygnsvila
  Som schemaläggare eller schemaläggningsagent på Kalles Buss
  Vill jag att systemet automatiskt blockerar tilldelning av arbetspass om dygnsvilan underskrids
  För att följa kollektivavtal och arbetsmiljölagen, samt undvika viten och farliga trafiksituationer.

  Scenario: Tilldelning blockeras när dygnsvilan är under 11 timmar
    Givet att föraren "FÖRARE-007" avslutade sitt senaste pass kl "22:00"
    När en agent försöker tilldela ett nytt pass med start kl "06:00" nästa morgon (endast 8 timmars vila)
    Så ska `kalles-hr/workforce-planning` neka tilldelningen ("Policy Violation: Insufficient Rest")
    Och ett fel (Error Event) ska publiceras på event-bussen.

  Scenario: Tilldelning godkänns när dygnsvilan är över 11 timmar
    Givet att föraren "FÖRARE-007" avslutade sitt senaste pass kl "18:00"
    När en agent försöker tilldela ett nytt pass med start kl "06:00" nästa morgon (12 timmars vila)
    Så ska `kalles-hr/workforce-planning` godkänna tilldelningen
    Och `DriverAssignedToShift` event publiceras.
