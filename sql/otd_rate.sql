-- OTD (On-Time Delivery) rate
SELECT
    shipping_mode,
    ROUND(
        COUNT(CASE WHEN delivery_status = 'Shipping on time' 
                   OR delivery_status = 'Advance shipping' THEN 1 END)::NUMERIC 
        / COUNT(*) * 100
    , 2) AS otd_rate
FROM dataco_supply_chain
WHERE delivery_status != 'Shipping Cancelled'
GROUP BY shipping_mode;


select delivery_status, shipping_mode
from dataco_supply_chain;