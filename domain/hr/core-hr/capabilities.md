# Core HR - Capabilities

## 1. Domain Purpose
Core HR is the master system of record for all personnel. It handles highly sensitive, strictly regulated PII and compliance data. It acts as the gatekeeper; if Core HR invalidates a driver, no other domain can assign them to a vehicle.

## 2. Core Capabilities

### 2.1 License & Certification Compliance (Gatekeeper)
*   Tracks the expiration dates of critical legal documents:
    *   **Driving License (Körkort):** Class D (Bus).
    *   **YKB (Yrkeskompetensbevis):** Mandatory European professional driver certificate.
    *   **Medical Clearances:** Mandatory health checks for commercial drivers.
*   **Automated Interlock:** If any required certificate expires or is revoked (e.g., via integration with Transportstyrelsen), the system automatically changes the driver's state to `Unfit_For_Duty` and cancels all upcoming scheduled shifts.

### 2.2 Absence Management
*   Manages the lifecycle of long-term absences (Vacation, Parental Leave, Long-term Sickness).
*   Updates the driver's global `Availability` state, ensuring `Workforce Planning` does not schedule them.

### 2.3 Base Compensation & Union Master
*   Holds the employee's base salary parameters, employment fraction (e.g., 75% or 100%), and which specific collective agreement applies to them (consumed by the `Payroll Engine`).

## 3. The A-A-H Escalation Model in Core HR

### Level 1: Straight-Through Automation
*   **Scenario:** A driver's YKB is valid for 5 years. The system checks the date nightly.
*   **Action:** 6 months before expiration, it automatically emails the driver to book a renewal course. 1 month before, it alerts their manager.

### Level 2: AI Agent Resolution
*   **Scenario:** A driver uploads a scanned PDF of their renewed medical clearance certificate from a private clinic.
*   **Action:** The HR Compliance Agent uses OCR and NLP to extract the doctor's name, clinic details, and the "Fit for duty" checkbox. It verifies the clinic against a national registry, updates the expiration date in the database to +5 years, and archives the document.

### Level 3: Human-in-the-Loop
*   **Scenario:** Transportstyrelsen's API reports that a driver's license has been suspended (Indraget körkort) overnight.
*   **Action:** The system immediately blocks the driver from logging into any bus. It raises a "Critical HR Incident" for the HR Director to manually contact the driver, initiate suspension protocols, and arrange a union meeting.