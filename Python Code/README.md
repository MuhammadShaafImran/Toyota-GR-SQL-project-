<p align="center">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQQPTZ2WWs-tH4ujsO7cjSrPaxHqThTKBneQ&s" 
       alt="Toyota GR Cup Banner" 
       width="100%">
</p>

# Toyota GR Cup - Data Extraction & Analysis Suite

Python-based data extraction and preprocessing tools for Toyota GR Cup racing data. This module handles web scraping, data cleaning, and exploratory analysis of racing championship data.

## Purpose

This Python suite serves as the **data ingestion layer** for the Toyota GR Cup analytics platform, responsible for:
- Extracting racing data from web sources
- Processing and structuring CSV files
- Performing initial data exploration
- Generating clean datasets for the SQL pipeline

## Components

### Data Link Management
- **`extracting_raw_links.py`** - Web scraping script for collecting CSV data links
- **`data_links.ipynb`** - Notebook for processing and organizing data URLs
- **Output**: Structured links for automated data collection

### Data Exploration
- **`exploring_data.ipynb`** - Interactive data analysis notebook
  - Driver championship data exploration
  - Team performance analysis
  - Race results investigation
  - Data quality assessment

### Output Management  
- **`output/`** directory containing:
  - `raw_csv_links.csv` - Extracted web links to race data
  - `all_csv_links.csv` - Processed and categorized data links

## Dependencies

```python
selenium==4.16.0      # Web scraping automation
webdriver-manager==4.0.1  # Chrome driver management
requests==2.31.0      # HTTP requests
pandas               # Data manipulation
numpy                # Numerical computing
```

## Quick Start

### Installation
```bash
# Create virtual environment (recommended)
python -m venv venv
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Linux/Mac

# Install dependencies
pip install -r requirements.txt
```

### Usage

1. **Extract Data Links**
   ```bash
   python extracting_raw_links.py
   ```

2. **Process Links** (Jupyter)
   ```bash
   jupyter notebook data_links.ipynb
   ```

3. **Explore Data** (Jupyter)
   ```bash
   jupyter notebook exploring_data.ipynb
   ```

## Data Flow

```
Web Sources → extracting_raw_links.py → raw_csv_links.csv
     ↓
data_links.ipynb → all_csv_links.csv
     ↓
exploring_data.ipynb → Data Insights
     ↓
SQL Bronze Layer (../Scripts/generic/bronze/)
```

## Supported Race Tracks

The scripts automatically process data from:
- **Sonoma Raceway**
- **Barber Motorsports Park**
- **Circuit of the Americas**
- **Indianapolis Motor Speedway RC**
- **Road America**  
- **Sebring International Raceway**
- **VIRginia International Raceway**

## Data Types Extracted

- **Championship Standings**: Driver and team points
- **Race Results**: Provisional and official results
- **Lap Analysis**: Detailed timing and sector data
- **Weather Data**: Track conditions and meteorology
- **Performance Metrics**: Best lap times and analysis

## Key Features

### Automated Web Scraping
- Selenium-powered data extraction
- Robust error handling and retry logic
- Configurable for different race series

### Data Structuring
- CSV link categorization by track and race
- Pandas-based data manipulation
- Export to multiple formats

### Interactive Analysis
- Jupyter notebook interface
- Visualization-ready data preparation
- Statistical summaries and insights

## Integration

This Python module integrates seamlessly with the main project's SQL pipeline:

```
Python Scripts → Bronze Layer → Silver Layer → Gold Layer
```

The processed CSV links and cleaned data feed directly into the SQL Server bronze layer procedures for further processing.

##  Performance Notes

- **Web Scraping**: Respects rate limits and implements delays
- **Memory Usage**: Efficient pandas operations for large datasets
- **File I/O**: Optimized CSV reading with appropriate encodings

## Troubleshooting

### Common Issues

**WebDriver Errors**
```bash
# Update Chrome driver
pip install --upgrade webdriver-manager
```

**CSV Encoding Issues**
```python
# Use UTF-8 encoding explicitly
pd.read_csv('file.csv', encoding='utf-8')
```

**Memory Issues with Large Files**
```python
# Process in chunks
for chunk in pd.read_csv('large_file.csv', chunksize=1000):
    process_chunk(chunk)
```

## Configuration

Key parameters can be modified in the notebooks:

```python
# Data filtering parameters
Season = 'SRO'
Year = '2025'
Races = ('Race 1','Race 2')
RaceEvent = 'TGRNA GR CUP NORTH AMERICA'
```

---

*Part of the Toyota GR Cup Data Analytics Platform*