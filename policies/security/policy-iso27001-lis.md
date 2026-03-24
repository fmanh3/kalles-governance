# Policy: ISO/IEC 27001:2022 Leader's Implementation Strategy (LIS)

## 1. Introduction

This document outlines the Leader's Implementation Strategy (LIS) for information security at Kalles Buss, aligned with a selection of controls from the ISO/IEC 27001:2022 standard. As a 'Transport-as-a-Code' platform, our security posture is defined and enforced through software, automation, and data-driven policies. This LIS serves as a foundational guide for both human and autonomous agents in designing, developing, and operating the Kalles Buss ecosystem.

The selected controls represent the most critical security considerations for our cloud-native, event-driven architecture. This is a living document, intended to evolve as the platform matures.

## 2. Selected ISO/IEC 27001:2022 Controls

### A.5 Organizational Controls

---

#### **A.5.1 Policies for information security**

*   **Objective:** To ensure there is a clear, management-approved direction for information security that is communicated to all relevant stakeholders.
*   **Policy Statement:** All information security policies for Kalles Buss shall be defined as code and managed in this Git repository (`kalles-governance`). Policies will be version-controlled, subject to peer review via pull requests, and automatically disseminated to relevant systems and agents upon merge. The hierarchy and scope of all policies will be explicitly defined.

---

#### **A.5.9 Inventory of information and other associated assets**

*   **Objective:** To identify all information assets and their dependencies to manage them effectively and apply appropriate protections.
*   **Policy Statement:** All data streams (events), data stores, services, and infrastructure components within the Kalles Buss platform must be registered in a central, machine-readable asset inventory. Ownership for each asset must be assigned to a specific business domain (e.g., HR, Traffic, Energy), and this ownership shall govern access and lifecycle management.

---

#### **A.5.12 Classification of information**

*   **Objective:** To classify information based on its sensitivity, criticality, and legal requirements to ensure it receives an appropriate level of protection.
*   **Policy Statement:** All data within Kalles Buss events and data stores must be classified at the point of creation with one of four levels: `Public`, `Internal`, `Confidential`, or `Strictly Confidential`. This classification tag will be a mandatory field in all event schemas and will be used by automated systems to enforce access control, encryption, and data retention rules.

---

#### **A.5.14 Information transfer**

*   **Objective:** To protect information during transfer to prevent unauthorized access, modification, or destruction.
*   **Policy Statement:** All information transfer between Kalles Buss services, and to/from external endpoints, must occur over encrypted channels (e.g., TLS 1.2+). Data classified as `Confidential` or higher must have its integrity and authenticity verified upon receipt. Transfer rules, particularly for cross-domain communication, shall be defined and enforced at the service mesh or API gateway layer.

---

#### **A.5.15 Access control**

*   **Objective:** To ensure that access to information and other associated assets is limited to authorized individuals and processes.
*   **Policy Statement:** Access to all Kalles Buss resources shall be governed by the principle of least privilege and implemented through a Role-Based Access Control (RBAC) model. Roles and permissions will be defined as code, aligned with business functions, and automatically enforced. All access decisions must be logged to a central, immutable audit trail.

---

#### **A.5.19 Information security in supplier relationships**

*   **Objective:** To agree on and document the information security requirements for mitigating the risks associated with supplier's access to the organization's assets.
*   **Policy Statement:** Kalles Buss relies heavily on external data providers (e.g., Trafiklab, Samtrafiken, SL) and physical infrastructure partners (e.g., external depots, charging stations). All integrations must employ zero-trust principles. Agents must validate and sanitize all incoming external data and maintain fallback mechanisms for critical operational data to ensure resilience against third-party compromise or outages.

---

#### **A.5.23 Information security for use of cloud services**

*   **Objective:** To establish requirements for securing the use of cloud services to protect the organization's information.
*   **Policy Statement:** All cloud services used by the Kalles Buss platform must be approved and configured according to a defined security baseline, managed via Infrastructure as Code (IaC). The use of cloud services will be continuously monitored for compliance with this baseline, and any deviations must trigger an automated alert or remediation action. Shared responsibility models with cloud providers will be explicitly documented for each service.

---

#### **A.5.24 Information security incident management planning and preparation**

*   **Objective:** To plan and prepare for managing information security incidents effectively.
*   **Policy Statement:** Automated incident response playbooks shall be defined as code. In the event of a compromised or malfunctioning autonomous agent, the platform must support automated "kill switches" to isolate the rogue agent and instantly revert affected operations to "Shadow Mode" or a known-good baseline, minimizing impact on the physical bus fleet.

---

#### **A.5.30 ICT readiness for business continuity**

