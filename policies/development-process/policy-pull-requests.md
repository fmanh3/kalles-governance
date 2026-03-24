# Policy: Pull Requests & Change Management

## 1. Traceability & Change Management (LIS A.8.32)
*   **Single Source of Truth:** All changes to application code, agent prompts, and infrastructure (Terraform) must be proposed via a Pull Request (PR) targeting the `main` branch.
*   **Issue Linking:** Every PR must reference a specific tracked work item (e.g., GitHub Issue, Jira Ticket) in its description (e.g., `Resolves #123`).
*   **Conventional Commits:** PR titles and commit messages must follow the Conventional Commits specification (e.g., `feat(hr): add crypto-shredding to payroll`, `fix(traffic): resolve routing loop`).

## 2. Mandatory PR Checks (CI Guardrails)
To satisfy the Secure Development Lifecycle (LIS A.8.25), the CI pipeline (e.g., GitHub Actions/Cloud Build) will automatically block merging if any of the following fail:
1.  **Code Quality:** `Ruff` linting and `mypy` type-checking must pass.
2.  **Tests:** `pytest` suite must pass with a minimum line coverage of 80%.
3.  **Security Scans:** 
    *   No exposed secrets (`gitleaks`).
    *   No critical vulnerabilities in Python dependencies (`Safety` / `Dependabot`).
    *   No static code vulnerabilities (`Bandit`).

## 3. GDPR Compliance Guardrails
The Pull Request template must contain a mandatory checklist enforcing **Privacy by Design (GDPR Article 25)**.

*   [ ] **DPIA Check:** Does this PR introduce new processing of `Confidential` or `Strictly Confidential` data (e.g., driver telematics, HR records)? 
    *   *If yes, link the approved Data Protection Impact Assessment (DPIA) here:* ________
*   [ ] **Data Minimization:** Does the event schema adhere to the Claim-Check pattern, keeping plain-text PII off the event bus?
*   [ ] **Purpose Metadata:** Are the `purpose` and `legal_basis` fields populated in the event metadata?

## 4. Peer Review
*   No human or agent can merge their own code directly. 
*   At least **one approved review** is required from a designated `CODEOWNER` of the specific domain (HR, Traffic, Energy) before the PR can be merged and deployed.