# Finance Domain: Förmågekartläggning

## Vision
Att tillhandahålla en helt automatiserad, händelsestyrd ekonomiplattform som garanterar bokföringsmässig korrekthet och realtidsinsikt i bolagets finansiella hälsa.

## Kärnförmågor (Capabilities)

### 1. General Ledger (Huvudbok)
*   **Automatiserad kontering:** Översättning av affärshändelser (t.ex. avslutad körtur) till debet/kredit.
*   **Periodisering:** Hantering av intäkter och kostnader över tid.
*   **Momsredovisning:** Automatisk beräkning och export till Skatteverket.

### 2. Accounts Receivable (Kundreskontra)
*   **Fakturagenerering:** Baserat på kontraktstermer och faktiska trafik-events.
*   **Betalningsbevakning:** Matchning av inkommande banktransaktioner mot utställda fakturor.
*   **Kravhantering:** Automatiserade påminnelseflöden.

### 3. Accounts Payable (Leverantörsreskontra)
*   **Fakturaingestion (Yttre ring):** Mottagande av fakturor via e-post, portal eller API.
*   **Attestflöde:** Digitalt godkännande baserat på budgetansvar och inköpsorder.
*   **Betalningsutförande:** Integration mot Swedbank/Bankgirot för utbetalningar.

### 4. Treasury & Liquidity (Skattkammare & Likviditet)
*   **Likviditetsplanering:** Prognoser baserade på väntade in- och utbetalningar.
*   **Bankavstämning:** Automatisk matchning mellan bankkonto och huvudbok.

## Gränssnitt mot externa parter
| Part | Typ av integration | Standard |
| :--- | :--- | :--- |
| **Skatteverket** | API / XML-export | SIE4 / SAF-T |
| **Bankgirot** | Filöverföring / API | ISO 20022 (PAIN/CAMT) |
| **Swedbank** | Host-to-Host / Open Banking | JSON API |
| **Leverantörer** | E-faktura / Inläsning | Peppol BIS / PDF-tolk |