*   **Objective:** To ensure the availability of information and communication technology (ICT) and the resilience of systems to disruption.
*   **Policy Statement:** The Kalles Buss platform will be designed for high availability and disaster recovery, leveraging the resilience capabilities of the underlying cloud provider. Critical services will be deployed across multiple availability zones. Recovery Time Objectives (RTO) and Recovery Point Objectives (RPO) for each service shall be defined and regularly tested through automated chaos engineering experiments.

---

### A.6 People Controls

---

#### **A.6.3 Information security awareness, education and training**

*   **Objective:** To ensure all employees and contractors are aware of their information security responsibilities.
*   **Policy Statement:** Developers and operators building autonomous agents and Infrastructure-as-Code (IaC) must undergo specific training on the security implications of automated decision-making. Awareness of "Policy as Code" and the security guardrails within the governance repository is mandatory for all contributors to the Kalles Buss platform.

---

### A.7 Physical Controls

---

#### **A.7.8 Equipment siting and protection**

*   **Objective:** To protect equipment from physical and environmental threats and unauthorized access.
*   **Policy Statement:** Physical edge devices operating within the Kalles Buss fleet (e.g., driver tablets, GPS trackers, ticket validators) must be physically secured against tampering. Devices must be provisioned with minimal local state, strongly authenticated to the central event bus, and encrypted at rest to protect localized data in the event of theft or loss.

---

#### **A.7.14 Secure disposal or re-use of equipment**

*   **Objective:** To ensure that equipment containing storage media is verified to be free of sensitive data and licensed software prior to disposal or re-use.
*   **Policy Statement:** Any physical hardware decommissioned from the fleet (e.g., bus telematics systems, driver interfaces) must undergo a certified cryptographic wipe or physical destruction process. Automated logging must verify the decommissioning of the device's identity from the platform's asset inventory before disposal.

---

### A.8 Technological Controls

---

#### **A.8.2 Privileged access rights**

*   **Objective:** To manage, restrict, and monitor the use of privileged access rights to prevent their misuse.
*   **Policy Statement:** Privileged access (e.g., administrative access to cloud infrastructure, production databases) shall be strictly time-bound, role-based, and require multi-factor authentication. All privileged sessions must be logged and subject to automated review for anomalous activity. The use of standing privileged accounts is prohibited; just-in-time (JIT) access will be the default mechanism.

---

#### **A.8.3 Information access restriction**

*   **Objective:** To ensure that access to information is restricted at both the logical and physical levels according to the defined access control policy.
*   **Policy Statement:** Information access shall be enforced based on the data's classification and the authenticated identity's role. Data filtering and masking shall be applied automatically at the data access layer based on these attributes. Direct access to data stores will be forbidden for all users and services; all access must be brokered through well-defined, audited APIs.

---

#### **A.8.5 Secure authentication**

*   **Objective:** To verify the identity of users, processes, or devices to ensure that only authorized entities can access systems and information.
*   **Policy Statement:** All actors (human and machine) interacting with the Kalles Buss platform must authenticate using strong, managed identities (e.g., OAuth 2.0, OpenID Connect, Managed Identities). Autonomous agents and microservices must utilize Workload Identities (e.g., SPIFFE) to ensure that every action on the event bus is cryptographically tied to a specific agent version. The use of static credentials like passwords or API keys in code or configuration is strictly prohibited. All credentials must be centrally managed and rotated automatically.

---

#### **A.8.8 Management of technical vulnerabilities**

*   **Objective:** To obtain information about technical vulnerabilities of information systems being used, evaluate the organization's exposure to such vulnerabilities, and take appropriate measures to address the associated risk.
*   **Policy Statement:** As a system built on open-source software (GPL-3.0), Kalles Buss shall employ automated Software Composition Analysis (SCA) to continuously monitor dependencies. Automated dependency updates (e.g., Dependabot, Renovate) must be integrated into the CI/CD pipeline. Critical vulnerabilities (CVEs) must trigger automated alerts and be patched within strictly defined Service Level Agreements (SLAs).

---

#### **A.8.9 Configuration management**

*   **Objective:** To manage the secure configuration of technology to prevent unauthorized changes and ensure system integrity.
*   **Policy Statement:** The entire configuration of the Kalles Buss platform—including infrastructure, services, networks, and security settings—shall be defined as code (IaC). All changes must go through a version-controlled, peer-reviewed approval process. The live configuration state will be continuously monitored against the defined state in the repository, and any drift must be automatically remediated.

---

#### **A.8.11 Data masking**

*   **Objective:** To ensure that sensitive data is appropriately protected in accordance with legal, statutory, regulatory, and contractual requirements.
*   **Policy Statement:** Automated data masking and anonymization must be enforced at the event bus layer before data is written to data lakes or analytics platforms. This is critical for HR/Personal data and passenger information to ensure strict adherence to GDPR. Unmasked `Confidential` data is only accessible via temporary, audited, just-in-time (JIT) elevation by authorized systems.

