![Toyota GR Cup Banner](https://images.unsplash.com/photo-1709142224119-3f5b86d78239?w=1200&auto=format&fit=crop&q=80)

# Toyota GR Cup Data Analytics Platform

A comprehensive data analytics platform for Toyota GR Cup North America racing series, implementing a modern medallion architecture data pipeline for race performance analysis and championship tracking.

## Project Overview

This project processes and analyzes racing data from the Toyota GR Cup championship series, featuring data from multiple prestigious race tracks including Barber Motorsports Park, Circuit of the Americas, Indianapolis Motor Speedway, Road America, Sebring, Sonoma Raceway, and VIRginia International Raceway.

##  Architecture

The project implements a **Medallion Architecture** with three distinct layers:

- **Bronze Layer** ✅ *Completed*
  - Raw data ingestion from CSV sources
  - Data validation and basic cleansing
  - Automated ETL procedures for multiple file formats

- **Silver Layer** 🚧 *In Development*
  - Data transformation and standardization
  - Business logic implementation
  - Data quality improvements

- **Gold Layer** 📋 *Planned*
  - Aggregated analytics-ready datasets
  - Championship standings calculations
  - Performance metrics and KPIs

## Data Sources

### Race Events Included
- **Sonoma Raceway**
- **Barber Motorsports Park**  
- **Circuit of the Americas**
- **Indianapolis Motor Speedway RC**
- **Road America**
- **Sebring International Raceway**
- **VIRginia International Raceway**

### Data Types
- Driver championship standings
- Team championship standings
- Race results (provisional and official)
- Lap analysis and timing data
- Weather conditions
- Best lap performance metrics

## Technology Stack

### Database
- **SQL Server** - Primary data warehouse
- **SQL Server Management Studio** - Database management

### Data Processing
- **Python** - Data extraction and preprocessing
- **Pandas & NumPy** - Data manipulation
- **Selenium** - Web scraping automation
- **Jupyter Notebooks** - Exploratory data analysis

## Project Structure

```
├── data/                           # Raw CSV data organized by track
├── Python Code/                    # Data extraction and exploration scripts
├── Scripts/
│   ├── generic/
│   │   └── bronze/                # Bronze layer implementation ✅
│   └── specific/                  # Track-specific procedures
└── zipped/                        # Archived data
```

## Getting Started

### Prerequisites
- SQL Server (2019 or later recommended)
- Python 3.8+
- SQL Server Management Studio

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd "Toyota GR (SQL project)"
   ```

2. **Set up Python environment**
   ```bash
   cd "Python Code"

   pip install -r requirements.txt
   ```

3. **Configure database**
   - Execute bronze layer scripts in SQL Server
   - Run `bronze.create_tables` procedure
   - Configure data source paths

4. **Load initial data**
   ```powershell
   .\load_script.ps1
   ```

## Current Status

| Component | Status | Description |
|-----------|--------|-------------|
| Data Acquisition | ✅ Complete | Web scraping and CSV extraction |
| Bronze Layer | ✅ Complete | Raw data ingestion pipeline |
| Silver Layer | 🚧 In Progress | Data transformation layer |
| Gold Layer | 📋 Planned | Analytics and aggregation layer |
| Visualization | 📋 Planned | Dashboard and reporting |

## Data Pipeline

1. **Extract**: Python scripts collect race data from official sources
2. **Transform**: Bronze layer procedures standardize and validate data
3. **Load**: Structured data stored in SQL Server tables
4. **Analyze**: *(Silver/Gold layers under development)*

##  Analytics Capabilities *(Planned)*

- Driver performance trending
- Team championship predictions  
- Track-specific analysis
- Weather impact correlations
- Lap time optimization insights

## 📝 License

See [LICENSE](LICENSE) file for details.

---

*Built for the Toyota GR Cup racing community* 🏎️ 
