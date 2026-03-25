# Kalles Buss: HR & Workforce Management Domain

## 1. Domain Overview
In the public transport sector, Human Resources is not just an administrative function; it is a **safety-critical operational engine**. The `HR` domain manages the lifecycle, compliance, and real-time availability of the drivers.

This domain ensures that every driver assigned to a vehicle is legally permitted to drive, adequately rested, and correctly compensated (via integration with the `Payroll Engine`).

## 2. Subdomains

### 2.1 Core HR (`core-hr/`)
*   **Responsibility:** Master data, Legal Compliance, and Absence Management.
*   **Context:** The Single Source of Truth for employee identities, union affiliations, driving licenses, mandatory certifications (YKB), medical clearances, and long-term absences (sick leave, parental leave).

### 2.2 Workforce Planning (`workforce-planning/`)
*   **Responsibility:** Rostering, Scheduling, and Union Rule validation.
*   **Context:** Takes the required operational output from `Traffic` ("We need X drivers in Norrtälje tomorrow") and creates legal shift assignments, adhering to the complex constraints defined in the Swedish *Bussbranschavtalet* and EU driving time regulations.

### 2.3 Driver Operations (`driver-operations/`)
*   **Responsibility:** Real-time execution, Time & Attendance, and Exception Handling.
*   **Context:** Handles what happens *today*. Manages morning sick-calls, clock-ins at the edge device on the bus, tracks actual driving versus resting time, and triggers automated reassignments if a driver is delayed.