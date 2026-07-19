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
