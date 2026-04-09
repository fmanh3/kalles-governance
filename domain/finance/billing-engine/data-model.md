# Billing Engine - Data Model

## 1. Domain Entities

### Entity: `Contract`
*   `id`: UUID
*   `line_id`: String
*   `km_tariff`: Decimal
*   `boarding_bonus`: Decimal
*   `currency`: String

### Entity: `Invoice`
*   `id`: UUID
*   `invoice_number`: String (Unique)
*   `customer_name`: String
*   `amount_total`: Decimal
*   `amount_vat`: Decimal
*   `due_date`: Date
*   `status`: Enum (DRAFT, PENDING_PAYMENT, PAID, OVERDUE)
