# Customer Success Domain: Förmågekartläggning

## Vision
Att tillhandahålla intuitiva och realtidsuppdaterade gränssnitt som ger bolagets intressenter (ledning och personal) de verktyg de behöver för att fatta beslut och utföra sitt arbete effektivt.

## Kärnförmågor (Capabilities)

### 1. CEO Dashboard (VD-portalen)
*   **Finansiell cockpit:** Realtidsvy över bankbalans, kundfordringar och leverantörsskulder (hämtas från Finance).
*   **Momsövervakning:** Status på aktuell momsskuld/fordran inför nästa redovisning.
*   **Fleet Map:** Live-karta som visar alla fordons positioner och status (hämtas från Traffic).
*   **Compliance Alerts:** Varningar om HR-regler (t.ex. dygnsvila) har brutits eller om fordon missat sina turer.

### 2. Driver Self-Service (Förarapplikationen)
*   **Mitt Schema:** Vy över tilldelade och kommande arbetspass (hämtas från HR).
*   **Frånvarohantering:** Möjlighet att anmäla sjukdom eller ansöka om semester direkt i mobilen.
*   **Tjänstebyten:** (Version 1.1) Möjlighet att lägga ut pass för byte.
*   **Körtids-tracker:** Se kvarvarande körtid inna nästa rast/dygnsvila krävs.

## Tekniskt upplägg (BFF - Backend for Frontend)
Portalen kommunicerar med en "Gateway" som aggregerar svar från:
*   `kalles-finance` (Ekonomi)
*   `kalles-hr` (Personal)
*   `kalles-traffic` (Fordonsstatus)
