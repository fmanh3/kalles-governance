# Customer Success - Capabilities

## 1. Domain Purpose
While the transit authority (SL) handles primary ticketing, Kalles Buss is responsible for the actual passenger experience on board. This domain handles disruptions, lost property, and passenger feedback, turning operational chaos into good customer relations.

## 2. Core Capabilities

### 2.1 Disruption Communication
*   Consumes `TrafficDeviation` events from Traffic Control.
*   Generates human-readable explanations for delays or canceled routes and pushes them to external APIs (e.g., SL's customer app, onboard displays).

### 2.2 Travel Guarantee & Claims (Resegaranti)
*   If a passenger claims compensation for a delayed bus, this domain verifies the claim against the actual `Traffic` Digital Twin.
*   If valid, it processes the refund/compensation automatically.

### 2.3 Lost and Found (Hittegods)
*   Manages the digital ledger of items found on buses.
*   Matches passenger inquiries against the inventory using fuzzy matching.

## 3. The A-A-H Escalation Model

### Level 1: Straight-Through Automation
*   **Scenario:** Traffic Control cancels a route due to a blocked road. 
*   **Action:** The Customer Success domain instantly pushes a standardized message to the API: "Route 676 cancelled due to road closure. Next departure at 14:30."

### Level 2: AI Agent Resolution
*   **Scenario:** A passenger submits a Travel Guarantee claim: "My bus (676) was 25 minutes late yesterday, I had to take a taxi."
*   **Action:** The Support Agent reads the claim. It queries the Traffic domain for "Route 676, yesterday". The Digital Twin confirms the bus was indeed 28 minutes late. The Agent approves the claim, generates a refund instruction to the AP/Bank Gateway domain, and emails the customer a polite apology.

### Level 3: Human-in-the-Loop
*   **Scenario:** A passenger reports a severe safety incident (e.g., aggressive driver behavior or an onboard altercation).
*   **Action:** The system flags the ticket with "Highest Severity". A human Customer Relations Manager and the HR Director are immediately alerted to review the onboard camera footage and initiate a formal investigation.