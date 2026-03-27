# ADR 005: Lab Environment Security Scoping

## Status
**Accepterad** (2026-03-27)

## Kontext
"Kalles Buss" utvecklas och driftas i en laborationsmiljö (`joakim-hansson-lab`) som tillhandahålls av arbetsgivaren. Projektets primära syfte är att agera testbädd och bevisa koncept kring **Event-Driven Architecture (EDA)**, **Domain-Driven Design (DDD) / Bounded Contexts**, och **Policy-as-Code** genom autonoma agenter.

Under provisioneringen av infrastrukturen (Terraform) stötte vi på hinder gällande nätverks- och IAM-rättigheter (t.ex. avsaknad av rättigheter att aktivera `compute.googleapis.com` för att skapa anpassade VPC-nätverk). Att bygga en fullskalig "Zero Trust"-arkitektur med privata subnät och Workload Identity-federering i en begränsad labbmiljö kräver oproportionerligt mycket tid för felsökning av plattformsspecifika behörigheter, tid som tas från utvecklingen av domänlogiken.

## Beslut
Vi väljer aktivt att **begränsa scopet för nätverks- och IAM-säkerhet** till en "Dev/Test"-nivå för att behålla utvecklingshastigheten:

1. **Identitet och Autentisering:** 
   Vi avstår från att sätta upp dedikerade Google Service Accounts och Workload Identity-federering för mikrotjänsterna. Tjänsterna kommer tills vidare att köras lokalt (eller i labbet) och autentisera mot molnet via utvecklarens egna **Application Default Credentials (ADC)**.
2. **Nätverk och Databasåtkomst:** 
   Vi avstår från att implementera ett "Zero-Trust VPC" med privata IP-adresser för databaserna. Istället förlitar vi oss på standardnätverket och ansluter till Cloud SQL-instanserna via en säker **Cloud SQL Auth Proxy**-tunnel. Vi tar bort kravet på dedikerade VPC-nätverk från Terraform-konfigurationen.

## Konsekvenser
* **Positivt:** Drastiskt minskad friktion vid infrastrukturprovisionering. Utvecklingsteamet och agenterna kan fokusera 100% på affärslogik, domändesign och event-driven integration istället för att stångas med IAM-policys i labbmiljön.
* **Negativt:** Infrastrukturen uppfyller inte produktionskrav (t.ex. NIS2). Arkitekturen har ett säkerhetsmässigt beroende till utvecklarens maskin (via proxy och ADC).
* **Mitigering:** Detta dokumenteras uttryckligen som ett medvetet avsteg. Om systemet någonsin ska hantera skarp persondata eller flyttas till en produktionsmiljö måste Terraform-modulerna byggas ut med stöd för Shared VPC och Workload Identity.
