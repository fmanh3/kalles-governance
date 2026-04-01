# Milstolpe 1: Walking Skeleton (Mars 2026)

## Status: Slutförd ✅

## Mål
Att etablera en teknisk baslinje ("Walking Skeleton") som bevisar att systemets arkitektoniska huvudprinciper fungerar i en verklig molnmiljö (GCP).

## Prestationer

### 1. Arkitektur & Decoupling
* **Event-Driven:** Implementerat en fungerande händelsebuss via GCP Pub/Sub.
* **Bounded Contexts:** Etablerat tre initiala domäner (Finance, HR, Traffic) med separerade databaser (Cloud SQL Postgres) och kodbaser.
* **Cross-Repo Integration:** Hanterat delade scheman och gemensam infrastruktur-kod tvärs över flera repositories.

### 2. Infrastruktur-as-Code (IaC)
* **Terraform:** Fullständig provisionering av molnresurser (Pub/Sub, Cloud SQL, Artifact Registry, Cloud Run, IAM).
* **Lab-scoping (ADR-005):** Etablerat en pragmatisk säkerhetsmodell för labbmiljö som medger snabb iteration utan att kompromissa med arkitekturens integritet.

### 3. Modern Delivery Pipeline
* **Containerisering:** Samtliga tjänster körs som Docker-containrar med flerstegsbyggen.
* **Continuous Integration (CI):** GitHub Actions konfigurerade för samtliga repon för att automatiskt verifiera TypeScript-kompilering, beroenden och enhetstester.
* **Cloud Deployment:** Automatiserad utrullning till Google Cloud Run för Finance och Traffic Simulator.

### 4. Domänlogik (Initial Slice)
* **Traffic:** Simulator som genererar telemetri och passagerardata (APC).
* **Finance:** Billing engine som tar emot realtidsdata och beräknar faktureringsunderlag.
* **HR:** Guardrail-system som validerar dygnsvila för förare mot definierade policys.

## Tekniska Lärdomar
* Betydelsen av att spegla lokal mappstruktur i CI-miljöer för att hantera relativa importer mellan repon.
* Cloud Run kräver en aktiv port (heartbeat) även för rena bakgrundsjobb i en "Service"-kontext.
* Vikten av tydliga ADR:er för att kommunicera medvetna avsteg från produktionsstandard i en tidig labbfas.

## Nästa Steg
* Utöka Finance-domänen med faktiska tariffer och avtalsstöd för Linje 676.
* Förfina HR-domänens integration så att den aktivt kan stoppa otillåtna pass-tilldelningar i simulatorn.
* Utforska "Shadow Mode" simulering mot historisk data.
