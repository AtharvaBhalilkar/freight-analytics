-- View column names for the USAID delivery history dataset
select column_name FROM information_schema.columns WHERE table_name = 'scms_delivery_history';

-- Preview the USAID delivery history dataset to understand structure and values
select * from scms_delivery_history;

-- Average freight cost per kg by shipment mode
-- Excludes zero-weight rows to avoid division errors
-- Identifies cost differences between Air, Ocean, Truck and Air Charter
select shipment_mode, round(avg(freight_cost_usd / weight_kgs), 2) as avg_per_kg_cost_shipment_mode
from scms_delivery_history
where weight_kgs != 0
group by shipment_mode;

-- Billing audit: flags shipments costing more than 2x the average for their mode
-- CTE calculates the baseline average cost per kg by shipment mode
-- Main query joins each shipment to its mode average and computes times_over_avg
-- Ordered by most suspicious shipments first
WITH avg_costs AS (
    SELECT shipment_mode, ROUND(AVG(freight_cost_usd / weight_kgs), 2) as avg_cost_per_kg
    FROM scms_delivery_history
    WHERE weight_kgs != 0
    GROUP BY shipment_mode
)
SELECT s.shipment_mode,
       s.freight_cost_usd,
       s.weight_kgs,
       ROUND(s.freight_cost_usd / s.weight_kgs, 2) as cost_per_kg,
       a.avg_cost_per_kg,
       ROUND((s.freight_cost_usd / s.weight_kgs) / a.avg_cost_per_kg, 1) AS times_over_avg
FROM scms_delivery_history s
JOIN avg_costs a ON s.shipment_mode = a.shipment_mode
WHERE s.weight_kgs != 0
AND (s.freight_cost_usd / s.weight_kgs) > (a.avg_cost_per_kg * 2)
ORDER BY times_over_avg DESC;