# Policy: General Data Protection Regulation (GDPR) Compliance in Software Engineering

## 1. Introduction & Scope
This policy defines the engineering requirements and architectural constraints necessary to ensure the Kalles Buss platform complies with the EU General Data Protection Regulation (GDPR). 

As a software-defined public transport operator, Kalles Buss primarily develops HR systems, workforce management, and driver support applications. Therefore, **Kalles Buss acts as the Data Controller primarily for its employees (drivers, mechanics, administrative staff)**. Passenger ticket and payment data are handled externally by the transport authority (e.g., SL) and are largely out of scope for Kalles Buss's internal systems, unless specifically ingested for operational incidents.

This policy applies to all autonomous agents, human developers, and software components operating within the Kalles Buss ecosystem.

## 2. Privacy by Design and by Default (Article 25)
All software developed for Kalles Buss must embed privacy into its architecture. 

### 2.1 Data Minimization on the Event Bus
*   **Constraint:** The distributed event bus is the central nervous system of Kalles Buss. Personally Identifiable Information (PII) must **not** be broadcasted in plain text on the event bus unless absolutely necessary for the consuming domain.
*   **Implementation:** Systems must favor the "Claim-Check" pattern or publish opaque reference IDs (e.g., `DriverId`) instead of raw PII (e.g., `DriverName`, `SocialSecurityNumber`). Only authorized services may resolve these IDs to real identities via secure, audited APIs.

### 2.2 Immutable Data and "Crypto-Shredding"
*   **Constraint:** Event-sourced architectures rely on immutable logs. Because data cannot be easily altered or deleted from an immutable log, PII must never be stored directly in an event payload if it is subject to the Right to Erasure.
*   **Implementation:** If PII must be tied to a permanent event, the system must utilize **Crypto-Shredding**. The PII is encrypted with a unique, per-data-subject encryption key. To "delete" the user's data from the immutable log, the specific encryption key is deleted from the central Key Management System (KMS), rendering the stored PII permanently and irreversibly unreadable.

### 2.3 Automated Data Retention and Deletion
*   **Constraint:** Data must not be kept longer than necessary for its designated purpose.
*   **Implementation:** All data stores (databases, caches, data lakes) containing PII must implement automated Time-To-Live (TTL) policies or background eviction jobs. For example, driver geolocation telemetry must be aggregated and anonymized after the operational shift ends, retaining only non-identifiable metrics for historical analysis.

## 3. Supporting Data Subject Rights (Articles 15-22)
The software platform must programmatically support the rights of the information holders.

### 3.1 Right of Access (Data Portability)
*   **Requirement:** HR and workforce management systems must expose internal APIs capable of aggregating all PII associated with a specific employee (`DriverId`) into a standardized, machine-readable format (e.g., JSON) upon request.

### 3.2 Right to Erasure ("Right to be Forgotten")
*   **Requirement:** The platform must provide an automated mechanism to execute a "Right to Erasure" request when an employee leaves the company or withdraws consent (where applicable).
*   **Execution:** Triggering this process must cascade across all domain services (HR, Traffic, Energy) to either hard-delete the user's data, anonymize it (e.g., replacing `DriverId` with a static `DeletedUser` UUID to preserve statistical integrity of historical bus routes), or execute crypto-shredding on immutable logs. Legal obligations (e.g., tax laws, mandatory driving rest logs) supersede this right and must be logically protected from deletion until their statutory retention period expires.

### 3.3 Right to Rectification
*   **Requirement:** Master data management systems (e.g., the HR domain) must act as the Single Source of Truth (SSOT) for employee PII. Updates to PII must propagate reliably to all downstream consumers via integration events to ensure data accuracy across the fleet.

## 4. Domain-Specific PII Guidelines

### 4.1 HR & Workforce Management (Highly Sensitive)
*   **Data Types:** Social security numbers, union affiliations, health data, scheduling, and legally mandated rest-time logs.
*   **Constraint:** This data is classified as `Strictly Confidential`. Access is restricted via strict Role-Based Access Control (RBAC). Processing of health and rest times is justified under the legal obligation to comply with traffic safety laws (e.g., Kör- och vilotider), and must be preserved securely for required auditing periods.

### 4.2 Driver Telematics & Performance
*   **Data Types:** Bus telemetry linked to an active driver (speeding, braking patterns, geolocation).
*   **Constraint:** Performance monitoring data must only be processed for safety, training, and route optimization purposes. Systems must automatically mask driver identities when this data is exposed to fleet analysts. Telematics are only linked to individuals during authorized, audited HR/safety reviews.

### 4.3 Passenger Data
*   **Data Types:** Surveillance footage, incident reports (accidents, lost and found).
*   **Constraint:** Passenger data is minimal. Any ingestion of passenger PII must be strictly isolated. Video surveillance from buses must be heavily encrypted at the edge (on the bus) and automatically purged after a short statutory timeframe (e.g., 24-72 hours) unless preserved and exported for an active law enforcement investigation.

## 5. Audit & Observability
*   **Requirement:** Every read, modification, or deletion of `Confidential` or `Strictly Confidential` PII must be logged in an immutable audit trail.
*   **Constraint:** Audit logs themselves must be structurally scrubbed of PII. They should log *who* accessed *whose* data (using opaque IDs), *when*, and the *business system justification*, without logging the actual sensitive payload.