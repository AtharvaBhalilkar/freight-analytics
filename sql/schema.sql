-- Carrier compliance data from FMCSA synthetic dataset

create table fmcsa_carrier_compliance (
	carrier_name varchar,
	dot_number integer primary key,
	safety_rating text,
	insurance_status text,
	total_inspections integer,
	out_of_service_pct numeric(5, 2),
	last_inspection_date date 
);

-- Carrier compliance data from SCMS Delivery History dataset

create table scms_delivery_history (
	ID VARCHAR primary key,
	country text,
	vendor_inco_term text,
	shipment_mode text,
	scheduled_delivery_date date,
	delivered_to_client_date date,
	vendor text,
	line_item_quantity integer,
	line_item_value NUMERIC,
	weight_kgs numeric,
	freight_cost_usd numeric,
	line_item_insurance_usd numeric
);

-- Carrier compliance data from Dataco Supply Chain dataset

create table dataco_supply_chain (
	shipment_id serial primary key,
	order_id varchar,
	order_date date,
	shipping_mode text,
	delivery_status text,
	order_status text,
	customer_country text,
	customer_city text,
	order_region text,
	sales numeric,
	profit numeric,
	order_quantity integer,
	days_for_shipping_real integer,
	days_for_shipment_scheduled integer,
	late_delivery_risk smallint
);
