# ADR-002: Teknikstack, Infrastruktur och Compliance (NIS2 / Data Act)

**Datum:** 2026-03-26
**Status:** Godkänd (Agent-initierad)
**Domän:** Systemövergripande (Governance, Security, Infrastructure)

## Syfte
Att fastställa den tekniska grundplåten för Kalles Buss-plattformen, definiera hur infrastrukturen hanteras, och säkerställa att vi från dag ett uppfyller lagkraven i NIS2 (säkerhet i samhällskritisk infrastruktur) och Data Act (data-portabilitet och transparens).

## Arkitekturbeslut

### 1. Språk och Runtime
**Beslut:** TypeScript på Node.js.
**Motivering:** Mjölkar maximalt värde ur vår "Domän-Monorepo"-strategi. Typade event-kontrakt kan delas friktionsfritt mellan microservices i samma monorepo.

### 2. Meddelandehantering (Event Bus)
**Beslut:** Google Cloud Pub/Sub.
**Motivering:** Serverless och autoskalar för att hantera peak-trafik när 1000 bussar skickar telemetri samtidigt. Stödjer lokala Docker-emulatorer vilket uppfyller kravet på ett fullständigt, lokalt dev-spår.

### 3. Datalagring
**Beslut:** PostgreSQL (via GCP Cloud SQL).
**Motivering:** ACID-transaktioner är icke-förhandlingsbara för `kalles-finance` och `kalles-hr`. För `kalles-traffic` nyttjar vi PostgreSQL:s avancerade JSONB-stöd för schemalös händelsedata, samt PostGIS för geografiska kalkyler.

### 4. Infrastructure as Code (IaC)
**Beslut:** Terraform (HashiCorp).
**Motivering:** Infrastrukturen versionshanteras och granskas exakt som applikationskoden. Agenter kan läsa `.tf`-filer för att förstå systemets topologi.

---

## Efterlevnad av Lagkrav

### NIS2-direktivet (Säkerhet för samhällskritisk infrastruktur)
Kollektivtrafik är samhällskritisk. Plattformen måste vara extremt resilient och säker.
*   **Decoupling:** Om `kalles-hr` går ner, fortsätter `kalles-traffic` köra bussarna tack vare den asynkrona event-bussen.
*   **Zero-Trust IaC:** Våra Terraform-mallar kommer exekveras med principen om lägsta privilegium (Least Privilege IAM). Databaser får aldrig publika IP-adresser.
*   **Spårbarhet:** Alla ändringar i koden, oavsett om de görs av människor eller agenter, knyts till en specifik policy-kravställning (se `GEMINI.md`).

### EU Data Act (Data-interoperabilitet och delning)
Data Act kräver att genererad data (t.ex. fordonsrörelser och energiåtgång) inte låses in, utan kan delas med användare och tredje part på ett rimligt sätt.
*   **Event-Sourcing som grund:** Eftersom all affärslogik utlöses av standardiserade JSON-händelser, kan vi uppfylla Data Act genom att helt enkelt koppla nya, säkra och anonyma prenumeranter till våra existerande Pub/Sub-ämnen (Topics) utan att behöva bygga om kärnsystemet.
