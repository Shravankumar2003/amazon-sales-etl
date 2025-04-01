🚀 Amazon Sales ETL This pipeline extracts Amazon sales data from Kaggle, transforms it in Jupyter Notebook, and loads it into MSMS SQL for analysis. Uncover trends and insights from raw data to make smarter business decisions. 📊📈 Ready to see how data drives success? Dive in!🔥

# Amazon Sales ETL 🚀

This project implements an **ETL (Extract, Transform, Load)** pipeline for Amazon sales data. The pipeline extracts data from Kaggle, transforms it using Jupyter Notebook, and loads the cleaned data into a SQL table for further analysis.

## Project Workflow

1. **Extract**:  
   The Amazon sales dataset is fetched from Kaggle using the Kaggle API.

2. **Transform**:  
   The raw data is processed and cleaned using **Pandas** in a Jupyter Notebook.  
   The transformation process involves:
   - Handling missing values
   - Data type conversions
   - Aggregating and restructuring data for analysis

3. **Load**:  
   The transformed data is then loaded into a **SQL table** using **SQLAlchemy** for efficient querying and storage.

## Features
- **Data Extraction**: Importing data directly from Kaggle.
- **Data Transformation**: Cleaning, processing, and structuring data using Pandas.
- **Data Loading**: Storing the processed data into a SQL database for deeper analysis.

## Installation & Setup

### Prerequisites:
Make sure you have the following installed:
- Python 3.x
- Jupyter Notebook
- MSMS SQL

### Steps to Run the Project:

1. **Install Dependencies**:
   Install the required Python libraries:
   ```bash
   pip install pandas
   pip install sqlalchemy
