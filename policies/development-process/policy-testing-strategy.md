# Policy: Testing Strategy

## 1. Standard Tooling
*   **Framework:** `pytest` is the mandatory testing framework for all Python microservices and agents.
*   **Mocking & Emulation:** Code should rely on `unittest.mock` for isolating business logic. For GCP integration testing, prefer local GCP Emulators (e.g., Pub/Sub emulator, Firestore emulator) or Testcontainers over mocking client libraries directly.

## 2. Test Pyramid & Automation

### 2.1 Unit Testing
*   Validates isolated business logic, agent decision trees, and domain models.
*   Must be fast and not require external network access.

### 2.2 Integration Testing
*   Validates interactions between Python code and GCP services (Cloud SQL, Pub/Sub).
*   Must verify that IAM roles and Workload Identities are configured correctly.

### 2.3 Security & Compliance Testing (LIS A.8.25)
Security testing is highly automated and integrated into the CI/CD pipeline:
*   **SAST:** `Bandit` must run on all Python code to catch common security flaws (e.g., SQL injection, insecure cryptography).
*   **SCA:** Software Composition Analysis must run daily to flag CVEs in open-source Python packages.
*   **Secret Scanning:** Repositories are scanned continuously to ensure no GCP keys or API tokens are checked in.

## 4. GDPR & Privacy Testing
Testing privacy mechanisms is as critical as testing business logic.

*   **Crypto-Shredding Validation:** Integration tests must empirically prove that deleting a mock user's KMS key renders their stored encrypted data unreadable in the test database (GDPR Policy 2.2).
*   **Telemetry Masking:** Tests must verify that when driver telematics are pushed to the analytics pipeline, the `DriverId` is correctly scrubbed or hashed before reaching BigQuery.

## 5. Agent "Shadow Mode" & Chaos Engineering
*   **Agent Validation:** Before an autonomous agent is allowed to make live operational decisions (e.g., re-routing a bus), new agent logic must be tested in "Shadow Mode" by replaying historical Pub/Sub events and analyzing the agent's proposed actions against expected baselines.
*   **Resilience (LIS A.5.30):** The platform should periodically run automated Chaos Engineering tests (e.g., simulating a Trafiklab API outage or a GCP zone failure) to ensure agents degrade gracefully and fallback mechanisms function correctly.