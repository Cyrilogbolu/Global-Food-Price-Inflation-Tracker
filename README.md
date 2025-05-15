
# Global Food Price Inflation Tracker

This project explores trends in global food price inflation using the World Bank's real-time price dataset. I simulate the role of a data analyst working to uncover regional disparities, price volatility, and economic patterns that affect food affordability across countries.

---

## Project Goals

- Analyze monthly food price inflation by country
- Identify the most volatile and stable food markets
- Track changes over time and spot inflation spikes
- Correlate inflation patterns across regions

---

## Dataset Overview

- Source: [World Bank Real-Time Food Price Dataset](https://microdata.worldbank.org/index.php/catalog/4509)
- Size: 7,558 rows, 8 columns
- Key fields: `date`, `country`, `Inflation`, `Open`, `Close`, `ISO3`

---

## Tools Used

- **Pandas** for data wrangling
- **Matplotlib & Seaborn** for static visualizations
- **Plotly** for interactive and animated visualizations
- **Jupyter Notebook** for exploratory data analysis

---

## Key Analysis Performed

- Converted and extracted time components (year, month) from dates
- Cleaned missing values, especially in `Inflation`
- Generated global trend line and country-level comparisons
- Calculated month-over-month inflation change rates
- Created a 6-month rolling average to smooth global trends
- Computed volatility (standard deviation) of inflation per country
- Built a correlation matrix to understand regional inflation alignment

---

## Insights

- Countries like **Lebanon, Zimbabwe, and Argentina** showed extreme food price volatility.
- More stable countries included **Japan, Switzerland, and the USA**.
- Global inflation peaked around 2022 before tapering in some regions.
- Strong correlations were observed among countries in the same economic blocs (e.g., BRICS or Sub-Saharan Africa).

---

## Interactive Dashboard Features

- **Line chart:** Compare food inflation trends across selected countries
- **Animated chart:** Watch monthly trends evolve over time
- **Heatmap:** Explore inflation pattern similarities via correlation

---

## Files

| File | Description |
|------|-------------|
| `WLD_RTFP_country_2025-05-05.csv` | Raw dataset from the World Bank |
| `cleaned_food_inflation.csv` | Cleaned and processed data |
| `Global_Inflation_EDA.ipynb` | Full analysis notebook with visualizations |
| `dashboard_screenshot.png` | Preview of interactive results |

---

## What This Project Demonstrates

- Practical data analysis skills from raw CSV to insight
- Visualization proficiency using static and interactive charts
- Real-world economic context with data-driven recommendations




