-- Preview the FMCSA carrier compliance dataset to understand structure and values
select * from fmcsa_carrier_compliance
limit 5;

-- Count of carriers by safety rating to understand the distribution of safe vs unsafe carriers
select safety_rating, count(carrier_name) as carrier_count
from fmcsa_carrier_compliance
group by safety_rating;

-- Average out-of-service percentage by safety rating
-- Higher out-of-service rates are expected for lower-rated carriers
select safety_rating, ROUND(AVG(out_of_service_pct), 2) as avg_out_of_service_pct
from fmcsa_carrier_compliance
group by safety_rating;

-- Average number of inspections by safety rating
-- Satisfactory carriers tend to have more inspections due to higher shipment volumes
select safety_rating, ROUND(AVG(total_inspections), 2) as avg_count_of_inspection
from fmcsa_carrier_compliance
group by safety_rating;

-- Count of carriers by insurance status (Active vs Lapsed)
-- Identifies how many carriers have lapsed insurance and pose a compliance risk
SELECT insurance_status, COUNT(insurance_status) AS status_count
FROM fmcsa_carrier_compliance
GROUP BY insurance_status;

-- Days since last inspection for each carrier, ordered by most overdue first
-- Helps identify carriers that may be due or overdue for a compliance inspection
SELECT carrier_name, last_inspection_date, (CURRENT_DATE - last_inspection_date) AS days_since_inspection
FROM fmcsa_carrier_compliance
ORDER BY days_since_inspection DESC;

-- Cross-reference lapsed insurance carriers with their inspection history
-- Flags carriers with both lapsed insurance and long gaps since last inspection
-- These carriers represent the highest compliance risk for Rhenus
SELECT carrier_name, insurance_status, (CURRENT_DATE - last_inspection_date) AS days_since_inspection
FROM fmcsa_carrier_compliance
WHERE insurance_status = 'Lapsed'
GROUP BY carrier_name, insurance_status, days_since_inspection
ORDER BY days_since_inspection DESC;
