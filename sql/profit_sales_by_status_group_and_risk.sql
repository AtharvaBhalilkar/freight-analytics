-- Total profit and sales by delivery group (on-time vs late/cancelled)
-- Uses SUM to compare overall revenue impact across delivery outcomes
select ROUND(SUM(profit), 2) as total_proft, ROUND(SUM(sales), 2) as total_sales,
CASE
  WHEN delivery_status IN ('Shipping on time', 'Advance shipping') THEN 'On Time'
  WHEN delivery_status IN ('Late delivery', 'Shipping canceled') THEN 'Late/Cancelled'
END AS delivery_group
from dataco_supply_chain
group by delivery_group;

-- Average profit and sales per order by delivery group
-- Uses AVG to fairly compare performance regardless of order volume
select ROUND(AVG(profit), 2) as avg_profit, ROUND(AVG(sales), 2) as avg_sales,
CASE
  WHEN delivery_status IN ('Shipping on time', 'Advance shipping') THEN 'On Time'
  WHEN delivery_status IN ('Late delivery', 'Shipping canceled') THEN 'Late/Cancelled'
END AS delivery_group
from dataco_supply_chain
group by delivery_group;

-- Average profit and sales broken down by late_delivery_risk flag and delivery group
-- Checks whether high-risk orders (1) underperform low-risk orders (0)
select ROUND(AVG(profit), 2) as avg_profit, ROUND(AVG(sales), 2) as avg_sales, late_delivery_risk,
CASE
  WHEN delivery_status IN ('Shipping on time', 'Advance shipping') THEN 'On Time'
  WHEN delivery_status IN ('Late delivery', 'Shipping canceled') THEN 'Late/Cancelled'
END AS delivery_group
from dataco_supply_chain
group by late_delivery_risk, delivery_group;

-- Average profit and sales by exact delivery status and risk flag
-- Granular view to confirm whether late_delivery_risk maps directly to delivery outcomes
SELECT ROUND(AVG(profit), 2) as avg_profit,
       ROUND(AVG(sales), 2) as avg_sales,
       late_delivery_risk, delivery_status
FROM dataco_supply_chain
GROUP BY late_delivery_risk, delivery_status;