# Milstolpe 4: Connected Portals (CEO & Driver)

## Status: Planerad 🗓️

## Mål
Att bygga en sammanhållen användarupplevelse genom att aggregera data från molntjänsterna och presentera den i en VD-portal och en förar-app.

## Fokusområden

### 1. API Gateway / BFF (Backend for Frontend)
*   [ ] Implementera en central gateway som pratar med Finance, HR och Traffic API:er.
*   [ ] Hantera autentisering (t.ex. Google Auth eller enkel lab-login).

### 2. CEO Portal (Web)
*   [ ] Dashboard-vy för likviditet och finansiell status.
*   [ ] Realtidskarta (Fleet Map) med Leaflet/Google Maps.
*   [ ] Lista över utestående kund- och leverantörsfakturor.

### 3. Driver App (Mobil-anpassad Web)
*   [ ] "Mitt Schema"-vy med detaljer för dagens och morgondagens pass.
*   [ ] Interaktiva knappar för "Sjukanmälan" och "Semesteransökan".
*   [ ] Visning av personliga lönebesked (PDF eller vy).

### 4. Integration & Test
*   [ ] Verifiera Gherkin-scenarierna genom end-to-end integrationstester.
*   [ ] Driftsätta Frontenden i Google Cloud Run.

## DoD (Definition of Done)
*   En enhetlig webbportal är live i molnet.
*   VD kan se likviditet i realtid baserat på faktiska bokföringsdata.
*   Förare kan se sitt schema och ändra status på sina pass via appen.
*   All data hämtas dynamiskt via API Gateway.
