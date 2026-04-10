# Depot & Maintenance - Data Model

## 1. Asset Hierarchy
### Entity: `AssetCategory`
* `id`: UUID
* `name`: String (e.g., "Fordon", "Laddinfrastruktur")
* `parent_category_id`: UUID (Self-referencing for trees)

### Entity: `AssetModel`
* `id`: UUID
* `name`: String (e.g., "Volvo 7900 Electric 18m")

### Entity: `Asset`
* `id`: String (Primary Key, e.g., "BUSS-101")
* `model_id`: UUID (FK to AssetModel)
* `status`: Enum (ACTIVE, MAINTENANCE, DECOMMISSIONED)
* `vin_number`: String

## 2. Supply Chain & Parts
### Entity: `InternalItem`
* `id`: String (e.g., "KB-FILTER-001")
* `description`: String
* `stock_level`: Integer

### Entity: `ItemSupplierMapping` (Catalog)
* `internal_item_id`: String (FK to InternalItem)
* `vendor_id`: UUID (FK to Finance Domain's Vendor)
* `vendor_part_number`: String
* `price`: Decimal
* `lead_time_days`: Integer

### Entity: `PurchaseOrder`
* `id`: UUID
* `vendor_id`: UUID
* `total_amount`: Decimal
* `status`: Enum (CREATED, SENT, RECEIVED)
