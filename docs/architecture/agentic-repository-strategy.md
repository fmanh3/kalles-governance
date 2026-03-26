# Arkitektur- och Repositoriestrategi för Agentdriven Utveckling

**Datum:** 2026-03-26
**Status:** Aktiv riktlinje
**Domän:** Systemövergripande (Governance)

## Syfte
Detta dokument fångar insikter och arkitekturbeslut kring hur vi bäst strukturerar kod och repositories när mjukvaruutvecklingen drivs av AI-agenter snarare än traditionella mänskliga utvecklingsteam. Syftet är att belysa differenserna mellan "traditionell" och "agentisk" systemutveckling och utgöra ett underlag för framtida utvärderingar.

---

## 1. Conways lag i en Agentisk Kontext

I traditionell systemutveckling speglar arkitekturen ofta organisationens kommunikationsstrukturer (Conways lag). Med AI-agenter förändras denna dynamik i grunden. Våra "utvecklare" (agenter) styrs primärt av policys och kontextfönster, inte av avdelningsgränser eller team-möten. Därför måste kodstrukturen optimeras för *maskinell kontextförståelse* och *atomära leveranser*, snarare än för att separera mänskliga ansvarsområden.

---

## 2. Vertikala snitt över horisontella lager (Anti-mönstret)

I en klassisk trelagersarkitektur delas kod ofta upp i tekniska silos: ett repository för frontend (UI), ett för middleware/API, och ett för backend/infrastruktur. 

**I en agentdriven värld är detta ett anti-mönster.**

Agenter presterar bäst när de kan hantera en hel feature som ett "vertikalt snitt" (Vertical Slice). Om en policy-uppdatering kräver att en ny datapunkt ska samlas in, sparas och publiceras på event-bussen, vill vi att agenten ska kunna lösa allt detta i en och samma kontext och leverera en komplett, testad Pull Request. 

Att sprida ut logiken över tekniska lager-repos (`finance-ui`, `finance-api`, `finance-infra`) tvingar fram komplex orkestrering mellan agenter över flera repositories, vilket drastiskt ökar risken för synkroniseringsfel och brutna API-kontrakt.

**Beslut:** Vi strukturerar kod efter *domän och funktionalitet* (Bounded Contexts), inte efter tekniskt lager. UI, affärslogik och infrastruktur (IaC) för en specifik tjänst bor tillsammans.

---

## 3. Hantering av Domänstorlek och Bounded Contexts

Initialt skapades övergripande repositories som `kalles-finance`, `kalles-hr` och `kalles-traffic`. För agentisk utveckling är dessa för breda och riskerar att svämma över agenternas kontextfönster om allt behandlas som en enda monolitisk applikation. 

En domän som *Finance* består av flera tydliga sub-domäner (Bounded Contexts) enligt Domain-Driven Design (DDD), såsom:
*   Leverantörsreskontra (`accounts-payable`)
*   Huvudbok (`general-ledger`)
*   Kundreskontra (`accounts-receivable`)
*   Bankintegrationer (`bank-gateway`)

### Vägval: Domän-Monorepon vs. Polyrepo (Micro-repos)

För att hantera dessa sub-domäner övervägdes två strategier:

#### Alternativ A: Domän-Monorepon (Vald strategi)
Varje övergripande domän (`kalles-finance`, `kalles-hr`) utgör ett monorepo, där varje Bounded Context är en egen applikation eller paket internt i repot.
*   **Struktur:**
    *   `kalles-finance/apps/ledger/`
    *   `kalles-finance/apps/bank-gateway/`
    *   `kalles-finance/packages/event-schemas/`
*   **Fördelar för agenter:** Agenten har tillgång till hela kontexten för ekonomi-domänen. Om den uppdaterar ett gemensamt event-schema kan den i samma körning uppdatera och testa alla interna tjänster som lyssnar på det eventet. Friktionen minimeras och vi får atomära ändringar över sub-domängränser.

#### Alternativ B: Polyrepo / Strict Micro-repos (Förkastad strategi)
Varje sub-domän får ett helt eget repository (t.ex. `kalles-finance-ledger`).
*   **Nackdelar för agenter:** Kräver tung, högnivå-orkestrering. Om ett kontrakt ändras måste event-scheman versionshanteras och publiceras till ett externt paketrepo (t.ex. NPM/NuGet), varefter agenter måste "väckas" i alla beroende repositories för att uppdatera, testa och bygga om. Detta bryter den agila, vertikala leveransen.

**Beslut:** Vi tillämpar **Domän-Monorepon**. Det ger oss mikrotjänsternas lösa koppling och tydliga ansvarsområden (Bounded Contexts), men behåller kontexten och flexibiliteten för agenterna att göra refaktoriseringar och domänövergripande ändringar i en enda integrerad rörelse.

---

## Sammanfattning
Genom att gå ifrån tekniska lager och istället anamma Domän-Monorepon baserade på vertikala snitt och Bounded Contexts, optimerar vi arkitekturen för våra agenter. Detta minimerar kognitiv (och token-baserad) last, förenklar spårbarhet mot policys, och möjliggör snabbare, säkrare och mer autonoma leveranser.