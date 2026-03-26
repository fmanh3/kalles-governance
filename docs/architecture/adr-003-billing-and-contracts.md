# ADR-003: Modulär Avtals- och Prissättningsmotor (Billing Engine)

**Datum:** 2026-03-26
**Status:** Godkänd
**Domän:** Finance (Billing Engine)

## Bakgrund
Svensk kollektivtrafik (via t.ex. SL, Samtrafiken) styrs av komplexa upphandlingsavtal. Ersättningsmodeller inkluderar kilometerersättning (varierande per fordonstyp och tidpunkt), resandeincitament (via APC-data) samt viten för förseningar och fordonsbrister. 
Tidigare "Walking Skeleton" hårdkodade en platt kilometerersättning mot en specifik kund (SL), vilket är ett ohållbart anti-mönster för plattformens skalbarhet.

## Beslut
Vi inför en data-driven **Billing Engine** som frikopplar trafikhändelser från ekonomisk värdering.

1.  **Kärn-entiteter i databasen:**
    *   `contractors` (Avtalsparter, t.ex. SL).
    *   `contracts` (Huvudavtal med giltighetstider).
    *   `tariffs` (Prisregler kopplade till ett avtal. Stödjer JSONB för flexibla tidsmultiplikatorer och fordonsklasser).
2.  **Händelseflöde:**
    *   `Traffic` publicerar `TrafficTourCompleted` (Agonstisk fakta: "Buss 101 körde Linje 676 på 55 minuter, 73km").
    *   `Finance/Billing Engine` konsumerar händelsen, slår upp gällande avtal för den aktuella tidpunkten och linjen, applicerar tarifferna (t.ex. natt-taxa) och beräknar summan.
    *   `Finance/Ledger` bokför den slutgiltiga summan i huvudboken.

## Konsekvenser
*   **Flexibilitet:** Nya avtal, indexuppräkningar och tillfälliga kampanjer hanteras via databasuppdateringar (som kan göras av administrativa agenter som läser PDF-avtal), utan att ny kod behöver driftsättas.
*   **Komplexitet:** Beräkningsmotorn blir mer komplex då den måste kunna tolka regelverk (JSONB) och applicera multiplikatorer (t.ex. röda dagar). Vi accepterar denna komplexitet i domän-kärnan för att skydda systemet från legacy-kod.
