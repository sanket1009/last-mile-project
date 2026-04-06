USE last_mile_project;

-- Query 1: Average opioid death rate by county with pharmacy access
SELECT 
    c.county_fips,
    c.county_name,
    c.state_fips,
    AVG(o.crude_rate) as avg_crude_rate,
    SUM(o.is_suppressed) as suppressed_years,
    p.phar_tm_dr_p,
    p.phar_av_tm_dr,
    p.pharmacy_desert
FROM counties c
LEFT JOIN overdose_deaths o ON c.county_fips = o.county_fips
LEFT JOIN pharmacy_access p ON c.county_fips = p.county_fips
GROUP BY c.county_fips, c.county_name, c.state_fips, 
         p.phar_tm_dr_p, p.phar_av_tm_dr, p.pharmacy_desert
ORDER BY avg_crude_rate DESC
LIMIT 20;

-- Query 2: Pharmacy desert counties with highest mortality
SELECT 
    c.county_name,
    c.state_fips,
    AVG(o.crude_rate) as avg_crude_rate,
    p.phar_av_tm_dr as avg_drive_time_mins,
    p.phar_tm_dr_p as pct_tracts_covered
FROM counties c
JOIN overdose_deaths o ON c.county_fips = o.county_fips
JOIN pharmacy_access p ON c.county_fips = p.county_fips
WHERE p.pharmacy_desert = 1
GROUP BY c.county_fips, c.county_name, c.state_fips, 
         p.phar_av_tm_dr, p.phar_tm_dr_p
ORDER BY avg_crude_rate DESC
LIMIT 20;

-- Query 3: Socioeconomic profile of desert vs non-desert counties
SELECT 
    p.pharmacy_desert,
    COUNT(*) as county_count,
    ROUND(AVG(s.poverty_rate), 2) as avg_poverty_rate,
    ROUND(AVG(s.median_income), 0) as avg_median_income,
    ROUND(AVG(s.uninsured_rate), 2) as avg_uninsured_rate,
    ROUND(AVG(o.crude_rate), 2) as avg_crude_rate
FROM counties c
JOIN pharmacy_access p ON c.county_fips = p.county_fips
JOIN socioeconomic s ON c.county_fips = s.county_fips
JOIN overdose_deaths o ON c.county_fips = o.county_fips
GROUP BY p.pharmacy_desert;