---

#### **A.8.12 Data leakage prevention**

*   **Objective:** To detect and prevent the unauthorized disclosure and extraction of information from systems and networks.
*   **Policy Statement:** Automated data leakage prevention (DLP) tools shall be applied to monitor and control the flow of data, particularly at network egress points and in data stores containing `Confidential` or `Strictly Confidential` information. Policies will be configured to scan for and block patterns matching sensitive data types (e.g., personal identity numbers, financial information) from leaving their designated boundaries.

---

#### **A.8.16 Monitoring activities**

*   **Objective:** To monitor networks, systems, and applications for anomalous behavior and to ensure the effectiveness of information security controls.
*   **Policy Statement:** The Kalles Buss platform must be continuously monitored across multiple dimensions to ensure security, operational stability, and availability. All monitoring data shall be collected into a central system capable of analysis, correlation, and alerting.
*   **Centralized Logging & Metrics:** All services and infrastructure components must emit structured logs (e.g., JSON) and key performance metrics to a central observability platform.
*   **Security Monitoring:** The platform must actively monitor, log, and alert on security-related events, including but not limited to authentication failures, authorization denials, potential intrusion attempts (e.g., port scanning), and suspected data exfiltration.
*   **Operational & Performance Monitoring:** System health and performance indicators (e.g., request latency, error rates, resource utilization) must be continuously measured to identify trends, predict future issues, and ensure adherence to Service Level Objectives (SLOs).
*   **Troubleshooting & Diagnostics:** All unhandled application exceptions must generate a log event containing a full, correlated stack trace. Distributed tracing must be implemented to allow the complete lifecycle of a transaction to be visualized across all involved services.
*   **Automated Alerting:** An automated alerting system must be configured to immediately notify the responsible domain (agent or team) via a secure channel upon detection of critical security incidents, performance degradation, or system failures.
*   **Log Retention:** A log retention policy must be enforced automatically based on the data type:
    *   Security and audit logs: Minimum 365 days.
    *   Application and debug logs: Minimum 30 days.
    *   Aggregated performance metrics: Minimum 1 year.

---

#### **A.8.24 Use of cryptography**

*   **Objective:** To ensure the proper and effective use of cryptography to protect the confidentiality, integrity, and availability of information.
*   **Policy Statement:** Cryptographic controls shall be applied based on the classification of data. All cryptographic standards, algorithms, and key lengths must be approved by the security governance team and defined herein.
*   **Encryption of Data in Transit:** All network traffic, both on internal and external networks, must be encrypted using at least Transport Layer Security (TLS) 1.2, with TLS 1.3 being the preferred standard. Internal service-to-service communication must be secured using a service mesh that enforces mutual TLS (mTLS).
*   **Encryption of Data at Rest:** All data classified as `Internal` or higher that is stored persistently (e.g., in databases, object storage, or on virtual disks) must be encrypted using at least AES-256 or an equivalent strong algorithm.
*   **Cryptographic Key Management:** All cryptographic keys are critical assets and must be managed exclusively through an approved, centralized Key Management Service (KMS), such as Azure Key Vault or AWS KMS. Keys must never be stored in source code, configuration files, or logs. All keys must have a defined lifecycle, including automated rotation policies appropriate for their usage and data classification.

---

#### **A.8.25 Secure development lifecycle**

*   **Objective:** To embed security activities and controls throughout the entire system and software development lifecycle.
*   **Policy Statement:** Security shall be integrated into every phase of the Kalles Buss development lifecycle ('''Shift Left'''). This includes mandatory threat modeling for new services, automated security scanning (SAST, DAST, SCA) in CI/CD pipelines, and security-focused code review checklists. All development activities must adhere to the processes defined in the `kalles-governance/policies/development-process/` directory.

---

#### **A.8.28 Secure coding**

*   **Objective:** To ensure that software is written to be secure, reducing the number of vulnerabilities introduced into the platform.
*   **Policy Statement:** All code committed to the Kalles Buss platform must adhere to secure coding principles, including input validation, output encoding, proper error handling, and resource management. These principles will be enforced through a combination of static analysis tools, code linters, and mandatory peer reviews. The OWASP Top 10 will serve as a baseline for common vulnerabilities to prevent.

---

#### **A.8.32 Change management**

*   **Objective:** To ensure that all changes to information processing facilities and systems are controlled, assessed for security impact, and properly authorized.
*   **Policy Statement:** All changes to the Kalles Buss production environment, including code, configuration, and infrastructure, must follow a formal change management process managed through Git. Every change must be traceable to an approved work item, be automatically tested, and be peer-reviewed before deployment. An immutable log of all production changes will be maintained automatically.