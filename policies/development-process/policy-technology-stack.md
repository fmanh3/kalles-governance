# Policy: Technology Stack

## 1. Core Programming Language
*   **Python 3.11+** is the designated language for all backend services, autonomous agents, data pipelines, and infrastructure automation within the Kalles Buss platform.
*   **Dependency Management:** `Poetry` or `uv` must be used to manage environments and lock dependencies deterministically, ensuring reproducible builds.

## 2. Cloud Platform: Google Cloud Platform (GCP)
Kalles Buss is a cloud-native platform hosted on Google Cloud Platform. Services must prefer managed, serverless offerings to minimize operational overhead.

### 2.1 Compute & Execution
*   **Microservices & APIs:** Cloud Run (serverless containers).
*   **Event-Driven Agents:** Cloud Run or Cloud Functions, triggered directly via Eventarc/Pub/Sub.
*   **Heavy Batch/ML Jobs:** GKE (Google Kubernetes Engine) Autopilot or Vertex AI.

### 2.2 Event Bus & Integration (LIS A.5.14)
*   **Message Broker:** Cloud Pub/Sub is the central event bus for the platform.
*   **Data Masking:** External data ingested into Pub/Sub must pass through Cloud Data Loss Prevention (DLP) for automated PII masking where required (Aligns with GDPR 2.1 & LIS A.8.11).

### 2.3 Storage
*   **Relational Data:** Cloud SQL (PostgreSQL).
*   **Document/NoSQL:** Firestore (ideal for agent state and rapid schema evolution).
*   **Data Lake/Analytics:** BigQuery.

### 2.4 Security & Identity Architecture
*   **Authentication (LIS A.8.5):** Static credentials are strictly forbidden. All Python microservices and agents must authenticate to GCP APIs and each other using **Workload Identity Federation**.
*   **Secret Management:** Google Secret Manager must be used for all external API keys (e.g., Trafiklab).
*   **Encryption & Crypto-Shredding (GDPR 2.2):** Google Cloud Key Management Service (KMS) must be used. Per-user Customer Managed Encryption Keys (CMEK) are required to implement crypto-shredding for immutable data stores.

## 3. Infrastructure as Code (IaC)
*   **Tooling:** Terraform is mandatory for all infrastructure and IAM provisioning.
*   **Cloud Exit Strategy (LIS A.5.23):** While GCP is the target, Terraform state must be structured cleanly to facilitate portability testing in alignment with the EU Data Act.