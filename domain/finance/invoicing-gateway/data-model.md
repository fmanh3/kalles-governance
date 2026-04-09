# Invoicing Gateway - Data Model

## 1. External Source Mappings

### Entity: `RawInvoice`
*   `file_url`: String
*   `received_at`: DateTime
*   `source`: Enum (EMAIL, PORTAL, PEPPOL)
*   `metadata`: JSON
