# Milstolpe 4: Connected Portals (CEO & Driver)

## Status: Slutförd ✅ (April 2026)

## Mål
Att skapa en sammanhållen användarupplevelse genom att aggregera data från de olika domänerna och presentera dem för bolagets intressenter.

## Prestationer

### 1. Frontend (Portal)
*   **React & Vite:** Implementerat en reaktiv, mobile-first webbportal.
*   **Rollbaserad inloggning:** Enkel lab-login för VD och Förare.
*   **Dashboards:** Visualisering av finansiell likviditet för VD och schemavisa för förare.

### 2. Backend for Frontend (BFF)
*   **API Gateway:** En Express-baserad gateway som fungerar som aggregator mot domäntjänsterna.
*   **Isolering:** Frontenden pratar bara med BFF:en, vilket skyddar domänernas interna API:er.

### 3. Deployment & Cloud
*   **Multi-repo Orchestration:** Samtliga 5 repon är nu synkade och länkade.
*   **Serverless:** Portalen och BFF:en körs som containrar i Google Cloud Run.
*   **Public Access:** Tjänsterna är åtkomliga via publika URL:er för enkel verifiering i labbmiljön.

## Tekniska Lärdomar
*   **TypeScript Pedantry:** Vikten av att rensa oanvända imports för att inte blockera produktionsbyggen.
*   **Docker Context:** Hantering av bygg-kontexter i en monorepo-liknande miljö kräver precision i Dockerfilerna.
*   **Cloud Run Port Handling:** Säkerställa att även statiska Nginx-containrar lyssnar på rätt port ($PORT).

## Nästa Steg
*   Införa riktig autentisering (OIDC/Google Auth).
*   Bygga ut realtidskartan med faktiska koordinater från Traffic-simulatorn.
*   Möjliggöra interaktion från portalen tillbaka till domänerna (t.ex. godkänna fakturor).
