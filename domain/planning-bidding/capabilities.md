# Planning & Bidding - Capabilities

## 1. Domain Purpose
This is the strategic engine of Kalles Buss. Before any bus drives a single meter, the Planning & Bidding domain decides *what* we should bid on, *how much* it will cost, and generates the master schedule (Production Plan) that feeds all other downstream domains (Traffic, HR, Energy).

## 2. Core Capabilities

### 2.1 Tender Simulation (Anbudsräkning)
*   **Ingestion:** Reads standard public transport tender documents (e.g., Västtrafik or SL traffic supply specs).
*   **Simulation Engine:** Uses the platform's historical data (actual energy consumption per km, actual HR costs, average speed on specific routes) to simulate the cost of operating the proposed network.
*   **Output:** Generates a highly accurate baseline cost and proposed bid price.

### 2.2 Network & Timetable Generation (Tidtabellläggning)
*   Once a contract is won, this domain translates the legal contract into an executable Master Timetable.
*   Optimizes the network topology: Where should the stops be? How much buffer time is needed to absorb typical traffic delays?

### 2.3 Vehicle & Block Scheduling (Omloppsplanering)
*   Groups individual trips into logical "Blocks" (Omlopp) that a single physical bus can execute in a day.
*   Optimizes for minimum "Tomkörning" (deadhead/empty running) between the depot and the start of the routes.

## 3. The A-A-H Escalation Model

### Level 1: Straight-Through Automation
*   **Scenario:** A minor, seasonal timetable update from SL (e.g., shifting to the Summer schedule).
*   **Action:** The system automatically ingests the new GTFS file, calculates the minor changes in vehicle blocking, and publishes the new `ProductionPlan` to the Event Bus for Traffic and HR to consume.

### Level 2: AI Agent Resolution
*   **Scenario:** During tender simulation, the initial block generation results in a requirement of 52 buses. The depot capacity is only 50 buses.
*   **Action:** The Optimization Agent iterates millions of blocking permutations, slightly adjusting layover times at terminals, until it finds a mathematical solution that executes the entire timetable using only 50 buses, saving millions in capital expenditure.

### Level 3: Human-in-the-Loop
*   **Scenario:** A major tender is ready for final submission (e.g., a 10-year contract worth 2 Billion SEK).
*   **Action:** The AI Agent presents its "Recommended Bid" and confidence intervals. The CEO and Commercial Director review the strategic risk, manually adjust the profit margin, and digitally sign the final submission.