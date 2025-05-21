CREATE TABLE food_inflation (
    date               DATE,
    year               INT,
    month              INT,
    month_name         VARCHAR(15),
    country            VARCHAR(50),
    iso3               CHAR(3),
    inflation          NUMERIC(10, 2),
    inflation_change   NUMERIC(10, 2)
);

-- ===========================================================
-- SECTION 1: Exploratory Data Analysis (EDA)
-- These queries explore data quality and structure before analysis
-- ===========================================================

-- 1. Total number of records in the dataset
SELECT COUNT(*) AS total_records
FROM food_inflation;

-- 2. Unique countries represented
SELECT DISTINCT country
FROM food_inflation
ORDER BY country;

-- 3. Time coverage: distinct years and months
SELECT DISTINCT year, month
FROM food_inflation
ORDER BY year DESC, month;

-- 4. Summary statistics for inflation and inflation change
SELECT 
    ROUND(MIN(inflation), 2) AS min_inflation,
    ROUND(MAX(inflation), 2) AS max_inflation,
    ROUND(AVG(inflation), 2) AS avg_inflation,
    ROUND(STDDEV(inflation), 2) AS stddev_inflation
FROM food_inflation;

-- 5. Check for missing or null values
SELECT 
    SUM(CASE WHEN inflation IS NULL THEN 1 ELSE 0 END) AS null_inflation,
    SUM(CASE WHEN inflation_change IS NULL THEN 1 ELSE 0 END) AS null_inflation_change
FROM food_inflation;

-- 6. Distribution of records by country and year
SELECT 
    country,
    year,
    COUNT(*) AS record_count
FROM food_inflation
GROUP BY country, year
ORDER BY country, year;


-- ===========================================================
-- SECTION 2: Business Analysis Queries
-- These queries uncover patterns and insights in food inflation
-- ===========================================================

-- 7. Monthly average inflation trend across all countries
SELECT 
    year,
    month,
    ROUND(AVG(inflation), 2) AS avg_inflation
FROM food_inflation
GROUP BY year, month
ORDER BY year, month;

-- 8. Top 5 countries with the highest average inflation over time
SELECT 
    country,
    ROUND(AVG(inflation), 2) AS avg_inflation
FROM food_inflation
GROUP BY country
ORDER BY avg_inflation DESC
LIMIT 5;

-- 9. Inflation volatility: countries with the highest standard deviation
--    Shows which countries experienced the most unstable inflation
SELECT 
    country,
    ROUND(STDDEV(inflation), 2) AS inflation_volatility
FROM food_inflation
GROUP BY country
ORDER BY inflation_volatility DESC
LIMIT 5;

-- 10. Country-level inflation change by year
--     Highlights year-on-year changes per country
SELECT 
    country,
    year,
    ROUND(AVG(inflation_change), 2) AS avg_inflation_change
FROM food_inflation
GROUP BY country, year
ORDER BY country, year;

-- 11. Monthly inflation trend for a specific country (e.g., Nigeria)
SELECT 
    month_name,
    ROUND(AVG(inflation), 2) AS avg_inflation
FROM food_inflation
WHERE country = 'Nigeria'
GROUP BY month_name
ORDER BY TO_DATE(month_name, 'Month');

-- 12. Countries with significant inflation spikes (change > 5%)
SELECT 
    country,
    year,
    month,
    inflation_change
FROM food_inflation
WHERE inflation_change > 5
ORDER BY inflation_change DESC;


-- 13. Country with the highest inflation in each year
--     Useful for year-by-year headline reporting
SELECT DISTINCT ON (year)
    year,
    country,
    ROUND(inflation, 2) AS inflation
FROM food_inflation
ORDER BY year, inflation DESC;

-- 14. Compare inflation trends between two countries (e.g., Nigeria vs Kenya)
--     Helps assess relative food affordability
SELECT 
    year,
    month,
    country,
    ROUND(AVG(inflation), 2) AS avg_inflation
FROM food_inflation
WHERE country IN ('Nigeria', 'Kenya')
GROUP BY year, month, country
ORDER BY year, month, country;

-- 15. Identify months with deflation (negative inflation change)
--     Deflation can signal declining demand or overproduction
SELECT 
    country,
    year,
    month,
    inflation_change
FROM food_inflation
WHERE inflation_change < 0
ORDER BY year, month;

-- 16. Rank countries by average inflation per year
--     Enables annual benchmarking across regions
SELECT 
    year,
    country,
    ROUND(AVG(inflation), 2) AS avg_inflation,
    RANK() OVER (PARTITION BY year ORDER BY AVG(inflation) DESC) AS inflation_rank
FROM food_inflation
GROUP BY year, country
ORDER BY year, inflation_rank;

-- 17. Countries with consistent monthly inflation increases
--     Detects sustained inflation build-up (3 consecutive increases)
WITH lagged_data AS (
    SELECT *,
        LAG(inflation, 1) OVER (PARTITION BY country ORDER BY year, month) AS prev_1,
        LAG(inflation, 2) OVER (PARTITION BY country ORDER BY year, month) AS prev_2
    FROM food_inflation
)
SELECT 
    country,
    year,
    month,
    inflation
FROM lagged_data
WHERE inflation > prev_1 AND prev_1 > prev_2
ORDER BY country, year, month;

-- 18. Year with highest inflation volatility per country
--     Useful for forecasting and country risk profiling
SELECT 
    country,
    year,
    ROUND(STDDEV(inflation), 2) AS yearly_volatility
FROM food_inflation
GROUP BY country, year
ORDER BY yearly_volatility DESC;

-- 19. Average inflation by quarter (seasonal impact)
--     Requires calculating quarter from month
SELECT 
    country,
    year,
    CEIL(month / 3.0)::INT AS quarter,
    ROUND(AVG(inflation), 2) AS avg_quarterly_inflation
FROM food_inflation
GROUP BY country, year, quarter
ORDER BY country, year, quarter;


