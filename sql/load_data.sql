-- loading data into the table
COPY fmcsa_carrier_compliance (
    carrier_name,
    dot_number,
    safety_rating,
    insurance_status,
    total_inspections,
    out_of_service_pct,
    last_inspection_date
)
FROM '/Users/atharvabhalilkar/Documents/freight-analytics/data/raw/fmcsa_carrier_compliance.csv'
DELIMITER ','
CSV HEADER;

select * from fmcsa_carrier_compliance;

-- loading data into the table
COPY scms_delivery_history (
    id,
    country,
    vendor_inco_term,
    shipment_mode,
    scheduled_delivery_date,
    delivered_to_client_date,
    vendor,
    line_item_quantity,
    line_item_value,
    weight_kgs,
    freight_cost_usd,
    line_item_insurance_usd
)
FROM '/Users/atharvabhalilkar/Documents/freight-analytics/data/raw/scms_delivery_history_clean.csv'
DELIMITER ','
CSV HEADER;

select * from scms_delivery_history;
select count(*) from scms_delivery_history;

-- loading data into the table
COPY dataco_supply_chain (
    order_id,
    order_date,
    shipping_mode,
    delivery_status,
    order_status,
    customer_country,
    customer_city,
    order_region,
    sales,
    profit,
    order_quantity,
    days_for_shipping_real,
    days_for_shipment_scheduled,
    late_delivery_risk
)
FROM '/Users/atharvabhalilkar/Documents/freight-analytics/data/raw/dataco_supply_chain_clean.csv'
DELIMITER ','
CSV HEADER;

select * from dataco_supply_chain;
select count(*) from dataco_supply_chain;
