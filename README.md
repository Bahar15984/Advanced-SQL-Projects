# Advanced SQL Projects  

This repository contains advanced SQL case studies implemented on **SQL Server 2022** using **Docker**.  
It includes **Banking KPIs**, **Product Sales Analysis**, and **Transaction Management** with optimized queries and scripts.  

---

## Project Structure  

analysis/              # Case study SQL queries  
│   ├── bank_analysis_part1.sql  
│   ├── bank_analysis_part2.sql  
│   ├── product_sales_analysis.sql  
│   └── shopify_case_study.sql  
│  
├── schema/            # Database creation and setup scripts  
│   ├── 00_create_database.sql  
│   ├── 01_create_tables.sql  
│   └── 02_insert_data.sql  
│  
├── reports/           # KPI queries and optimization notes  
│   ├── kpi_queries.sql  
│   └── optimization_notes.md  
│  
├── docker/            # Docker setup for SQL Server  
│   └── docker-compose.yml  
│  
├── scripts/           # Shell scripts to run SQL files  
│   ├── run_all.sh  
│   └── run_file.sh  
│  
├── .gitignore         # Git ignored files  
├── .env               # Environment variables (NOT uploaded)  
└── README.md          # Project documentation  

---

## Getting Started  

### 1. Run SQL Server with Docker  
Make sure Docker is installed and running:  
docker compose -f docker/docker-compose.yml up -d  

### 2. Run All SQL Scripts  
Execute schema and data population scripts:  
./scripts/run_all.sh  

Or run a single SQL file:  
./scripts/run_file.sh schema/01_create_tables.sql  

---

## Features  
- Banking KPI analysis (profitability, loan performance, customer segmentation)  
- Product sales performance with revenue, discount, and margin analysis  
- Transaction monitoring and case study with Shopify dataset  
- Query optimization using indexing, joins, and CTEs  

---

## Technologies  
- SQL Server 2022 (via Docker)  
- T-SQL (queries, joins, window functions, indexing)  
- Bash scripts (automation)  

---

## Notes  
- Store credentials in `.env` file (ignored by Git)  
- Ensure Docker is running before executing SQL scripts  
- Contributions and suggestions are welcome!  

---

## Author  
**Bahar Almasi**  
[LinkedIn](https://www.linkedin.com/in/baharal/)  
[GitHub](https://github.com/Bahar15984)
