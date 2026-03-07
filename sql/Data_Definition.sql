show databases;
CREATE DATABASE last_mile_project;
USE last_mile_project;
SHOW TABLES;

USE last_mile_project;

CREATE TABLE counties (
    county_fips VARCHAR(5) PRIMARY KEY,
    county_name VARCHAR(100),
    state_fips VARCHAR(2)
);

CREATE TABLE overdose_deaths (
    id INT AUTO_INCREMENT PRIMARY KEY,
    county_fips VARCHAR(5),
    year INT,
    deaths DECIMAL(8,2),
    population DECIMAL(12,2),
    crude_rate DECIMAL(8,2),
    is_suppressed BOOLEAN,
    FOREIGN KEY (county_fips) REFERENCES counties(county_fips)
);

CREATE TABLE pharmacy_access (
    county_fips VARCHAR(5) PRIMARY KEY,
    tot_tracts DECIMAL(8,2),
    phar_ct_tm_dr DECIMAL(8,2),
    phar_tm_dr_p DECIMAL(8,2),
    phar_av_tm_dr DECIMAL(8,2),
    pharmacy_desert BOOLEAN,
    FOREIGN KEY (county_fips) REFERENCES counties(county_fips)
);

CREATE TABLE socioeconomic (
    county_fips VARCHAR(5) PRIMARY KEY,
    unemployment_rate DECIMAL(5,2),
    median_income DECIMAL(12,2),
    uninsured_rate DECIMAL(5,2),
    poverty_rate DECIMAL(5,2),
    FOREIGN KEY (county_fips) REFERENCES counties(county_fips)
);

SHOW TABLES;
