# Bank Gateway - Data Model

## 1. External Formats (Yttre Ring)

### Entity: `BankgirotPayment`
*   `amount`: Decimal
*   `reference`: String (OCR or Invoice Number)
*   `paymentDate`: Date

## 2. API Endpoints (Simulation)
*   `POST /simulate/bankgiro`: Allows manual injection of payment files into the lab environment.
